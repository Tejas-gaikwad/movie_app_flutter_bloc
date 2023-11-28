import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import '../../data/models/api_response.dart';
import 'api_service.dart';

class ApiServiceImpl extends ApiService  {
  final Dio _dio = Dio();

  @override
  void init({required String baseUrl}) {

   final _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );


    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse> get({
    required String path,
    required int pageNo,
    Map<String, dynamic>? query,
  }) async {
    try {


      final response = await _dio.get(
        path,
        queryParameters: {'page': pageNo, 'per_page': 5}, // adjust parameters based on your API
      );
      return ApiResponse.fromDioResponse(
        response,
      );
    } on DioException catch (e) {
      print('Do Error ->>> ${e.response}');
      return ApiResponse.error(e.toString());
    } catch (e) {
      print('E ->>> ${e.toString()}');
      return ApiResponse.error(e.toString());
    }
  }
}