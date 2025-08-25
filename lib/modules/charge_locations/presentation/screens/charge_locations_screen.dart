import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voltspot/core/core_compoent/app_text_field.dart';
import 'package:voltspot/core/core_compoent/custom_appbar.dart';
import 'package:voltspot/core/core_compoent/empty_component.dart';
import 'package:voltspot/core/core_compoent/loading_compoent.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';
import 'package:voltspot/modules/charge_locations/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';
import 'package:voltspot/modules/charge_locations/presentation/components/charge_location_card.dart';

import '../../../../core/core_compoent/failure_component.dart';
import '../../../../core/utils/base_state.dart';

class ChargeLocationsScreen extends StatefulWidget {
  const ChargeLocationsScreen({super.key});

  @override
  State<ChargeLocationsScreen> createState() => _ChargeLocationsScreenState();
}

class _ChargeLocationsScreenState extends State<ChargeLocationsScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    context.read<ChargeLocationsBloc>().add(SearchCityChanged(value));
    setState(() {}); // just for the X button visibility
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Charge Locations',
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            _buildSearchBar(),
            // List / states
            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: BlocBuilder<ChargeLocationsBloc,
          BaseState<List<ChargeLocationEntity>>>(
        builder: (context, state) {
          if (state.isInit) {
            return const Center(child: Text("Write a city name to start searching"),);

          }if (state.isLoading) return const LoadingComponent();
            if (state.isError) {
              return FailureComponent(failure: state.failure, retry: () {
              final city = _controller.text.trim();
              context
                  .read<ChargeLocationsBloc>()
                  .add(GetChargeLocationsEvent(city: city));
            },);
            }

          if (state.isSuccess) {
            final items = state.data ?? const <ChargeLocationEntity>[];
            if (items.isEmpty) {
              return const EmptyComponent();
            }

            return RefreshIndicator(
              onRefresh: () async {
                final city = _controller.text.trim();
                context
                    .read<ChargeLocationsBloc>()
                    .add(GetChargeLocationsEvent(city: city));
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final ChargeLocationEntity loc = items[index];

                  return ChargeLocationCard(loc: loc);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Padding _buildSearchBar() {
    return Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 8),
            child: AppTextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              hintText: 'Search by city (e.g., Amsterdam)',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : IconButton(
                icon: const Icon(Icons.clear, color: Colors.black,),
                onPressed: () {
                  _controller.clear();
                  context
                      .read<ChargeLocationsBloc>()
                      .add(const GetChargeLocationsEvent(city: ""));
                  setState(() {}); // update suffixIcon
                }),
            ),
          );
  }
}
