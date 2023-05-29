import '../model/http_client_request_params.dart';
import '../model/http_client_response.dart';

typedef ProgressCallback = void Function(int count, int total);

abstract class IHttpClient {
  Future<HttpClientResponse> request(HttpClientRequestParams params);
  Future<HttpClientResponse> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });
  Future<HttpClientResponse> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });
}
