import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gallery_view/models/image_model.dart';

class ImagesApi {
  Dio http = Dio(BaseOptions(baseUrl: 'https://api.unsplash.com/photos'));

  Future<ImagesResponse> fetchImages(String clientId) async {
    try {
      var response = await http.get('/?client_id=$clientId');

      return ImagesResponse.fromJson(response.data);
    } catch (e) {
      return ImagesResponse.withError(e.toString());
    }
  }
}
