import 'package:ce_mobile/model/compiler.dart';
import 'package:ce_mobile/model/language.dart';

// Default URL
const String defaultUrl = 'https://godbolt.org';

// Endpoints
const String compilersEndpoint = '/api/compilers';
const String languagesEndpoint = '/api/languages';

// Default
const Compiler defaultCompiler =
    Compiler("g132", "x86-64 gcc 13.2", "c++", "", "13.2", "amd64");

const Language defaultLanguage = Language('c++', 'C++',
    ['.cpp', '.cxx', '.h', '.hpp', '.hxx', '.c', '.cc', '.ixx'], 'cppp');
