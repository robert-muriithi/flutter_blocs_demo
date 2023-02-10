import 'package:dio/dio.dart';
import 'package:flutter_blocs_demo/model/beers_response.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../constants/constants.dart';

class BeersRepository {
  final dio = Dio();
  final log = Logger();

  Future<Either<String, List<BeerResponseModel>>> getBeers () async {
    try {
      final response = await dio.get('${Constants.kBaseUrl}/beers');
      final beers = (response.data as List).map((e) => BeerResponseModel.fromJson(e)).toList();
      return Right(beers);
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
}