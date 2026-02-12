import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:solar_web/constants/constant.dart';

class ApiInterceptor extends Interceptor{

  String? myPath;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    /// give token to header
    var access = GetStorage().read(AppConstants.accessToken);
    print(access);

    if(!options.path.contains('token')){
      options.headers["authorization"] = 'Bearer $access';
    }



    print('Request ======>' + options.path);
    myPath = options.path + options.queryParameters.toString();
    print(myPath);


  }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   super.onError(err, handler);
  //
  //
  //   /// get new access token if previous token is expired
  //
  //
  //
  //
  //   if (err.response!.statusCode == 500 ||
  //       err.response!.statusCode == 503) {
  //     Get.snackbar('خطا', 'خطا در اتصال به سرور');
  //   }
  //
  //
  //   print(myPath! +'  == >>  '+ err.response.toString());
  //
  //
  //
  // }

}