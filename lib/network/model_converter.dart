import 'dart:convert';
import 'package:chopper/chopper.dart';

import 'model_response.dart';
import 'recipe_model.dart';

class ModelConverter implements Converter {
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );
    return encodeJson(req);
  }

  // Take a Request instance and return a encoded copy of it,
  // ready to be sent to the server
  Request encodeJson(Request request) {
    final contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response<BodyType> decodeJson<BodyType, InnerType>(Response response) {
    final contentType = response.headers[contentTypeKey];
    var body = response.body;

    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }

    try {
      final mapData = json.decode(body);
      if (mapData['status'] != null) {
        return response.copyWith<BodyType>(
          body: Error(Exception(mapData['status'])) as BodyType,
        );
      }
      final recipeQuery = APIRecipeQuery.fromJson(mapData);
      return response.copyWith<BodyType>(
        body: Success(recipeQuery) as BodyType,
      );
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(
        body: Error(e as Exception) as BodyType,
      );
    }
  }

  // This method changes the given response to the one you want
  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return decodeJson<BodyType, InnerType>(response);
  }
}
