part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];

}

class FetchWeatherByCurrentLocation extends WeatherEvent
{
  final Position position;

  const FetchWeatherByCurrentLocation(this.position);

  @override
  List<Object> get props => [position];

}

class FetchWeatherByCityName extends WeatherEvent
{
  final String cityName;

  const FetchWeatherByCityName(this.cityName);

  @override
  List<Object> get props => [cityName];

}

