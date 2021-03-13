import 'package:dio/dio.dart';
import 'package:infiniteScrollWithGetxDio/models/pagination_filter.dart';
import 'package:infiniteScrollWithGetxDio/models/user_model.dart';

class UserRepository {
  Dio _dio;

  UserRepository(
    this._dio
  );

  Future<List<UserModel>> findAll(PaginationFilter filter) {
    return _dio.get('/users', queryParameters: {
      'page': filter.page,
      'limit': filter.limit,
    }).then((res) => res?.data?.map<UserModel>((u) => UserModel.fromMap(u))?.toList());
  }
}