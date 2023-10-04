import 'package:fpdart/fpdart.dart';

typedef FutureEitherFailureOr<T> = Future<Either<Failure, T>>;

enum Locale {
  local,
  state,
  national,
  global,
}

class Failure {
  final String message;
  Failure(this.message);
}
