// import 'package:dio/dio.dart';
// import 'package:hani_almutairi_logistic/models/search_city.dart';
// import 'package:hani_almutairi_logistic/services/web_api.dart';

// class OrderService {
//   Future<List<SearchCityModel>> getCities(filter) async {
//     var response = await Dio().get(
//       '${WebApi.getCitiesURL}',
//       queryParameters: {"filter": filter},
//       options: Options(
//         headers: {"api_Key": '${WebApi.apiKey}'},
//       ),
//     );
//     print(response);

//     var models = SearchCityModel.fromJsonList(response.data);
//     return models;
//   }
// }
