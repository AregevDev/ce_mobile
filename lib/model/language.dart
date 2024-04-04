import 'dart:convert';
import 'dart:io';

import '../consts.dart';
import 'package:http/http.dart' as http;

class Language {
  final String id;
  final String name;
  final List<String> extensions;
  final String monaco;

  Language(this.id, this.name, this.extensions, this.monaco);

  factory Language.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'extensions': List<dynamic> extensions,
        'monaco': String monaco,
      } =>
        Language(id, name, extensions.cast(), monaco),
      _ => throw FormatException(
          "Could not construct Language object from JSON $json"),
    };
  }

  static Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse("$defaultUrl$languagesEndpoint"), headers: <String, String>{ HttpHeaders.acceptHeader: "application/json" });

    if (response.statusCode == HttpStatus.ok) {
      Iterable it = jsonDecode(response.body);
      return List<Language>.from(it.map((e) => Language.fromJson(e)));
    } else {
      throw Exception('Failed to fetch languages: ${response.statusCode}');
    }
  }
}
