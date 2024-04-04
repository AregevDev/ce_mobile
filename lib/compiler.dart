import 'dart:convert';
import 'dart:io';

import 'consts.dart';
import 'package:http/http.dart' as http;

class Compiler {
  final String id;
  final String name;
  final String lang;
  final String compilerType;
  final String semver;
  final String instructionSet;

  Compiler(this.id, this.name, this.lang, this.compilerType, this.semver,
      this.instructionSet);

  factory Compiler.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'name': String name,
        'lang': String lang,
        'compilerType': String compileType,
        'semver': String semver,
        'instructionSet': String instructionSet,
      } =>
        Compiler(id, name, lang, compileType, semver, instructionSet),
      _ => throw FormatException(
          'Could not construct a Compiler object from JSON $json'),
    };
  }

  static Future<List<Compiler>> fetchCompilers() async {

    final response = await http.get(Uri.parse("$DEFAULT_CE_URL$COMPILERS_ENDPOINT"), headers: <String, String>{ HttpHeaders.acceptHeader: "application/json" });

    if (response.statusCode == HttpStatus.ok) {
      Iterable it = jsonDecode(response.body);
      return List<Compiler>.from(it.map((e) => Compiler.fromJson(e)));
    } else {
      throw Exception('Failed to fetch compilers: ${response.statusCode}');
    }
  }
}
