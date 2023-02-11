import 'package:dio/dio.dart';
import 'package:flutter_blocs_demo/model/beers_response.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../constants/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BeersRepository {
  final dio = Dio();
  final log = Logger();


  Future<Either<String, List<BeerResponseModel>>> getBeers () async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      try {
        final response = await dio.get('${Constants.kBaseUrl}/beers');
        final beers = (response.data as List).map((e) => BeerResponseModel.fromJson(e)).toList();
        return Right(beers);
      } on DioError catch (e) {
        return Left(e.message);
      }
    }else {
      return const Left('No internet connection');
    }

  }
}