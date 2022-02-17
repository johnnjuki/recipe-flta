import 'dart:io';

import 'package:http/http.dart';

const String apiKey = 'f0f7fef63f6660099cef5351921e5397';
const String apiId = '2d893c77';
const String apiUrl = 'https://api.edamam.com/search';

class RecipeService {
  Future getData(String url) async {
    print('Calling url: $url');
    try {
      final response = await get(Uri.parse(url));
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        return response.body;
      }
    } on SocketException catch (error) {
      print(error);
    } on HttpException catch (error) {
      print(error);
    }
  }

  Future<dynamic> getRecipes(String query, int from, int to) async {
    final recipeData = await getData(
      '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to',
    );
    return recipeData;
  }
}
