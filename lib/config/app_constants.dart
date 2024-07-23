import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:laundri/page/dashboard_view/account_view.dart';
import 'package:laundri/page/dashboard_view/home_view.dart';

class AppConstants {
  static const appName = "Go Laundri";

  static const _host = 'http://192.168.43.222:8000';

  static const baseUrl = '$_host/api';

  static const baseImageUrl = '$_host/storage';

  static const laundryStatus = [
    'SUKSES',
    'PROSES',
    'PICKUP',
  ];

  static List<Map> dashbaordNavMenu = [
    {
      'view' : const HomePage(),
      'icon': Icons.home_filled,
      'label': 'Home',
    },
    {
      'view': DView.empty('Laundri Saya'),
      'icon' : Icons.local_laundry_service,
      'label' : 'My Laundri',
    },
    {
      'view' : const AccountView(),
      'icon' : Icons.account_circle_rounded,
      'label' : 'My Account',
    }
  ];

  static const homeCategories = [
    'All',
    'Regular',
    'Express',
    'Professional',
    'Jago'
  ];
}
