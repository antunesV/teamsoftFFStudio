import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['pt', 'en', 'es', 'fr'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? ptText = '',
    String? enText = '',
    String? esText = '',
    String? frText = '',
  }) =>
      [ptText, enText, esText, frText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Calendars
  {
    '1mlrozop': {
      'pt': 'Calendars',
      'en': 'Components',
      'es': 'Componentes',
      'fr': 'Composants',
    },
    '6qbtwi2v': {
      'pt': 'Calendar Month',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2sdm4dms': {
      'pt': 'Calendar Week',
      'en': '',
      'es': '',
      'fr': '',
    },
    'd8l959ft': {
      'pt': 'Calendar Day',
      'en': '',
      'es': '',
      'fr': '',
    },
    '95j48swa': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // HomePage
  {
    '1uahdjhb': {
      'pt': 'Home',
      'en': 'Components',
      'es': 'Componentes',
      'fr': 'Composants',
    },
    'ictjqye6': {
      'pt': 'Toast',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ivhd1xuk': {
      'pt': 'menu',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gu8fones': {
      'pt': 'Calendars',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0iobwfiy': {
      'pt': 'inputCpf/Cnpj',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wp3bzzjq': {
      'pt': 'cpf',
      'en': '',
      'es': '',
      'fr': '',
    },
    'sdivuz53': {
      'pt': 'cnpj',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4pjqd3tb': {
      'pt': 'ambos',
      'en': '',
      'es': '',
      'fr': '',
    },
    '6ktbw8t6': {
      'pt': 'Home',
      'en': 'Home',
      'es': 'Hogar',
      'fr': 'Maison',
    },
  },
  // calendarMonth
  {
    '3spm4x6e': {
      'pt': 'Domingo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'paoek1rf': {
      'pt': 'Segunda',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lca52bnz': {
      'pt': 'Terça',
      'en': '',
      'es': '',
      'fr': '',
    },
    '6hh8yfq3': {
      'pt': 'Quarta',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2tz005ds': {
      'pt': 'Quinta',
      'en': '',
      'es': '',
      'fr': '',
    },
    'n1f8f7bj': {
      'pt': 'Sexta',
      'en': '',
      'es': '',
      'fr': '',
    },
    '57zmxq6g': {
      'pt': 'Sabado',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // filterDateInline
  {
    'lcp4wq37': {
      'pt': ' ',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wy8mk4xu': {
      'pt': '. ',
      'en': '',
      'es': '',
      'fr': '',
    },
    'nfud80nc': {
      'pt': ', ',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ul039919': {
      'pt': ' ',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gjnnsf9r': {
      'pt': ' ',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8r20h3rw': {
      'pt': '. ',
      'en': '',
      'es': '',
      'fr': '',
    },
    'd9wiu9ht': {
      'pt': ' ',
      'en': '',
      'es': '',
      'fr': '',
    },
    '1577vr25': {
      'pt': 'Hoje',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // dropDownValue
  {
    '6cckoxlc': {
      'pt': 'R\$',
      'en': '',
      'es': '',
      'fr': '',
    },
    'aggzgt7i': {
      'pt': 'De',
      'en': 'DD/MM/YYYY',
      'es': 'DD/MM/AAAA',
      'fr': 'JJ/MM/AAAA',
    },
    '3cflorl7': {
      'pt': 'R\$',
      'en': '',
      'es': '',
      'fr': '',
    },
    'e3rghydt': {
      'pt': 'Até',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3315kfl4': {
      'pt': 'Limpar',
      'en': 'Clear filters',
      'es': 'Borrar filtros',
      'fr': 'Effacer les filtres',
    },
    'qdfymf81': {
      'pt': 'Aplicar',
      'en': 'Apply',
      'es': 'Aplicar',
      'fr': 'Appliquer',
    },
  },
  // inputDate
  {
    '3a5lk26i': {
      'pt': 'DD/MM/AAAA',
      'en': 'DD/MM/YYYY',
      'es': 'DD/MM/AAAA',
      'fr': 'JJ/MM/AAAA',
    },
  },
  // calendarWeek
  {
    'gb79novy': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // inputFieldSingleSelect
  {
    'bq0pez5s': {
      'pt': 'TextField',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // circleLoading
  {
    'qjiiqamh': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // testeColorsFont
  {
    'lmllaaqt': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // menuHorizontaOptionUser
  {
    'f31ze6uc': {
      'pt': 'Sair',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // pagination
  {
    'ajt38bo8': {
      'pt': '1',
      'en': '1',
      'es': '1',
      'fr': '1',
    },
    'fk1m83ji': {
      'pt': '...',
      'en': '...',
      'es': '...',
      'fr': '...',
    },
    '86acymmf': {
      'pt': '...',
      'en': '...',
      'es': '...',
      'fr': '...',
    },
  },
  // filterDate
  {
    'u9xfvugh': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // dropDownSingleSelect
  {
    '94lxwlzt': {
      'pt': 'Digite para buscar',
      'en': 'Type to search',
      'es': 'Escribe para buscar',
      'fr': 'Tapez pour rechercher',
    },
    'npv718qd': {
      'pt': 'adicionar',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // dropDownMultiSelect
  {
    'pjyu088c': {
      'pt': 'Digite para buscar',
      'en': 'Type to search',
      'es': 'Escribe para buscar',
      'fr': 'Tapez pour rechercher',
    },
    'et7tykcc': {
      'pt': '(Selecionar Todos)',
      'en': '(Select All)',
      'es': '(Seleccionar todo)',
      'fr': '(Sélectionner tout)',
    },
    'r1k8q8ot': {
      'pt': 'adicionar',
      'en': '',
      'es': '',
      'fr': '',
    },
    '05jp9wpw': {
      'pt': '(Selecionar Todos)',
      'en': '(Select All)',
      'es': '(Seleccionar todo)',
      'fr': '(Sélectionner tout)',
    },
    'i40knzhb': {
      'pt': 'Limpar',
      'en': 'Clear filters',
      'es': 'Borrar filtros',
      'fr': 'Effacer les filtres',
    },
    'nx08m9k7': {
      'pt': 'Aplicar',
      'en': 'Apply',
      'es': 'Aplicar',
      'fr': 'Appliquer',
    },
  },
  // paginator
  {
    'th3qw96d': {
      'pt': 'Mostrando ',
      'en': 'Showing',
      'es': 'Demostración',
      'fr': 'Affichage',
    },
    '0e17wkxo': {
      'pt': '-',
      'en': '-',
      'es': '-',
      'fr': '-',
    },
    'j486cbh2': {
      'pt': ' de ',
      'en': 'of',
      'es': 'de',
      'fr': 'de',
    },
    'frglr7ty': {
      'pt': ' ',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // dropDownCalendar
  {
    'tveef0qy': {
      'pt': 'DD/MM/AAAA',
      'en': 'DD/MM/YYYY',
      'es': 'DD/MM/AAAA',
      'fr': 'JJ/MM/AAAA',
    },
    'z89r93cz': {
      'pt': 'até',
      'en': 'until',
      'es': 'hasta',
      'fr': 'jusqu\'à',
    },
    'g9oyaei9': {
      'pt': 'DD/MM/AAAA',
      'en': 'DD/MM/YYYY',
      'es': 'DD/MM/AAAA',
      'fr': 'JJ/MM/AAAA',
    },
    'wj6g6qiu': {
      'pt': 'DD/MM/AAAA',
      'en': 'DD/MM/YYYY',
      'es': 'DD/MM/AAAA',
      'fr': 'JJ/MM/AAAA',
    },
    'i058llk5': {
      'pt': 'Limpar',
      'en': 'Clear filters',
      'es': 'Borrar filtros',
      'fr': 'Effacer les filtres',
    },
    't221e2wn': {
      'pt': 'Aplicar',
      'en': 'Apply',
      'es': 'Aplicar',
      'fr': 'Appliquer',
    },
    'z75gcdwg': {
      'pt': 'Limpar',
      'en': 'Clear filters',
      'es': 'Borrar filtros',
      'fr': 'Effacer les filtres',
    },
    '6jkwde8h': {
      'pt': 'Aplicar',
      'en': 'Apply',
      'es': 'Aplicar',
      'fr': 'Appliquer',
    },
  },
  // inputSingleSelect
  {
    'w6hln533': {
      'pt': ' ',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    '01anc5q1': {
      'pt': 'TextField',
      'en': 'TextField',
      'es': 'Campo de texto',
      'fr': 'Champ de texte',
    },
    'rip21f9r': {
      'pt': 'Button',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ko8gi8p8': {
      'pt': 'Button',
      'en': '',
      'es': '',
      'fr': '',
    },
    'qzz3y9pk': {
      'pt': 'Button',
      'en': '',
      'es': '',
      'fr': '',
    },
    'brvakrbo': {
      'pt': 'Button',
      'en': '',
      'es': '',
      'fr': '',
    },
    'oz1u0uut': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'na3tun1c': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '44w5h95o': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lnamprt4': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wnuokcns': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ovae4dld': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'tu9gs707': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'j3v9x4aq': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'asattrkg': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'nyjt2q0f': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ndf8gf4b': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2e4b0h0m': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7veugbd2': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'oriq4rhj': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'bkw6jrdr': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'e0np5uy9': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9jfxliio': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zam8mgfq': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    's79fbxe0': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0my3bk89': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'fgpvhqoz': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jocqqa18': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'g6hyaamt': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3xutkphp': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5n9kx9ww': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
