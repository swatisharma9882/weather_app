import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeatherByCityName>((event, emit)  async {
      debugPrint("eventcity $event");
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory("d1460cbb1db9c92ac65da4753af602be",
            language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByCityName(event.cityName);

        if (kDebugMode) {
          print("weather $weather");
        }
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
    on<FetchWeatherByCurrentLocation>((event, emit) async {
      debugPrint("event ${event.position}");

      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory("d1460cbb1db9c92ac65da4753af602be",
            language: Language.ENGLISH);

        Weather weather = await wf.currentWeatherByLocation(event.position.latitude, event.position.longitude);
        // Weather weather = await wf.currentWeatherByCityName(cityName)
        if (kDebugMode) {
          print("weather $weather");
        }
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        debugPrint("Error ${e}");
        emit(WeatherBlocFailure());
      }
    });
  }

  Stream<WeatherState> _mapFetchWeatherByCityToState(
      String cityName, emit) async* {
    emit(WeatherBlocLoading());
    try {
      WeatherFactory wf = WeatherFactory("d1460cbb1db9c92ac65da4753af602be",
          language: Language.ENGLISH);

      Weather weather = await wf.currentWeatherByCityName(cityName);

      if (kDebugMode) {
        print("weather $weather");
      }
      emit(WeatherBlocSuccess(weather));
    } catch (e) {
      emit(WeatherBlocFailure());
    }
  }

   _mapFetchCurrentWeatherToState(
      latitude, longitude, emit) async* {
    emit(WeatherBlocLoading());
    debugPrint("lat long $latitude , $longitude");
    try {
      WeatherFactory wf = WeatherFactory("d1460cbb1db9c92ac65da4753af602be",
          language: Language.ENGLISH);

      Weather weather = await wf.currentWeatherByLocation(latitude, longitude);
      // Weather weather = await wf.currentWeatherByCityName(cityName)
      if (kDebugMode) {
        print("weather $weather");
      }
      emit(WeatherBlocSuccess(weather));
    } catch (e) {
      debugPrint("Error ${e}");
      emit(WeatherBlocFailure());
    }
  }
}
