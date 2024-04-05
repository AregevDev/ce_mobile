import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../consts.dart';
import 'package:http/http.dart' as http;

@jsonSerializable
class Compiler {
  final String id;
  final String name;
  final String lang;
  final String compilerType;
  final String semver;
  final String instructionSet;

  Compiler(this.id, this.name, this.lang, this.compilerType, this.semver,
      this.instructionSet);

  static Future<List<Compiler>> fetchCompilers() async {
    final response = await http.get(Uri.parse("$defaultUrl$compilersEndpoint"),
        headers: <String, String>{
          HttpHeaders.acceptHeader: "application/json"
        });

    if (response.statusCode == HttpStatus.ok) {
      return JsonMapper.deserialize<List<Compiler>>(response.body) as List<Compiler>;
    } else {
      throw Exception('Failed to fetch compilers: ${response.statusCode}');
    }
  }

  static Future<List<Compiler>> fetchCompilersForLanguage(
      String langName) async {
    final response = await http.get(
        Uri.parse("$defaultUrl$compilersEndpoint/$langName"),
        headers: <String, String>{
          HttpHeaders.acceptHeader: "application/json"
        });

    if (response.statusCode == HttpStatus.ok) {
      return JsonMapper.deserialize<List<Compiler>>(response.body) as List<Compiler>;
    } else {
      throw Exception(
          'Failed to fetch compilers for $langName: ${response.statusCode}');
    }
  }
}
