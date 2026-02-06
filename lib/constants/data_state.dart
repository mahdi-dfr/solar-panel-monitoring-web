
abstract class DataState<T>{
  final T? data;
  final String? error;

  const DataState(this.data, this.error);
}

class DataSuccess<T> extends DataState<T>{
  const DataSuccess(T? data) : super(data, null);
}

class DataFailed<T> extends DataState<T>{
  const DataFailed(String error) : super(null, error);

}


abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("اتصال اینترنت برقرار نیست");
}

class ServerFailure extends Failure {
  const ServerFailure() : super("خطای سرور رخ داده است");
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super("نام کاربری یا رمز اشتباه است");
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super("خطای غیرمنتظره رخ داده");
}
