import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screen/bottom_navigation_bar.dart';
import 'package:weather_app/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _determinePosition(),
        builder: (context,snap){
          if(snap.hasData){
            debugPrint("snap ${snap.data as Position}");


            return BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc()..add(FetchWeatherByCurrentLocation(snap.data as Position)),
              child: const BottomNavBarScreen(),
            );
          }
          else{
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },

      ),
    );
  }

}


Future<Position> _determinePosition () async{
  bool serviceEnable;
  LocationPermission locationPermission;

  serviceEnable =await Geolocator.isLocationServiceEnabled();

  if(!serviceEnable){
    return Future.error("Location services are disabled");
  }

  locationPermission= await Geolocator.checkPermission();

  if(locationPermission==LocationPermission.denied){
    locationPermission =await Geolocator.requestPermission();

  }
  if(locationPermission==LocationPermission.deniedForever){
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}
