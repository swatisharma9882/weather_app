part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
}

final class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

final class WeatherBlocLoading extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

final class WeatherBlocFailure extends WeatherState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

final class WeatherBlocSuccess extends WeatherState{
  @override
  List<Object> get props => [weather];

  final Weather weather;

  const WeatherBlocSuccess(this.weather);



}