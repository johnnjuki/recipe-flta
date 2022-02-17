import 'package:chopper/chopper.dart';

import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';
import 'service_interface.dart';

part 'recipe_service.chopper.dart';

const String apiKey = 'f0f7fef63f6660099cef5351921e5397';
const String apiId = '2d893c77';
<<<<<<< HEAD
const String apiUrl = 'https://api.edamam.com';
=======
const String apiUrl = 'https://api.edamam.com/search';
>>>>>>> 4df485a (Fetch and display recipes from Edamam Recipe API)

// This class defines the API calls and sets up chopper client to do the work.
@ChopperApi()
abstract class RecipeService extends ChopperService
    implements ServiceInterface {
  @override
  @Get(path: 'search')
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(
    @Query('q') String query,
    @Query('from') int from,
    @Query('to') int to,
  );

<<<<<<< HEAD
  static RecipeService create() {
    final client = ChopperClient(
      baseUrl: apiUrl,
      interceptors: [
        _addQuery, /*HttpLoggingInterceptor()*/
      ],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$RecipeService(),
      ],
    );
    return _$RecipeService(client);
=======
  Future<dynamic> getRecipes(String query, int from, int to) async {
    final recipeData = await getData(
      '$apiUrl?app_id=$apiId&app_key=$apiKey&q=$query&from=$from&to=$to',
    );
    return recipeData;
>>>>>>> 4df485a (Fetch and display recipes from Edamam Recipe API)
  }
}

Request _addQuery(Request req) {
  final params = Map<String, dynamic>.from(req.parameters);
  params['app_id'] = apiId;
  params['app_key'] = apiKey;
  return req.copyWith(parameters: params);
}
