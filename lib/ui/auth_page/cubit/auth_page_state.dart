part of 'auth_page_cubit.dart';

@immutable
sealed class AuthPageState {}

final class AuthPageInitial extends AuthPageState {}

final class AuthPageInitializing extends AuthPageState {}

final class AuthPageLoading extends AuthPageState {}

final class AuthPageSuccess extends AuthPageState {
  final bool animateTransition;

  AuthPageSuccess({this.animateTransition = true});
}

final class AuthPageError extends AuthPageState {
  final String message;

  AuthPageError(this.message);
}
