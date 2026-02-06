import 'package:solar_web/constants/data_state.dart';

abstract class UseCase<T , P>{
  Future<DataState<T>> call(P params);
}