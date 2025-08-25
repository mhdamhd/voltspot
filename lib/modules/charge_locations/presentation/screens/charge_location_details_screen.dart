import 'package:flutter/material.dart';
import 'package:voltspot/modules/charge_locations/domain/entities/charge_location_entity.dart';
import '../../../../core/core_compoent/app_scaffold.dart';
import '../../../../core/core_compoent/custom_appbar.dart';
import '../components/evse_card.dart';

class ChargeLocationDetailsScreen extends StatelessWidget {
  final ChargeLocationEntity location;

  const ChargeLocationDetailsScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final total = location.totalEvses;
    final available = location.availableEvses;

    return AppScaffold(
      appBar: const CustomAppBar(
        titleText: 'Location Details',
        withBack: true,
        // centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          // Header
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.address,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text('${location.city}, ${location.country}', style: const TextStyle(color: Colors.black),),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.ev_station),
                      const SizedBox(width: 8),
                      Text('$available / $total available', style: const TextStyle(color: Colors.black),),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
          Text('EVSEs', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),

          // EVSE list
          ...location.evses.map((e) => EvseCard(evse: e)),
        ],
      ),
    );
  }
}
