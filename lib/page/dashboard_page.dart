import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/config/app_color.dart';
import 'package:laundri/config/app_constants.dart';
import 'package:laundri/providers/dashboard_provider.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(builder: (_, wiRef, __) {
          int navIndex = wiRef.watch(dashboardNavIndexProvider);
          return AppConstants.dashbaordNavMenu[navIndex]['view'] as Widget;
        }),
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
          child: Consumer(builder: (_, wiRef, __) {
            int navIndex = wiRef.watch(dashboardNavIndexProvider);
            return Material(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              elevation: 8,
              child: BottomNavigationBar(
                currentIndex: navIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconSize: 30,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  wiRef.read(dashboardNavIndexProvider.notifier).state = value;
                },
                showSelectedLabels: false,
                showUnselectedLabels: false,
                unselectedItemColor: Colors.grey,
                selectedItemColor: AppColor.primary,
                items: AppConstants.dashbaordNavMenu.map((e) {
                  return BottomNavigationBarItem(
                    icon: Icon(e['icon']),
                    label: e['label'],
                    backgroundColor: Colors.transparent,
                  );
                }).toList(),
              ),
            );
          }),
        ));
  }
}
