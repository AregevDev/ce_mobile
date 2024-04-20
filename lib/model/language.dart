import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../consts.dart';
import 'package:http/http.dart' as http;

@jsonSerializable
class Language {
  final String id;
  final String name;
  final List<String> extensions;
  final String monaco;

  const Language(this.id, this.name, this.extensions, this.monaco);

  static Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse("$defaultUrl$languagesEndpoint"), headers: <String, String>{ HttpHeaders.acceptHeader: "application/json" });

    if (response.statusCode == HttpStatus.ok) {
      return JsonMapper.deserialize<List<Language>>(response.body) as List<Language>;
    } else {
      throw Exception('Failed to fetch languages: ${response.statusCode}');
    }
  }
}
