import 'package:equatable/equatable.dart';

/// The [Failure] expresses failures in the application.
/// if an [Exception] occurs, the Excerption will be dealt with to turn one or more EXceptions into a Failure based on the application’s logic.
class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {required super.statusCode});

  @override
  String toString() => '${statusCode ?? ''} $message';
}

class NoInternetFailure extends Failure {
  NoInternetFailure() : super("No Internet Connection");
}

//! un known Failure
class UnknownFailure extends Failure {
  UnknownFailure() : super("Unexpected Error");
}




//! refresh token is invalid
class SessionExpiredFailure extends Failure {
  SessionExpiredFailure() : super("Session Expired");
}

