import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ce_mobile/consts.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:isar/isar.dart';

part 'workspace.g.dart';

@jsonSerializable
@embedded
class Compiler {
  final String id;
  final String name;
  final String lang;
  final String compilerType;
  final String semver;
  final String instructionSet;

  const Compiler.create(this.id, this.name, this.lang, this.compilerType, this.semver,
      this.instructionSet);

  Compiler() : id = '', name = '', lang = '', compilerType = '', semver = '', instructionSet = '';

  static Future<List<Compiler>> fetchCompilers() async {
    final response = await http.get(Uri.parse('$defaultUrl$compilersEndpoint'),
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json'
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
        Uri.parse('$defaultUrl$compilersEndpoint/$langName'),
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json'
        });

    if (response.statusCode == HttpStatus.ok) {
      return JsonMapper.deserialize<List<Compiler>>(response.body) as List<Compiler>;
    } else {
      throw Exception(
          'Failed to fetch compilers for $langName: ${response.statusCode}');
    }
  }
}

@jsonSerializable
@embedded
class Language {
  final String id;
  final String name;
  final List<String> extensions;
  final String monaco;

  Language() : id = '', name = '', extensions = List.empty(), monaco = '';

  const Language.create(this.id, this.name, this.extensions, this.monaco);

  static Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse('$defaultUrl$languagesEndpoint'), headers: <String, String>{ HttpHeaders.acceptHeader: 'application/json' });

    if (response.statusCode == HttpStatus.ok) {
      return JsonMapper.deserialize<List<Language>>(response.body) as List<Language>;
    } else {
      throw Exception('Failed to fetch languages: ${response.statusCode}');
    }
  }
}

@collection
class Workspace {
  Id id = Isar.autoIncrement;

  String name;
  Compiler currentCompiler = defaultCompiler;
  Language currentLanguage = defaultLanguage;

  DateTime lastModified = DateTime.now();

  @ignore
  bool saveOnDisk;

  Workspace(this.name, {this.saveOnDisk = true});
}
