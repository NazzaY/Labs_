import 'dart:convert';
import 'package:merged/repositories/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:merged/main.dart'; 

class CachingApiService extends ApiService {
  CachingApiService(String baseUrl) : super(baseUrl);

  Future<List<dynamic>> fetchComicsWithCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedComics = prefs.getString('comics');

    if (await checkInternetConnection()) {
      final comics = await fetchComics();
      await prefs.setString('comics', jsonEncode(comics));
      return comics;
    } else if (cachedComics != null) {
      return jsonDecode(cachedComics);
    } else {
      throw Exception('No internet and no cached data');
    }
  }
}
