import 'package:ce_mobile/model/workspace.dart';

// Default URL
const String defaultUrl = 'https://godbolt.org';

// Endpoints
const String compilersEndpoint = '/api/compilers';
const String languagesEndpoint = '/api/languages';
const String compileEndpoint = '/api/compiler';

// Default
const Compiler defaultCompiler =
    Compiler('g132', 'x86-64 gcc 13.2', 'c++', '', '13.2', 'amd64');

const Language defaultLanguage = Language('c++', 'C++',
    ['.cpp', '.cxx', '.h', '.hpp', '.hxx', '.c', '.cc', '.ixx'], 'cppp');
