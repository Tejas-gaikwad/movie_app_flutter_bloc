import '../../data/models/api_response.dart';


abstract class ApiService {
  void init({required String baseUrl});

  Future<ApiResponse> get({required String path, required int pageNo, Map<String, dynamic>? query});
}