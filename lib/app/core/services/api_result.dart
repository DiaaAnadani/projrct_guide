import 'failure.dart';

class ApiResult<T>{
  Failure? failure;
  T? data;

  ApiResult(this.failure , this.data);
}