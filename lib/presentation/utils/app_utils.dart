import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppUtils {
  Future<String?> fetchFlag(String? origin) async {
    if (origin == null) return null;

    origin = origin.replaceAll(RegExp(r"\s*\(.*?\)\s*"), "");

    try {
      final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/name/$origin'),
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data[0]['flags']['png'];
      } else {
        debugPrint('Error load flag');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching flag: $e');
      return null;
    }
  }

  CachedNetworkImage getCatImage(String? image) {
    return CachedNetworkImage(
      imageUrl: image ??
          "https://cdn.dribbble.com/users/2844289/screenshots/9975802/media/e665ebab6b700bc7d42637e0b2f95504.gif",
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: Image.asset(
          "assets/gifts/loading_meows.gif",
          fit: BoxFit.cover,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.blueGrey[200],
        child: const Icon(Icons.error),
      ),
    );
  }
}
