import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screen/home_screen.dart';
import 'package:weather_app/screen/search_by_city_name.dart';
import 'package:weather_app/screen/setting.dart';
import 'package:weather_app/screen/weather_forecast.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;

  List navBarPages = [
    const HomeScreen(),
    const SearchByCityNamePage(),
    const WeatherForecastPage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: navBarPages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 60,
        elevation: 10,
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) { setState(() {
          selectedIndex = index;
        });

          },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_filled,
              color: selectedIndex == 0 ? Colors.white : Colors.grey[700],
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search_rounded,
              color: selectedIndex == 1 ? Colors.white : Colors.grey[700],
            ),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.calendar_today_rounded,
              color: selectedIndex == 2 ? Colors.white : Colors.grey[700],
            ),
            label: "Forcast",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings,
              color: selectedIndex == 3 ? Colors.white : Colors.grey[700],
            ),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
