import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:laundri/config/app_constants.dart';
import 'package:laundri/config/app_failure.dart';
import 'package:laundri/config/app_request.dart';
import 'package:laundri/config/app_response.dart';
import 'package:laundri/config/app_session.dart';

class ShopDataSource {
  
  static Future<Either<Failure, Map>> readLimit() async {
    Uri url = Uri.parse('${AppConstants.baseUrl}/shop/recomended');
    final token = await AppSession.getBearerToken();
    try {
      final response = await http.get(
        url,
        headers:AppRequest.header(token) ,
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(FetchFailure(e.toString())); 
    }
  }

   static Future<Either<Failure, Map>> searchByCity(String name) async {
    Uri url = Uri.parse('${AppConstants.baseUrl}/shop/search/city/$name');
    final token = await AppSession.getBearerToken();
    try {
      final response = await http.get(
        url,
        headers:AppRequest.header(token) ,
      );
      final data = AppResponse.data(response);
      return Right(data);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(FetchFailure(e.toString())); 
    }
  }
}
