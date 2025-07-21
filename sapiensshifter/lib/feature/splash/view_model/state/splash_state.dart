import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashSuccess extends SplashState {
  // auto_route için PageRouteInfo
  const SplashSuccess({required this.route});
  final PageRouteInfo route;
  @override
  List<Object> get props => [route];
}

class SplashError extends SplashState {
  const SplashError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
