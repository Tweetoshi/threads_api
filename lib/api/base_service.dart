import 'package:dio/dio.dart';

abstract class _Service {
  Future<Response<dynamic>> get(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
  });

  Future<Response<dynamic>> post(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> body = const {},
  });

  Future<Response<dynamic>> delete(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
  });
}

abstract class BaseService implements _Service {
  BaseService({required String accessToken})
      : _helper = ServiceHelper(accessToken);

  final ServiceHelper _helper;
  @override
  Future<Response<dynamic>> get(
    String unencodedPath, {
    Map<String, String> headers = const {},
    Map<String, dynamic> queryParameters = const {},
  }) async =>
      _helper.get(
        unencodedPath,
        queryParameters: queryParameters,
      );

  @override
  Future<Response<dynamic>> post(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> body = const {},
  }) async =>
      _helper.post(
        unencodedPath,
        queryParameters: queryParameters,
        body: body,
      );

  @override
  Future<Response<dynamic>> delete(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
  }) async =>
      _helper.delete(unencodedPath, queryParameters: queryParameters);
}

class ServiceHelper {
  const ServiceHelper(
    this.accessToken,
  );

  final String accessToken;

  Future<Response<dynamic>> get(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    try {
      final response = Dio().get(
        unencodedPath,
        queryParameters: queryParameters.isEmpty
            ? {'access_token': accessToken}
            : queryParameters
          ..addAll({'access_token': accessToken}),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }

  Future<Response<dynamic>> post(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, String> body = const {},
  }) async {
    try {
      final response = Dio().post(
        unencodedPath,
        queryParameters: queryParameters.isEmpty
            ? {'access_token': accessToken}
            : queryParameters
          ..addAll({'access_token': accessToken}),
        data: body,
      );

      return response;
    } catch (e) {
      throw Exception('Failed to post data');
    }
  }

  Future<Response<dynamic>> delete(
    String unencodedPath, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    try {
      final response = Dio().delete(
        unencodedPath,
        queryParameters: queryParameters.isEmpty
            ? {'access_token': accessToken}
            : queryParameters
          ..addAll({'access_token': accessToken}),
      );

      return response;
    } catch (e) {
      throw Exception('Failed to delete data');
    }
  }
}
