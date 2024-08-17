// lib/data/datasources/cat_remote_data_source_impl.dart

import 'package:http/http.dart' as http;
import 'package:meows_pedia/domain/datasources/cat_remote_data_source.dart';
import 'dart:convert';

import '../models/cat_model.dart';

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  final String apiKey =
      "ive_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr";
  final String baseUrl = "https://api.thecatapi.com/v1";

  @override
  Future<List<CatModel>> fetchCats() async {
    final response = await http.get(
      Uri.parse('$baseUrl/breeds?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> breedsJson = json.decode(response.body);
      return breedsJson.map((json) => CatModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cats');
    }
  }

  @override
  Future<String?> fetchCatImage(String referenceImageId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/images/$referenceImageId'),
      headers: {'x-api-key': apiKey},
    );

    if (response.statusCode == 200) {
      final imageData = json.decode(response.body);
      return imageData['url'];
    } else {
      return null;
    }
  }
}
