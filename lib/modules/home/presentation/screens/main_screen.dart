import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voltspot/core/constants/app_colors.dart';
import 'package:voltspot/core/constants/app_gradient.dart';
import 'package:voltspot/core/constants/app_shadow.dart';
import 'package:voltspot/core/core_compoent/app_scaffold.dart';
import 'package:voltspot/core/paths/images_paths.dart';
import 'package:voltspot/core/services/service_locator.dart';
import 'package:voltspot/modules/charge_locations/presentation/screens/charge_locations_screen.dart';

import '../../../charge_locations/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void changeScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset(ImagesPaths.navbarIcons[0]),
        activeIcon: SvgPicture.asset(ImagesPaths.navbarIcons[0],
            color: AppColors.primary),
        label: "Home",
        backgroundColor: Colors.transparent
        ),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(ImagesPaths.navbarIcons[1]),
        activeIcon: SvgPicture.asset(ImagesPaths.navbarIcons[1],
            color: AppColors.primary),
        label: "Screen 2",
        backgroundColor: Colors.transparent
        ),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(ImagesPaths.navbarIcons[2]),
        activeIcon: SvgPicture.asset(ImagesPaths.navbarIcons[2],
            color: AppColors.primary),
        label: "Screen 3",
        backgroundColor: Colors.transparent),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(ImagesPaths.navbarIcons[3]),
        activeIcon: SvgPicture.asset(ImagesPaths.navbarIcons[3],
            color: AppColors.primary),
        label: "Screen 4",
        backgroundColor: Colors.transparent),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(ImagesPaths.navbarIcons[4]),
        activeIcon: SvgPicture.asset(ImagesPaths.navbarIcons[4],
            color: AppColors.primary),
        label: "Screen 5",
        backgroundColor: Colors.transparent),
  ];

  final List screens = [
    BlocProvider(
      create:  (_) => sl<ChargeLocationsBloc>(),
        child: const ChargeLocationsScreen()),
    const Center(child: Text("Screen 2"),),
    const Center(child: Text("Screen 3"),),
    const Center(child: Text("Screen 4"),),
    const Center(child: Text("Screen 5"),),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.blackGradient,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            boxShadow: [AppShadows.blackShadow],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.white,
              currentIndex: currentIndex,
              elevation: 0,
              items: bottomNavBarItems,
              onTap: changeScreen,
            ),
          ),
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
