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

  static List<String> languages() => ['pt', 'en', 'fr', 'es'];

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
    String? frText = '',
    String? esText = '',
  }) =>
      [ptText, enText, frText, esText][languageIndex] ?? '';

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
  // HomePage
  {
    'oenf22pq': {
      'pt': 'Logout',
      'en': '',
      'es': '',
      'fr': '',
    },
    'q1sekbd7': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // login
  {
    '5t1vqxkl': {
      'pt': 'Acessar conta',
      'en': '',
      'es': '',
      'fr': '',
    },
    'npgvo04g': {
      'pt': 'Bem vindo de volta!',
      'en': '',
      'es': '',
      'fr': '',
    },
    'uazf8eou': {
      'pt': 'Entre com o NIF associado à sua conta abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ye8j2kbx': {
      'pt': 'NIF',
      'en': '',
      'es': '',
      'fr': '',
    },
    'l8pf497e': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'l0qbvj48': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ggjvfezv': {
      'pt': 'Insira seu NIF aqui',
      'en': '',
      'es': '',
      'fr': '',
    },
    'njd1nrxq': {
      'pt': 'Continuar',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8piiokor': {
      'pt': 'Insira sua senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'hkcf9ko7': {
      'pt': 'Insira sua senha abaixo para acessar sua conta.',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3z6vwd2a': {
      'pt': 'Senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0vy0rvzk': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'sdckbuxv': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3qfxt7u9': {
      'pt': 'Insira sua senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'j1j7vt48': {
      'pt': 'Acessar',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ctjfycfj': {
      'pt': 'Esqueci minha senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'flxws8zi': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // welcome
  {
    'pqi6i1jd': {
      'pt': 'Abra sua conta',
      'en': '',
      'es': '',
      'fr': '',
    },
    'r60dqy60': {
      'pt': 'Acesse sua conta',
      'en': '',
      'es': '',
      'fr': '',
    },
    'y1wy2f9r': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // forgotPassword
  {
    'gwh70upw': {
      'pt': 'Redefinição de senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lvyi9iq6': {
      'pt': 'Esqueceu sua senha?',
      'en': '',
      'es': '',
      'fr': '',
    },
    'mn71vo2m': {
      'pt':
          'Insira abaixo o seu email. Logo será enviado um código para redefinir sua senha.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'vhjl2ox6': {
      'pt': 'Email',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2ckbugla': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5arnsbzj': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'clogmmsh': {
      'pt': 'Insira seu email aqui',
      'en': '',
      'es': '',
      'fr': '',
    },
    'o5m06zp9': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'g8vr863k': {
      'pt': 'Não consigo acessar meu email',
      'en': '',
      'es': '',
      'fr': '',
    },
    'amzbda2t': {
      'pt': 'Enviar código via SMS',
      'en': '',
      'es': '',
      'fr': '',
    },
    'goxahc59': {
      'pt': 'Esqueceu sua senha?',
      'en': '',
      'es': '',
      'fr': '',
    },
    's0xo7n4j': {
      'pt':
          'Insira abaixo o seu NIF. Logo será enviado um código para redefinir sua senha.',
      'en': '',
      'es': '',
      'fr': '',
    },
    '90rgjfqj': {
      'pt': 'NIF',
      'en': '',
      'es': '',
      'fr': '',
    },
    '36j5zzf6': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ewjs2ed7': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'nhv17191': {
      'pt': 'NIF',
      'en': '',
      'es': '',
      'fr': '',
    },
    'f30kwh5n': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'afuk8jmo': {
      'pt':
          'Taxas adicionais serão cobradas pelo envio de SMS, conforme a operadora do usuário.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'xbk3h6kb': {
      'pt': 'Código de verificação',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0eap8juk': {
      'pt': 'Insira abaixo o código de verificação enviado ao email ',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zasdfzqb': {
      'pt': 'Insira abaixo o código de verificação enviado ao email ',
      'en': '',
      'es': '',
      'fr': '',
    },
    '1jkjp4ky': {
      'pt': 'Insira abaixo o código de verificação enviado ao telefone ',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9qeqzblc': {
      'pt': 'Insira abaixo o código de verificação enviado ao email ',
      'en': '',
      'es': '',
      'fr': '',
    },
    '17xx2gu7': {
      'pt': '0',
      'en': '',
      'es': '',
      'fr': '',
    },
    'g9hljl3i': {
      'pt': '0',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8vmbbqob': {
      'pt': '0',
      'en': '',
      'es': '',
      'fr': '',
    },
    'b697gdfe': {
      'pt': '0',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wo3z9po2': {
      'pt': '0',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jv2ft5vw': {
      'pt': '0',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8cgks8in': {
      'pt': 'Redefinir senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'f18fb8a9': {
      'pt': 'Reenviar código  (',
      'en': '',
      'es': '',
      'fr': '',
    },
    '376pfg1k': {
      'pt': 's)',
      'en': '',
      'es': '',
      'fr': '',
    },
    '521d2u76': {
      'pt': 'Reenviar código',
      'en': '',
      'es': '',
      'fr': '',
    },
    'i8slaur5': {
      'pt': 'Foto Pessoal',
      'en': '',
      'es': '',
      'fr': '',
    },
    'sdhm8ims': {
      'pt':
          'Precisamos capturar uma foto sua para verificação \nde sua identidade.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jmb5ruig': {
      'pt': 'Verificando foto...',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ltlldnm0': {
      'pt': 'Tudo OK!',
      'en': '',
      'es': '',
      'fr': '',
    },
    'of7nxkzp': {
      'pt': 'Verifique sua foto no próximo passo para continuar.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'dhjqvm1v': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'rvkxjax4': {
      'pt': 'Redefinir senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'aarlan9c': {
      'pt': 'Redefina sua senha nos campos abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'm270ujyj': {
      'pt': 'Nova senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'mjwh715c': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    't1fqm5h4': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    's87h95qx': {
      'pt': 'Insira sua nova senha aqui',
      'en': '',
      'es': '',
      'fr': '',
    },
    'z3yr53rj': {
      'pt': 'Confirmar a nova senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    '44i0oapr': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'pr9eqe6v': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'larsgo68': {
      'pt': 'Confirme sua nova senha aqui',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2vo0lwdv': {
      'pt': 'Mínimo 8 caracteres',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3xerd9u5': {
      'pt': 'Mínimo 8 caracteres',
      'en': '',
      'es': '',
      'fr': '',
    },
    'rfvs7d3a': {
      'pt': 'Letras maiúsculas e minúsculas',
      'en': '',
      'es': '',
      'fr': '',
    },
    'i8blmm9n': {
      'pt': 'Letras maiúsculas e minúsculas',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5ajl6bi4': {
      'pt': 'Números',
      'en': '',
      'es': '',
      'fr': '',
    },
    '67176n9s': {
      'pt': 'Números',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9p7w848f': {
      'pt': 'Símbolos (!@#&...)',
      'en': '',
      'es': '',
      'fr': '',
    },
    'n860ekvw': {
      'pt': 'Símbolos (!@#&...)',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zrs5kljw': {
      'pt': 'Confirmar redefinição',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4hav57jg': {
      'pt': 'Voltar ao login',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4vh59hrc': {
      'pt': 'Senha redefinida com sucesso!',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ekp4jh51': {
      'pt': 'Você está pronto para acessar sua conta.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'mw2bqc63': {
      'pt': 'Acessar conta',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7pzoxlcz': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // phoneInput
  {
    'k9s3umi3': {
      'pt': 'Esqueceu sua senha?',
      'en': '',
      'es': '',
      'fr': '',
    },
    'et832tsd': {
      'pt':
          'Insira abaixo o seu número de telefone. Logo será enviado um código para redefinir sua senha.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gdsudalp': {
      'pt': '+244',
      'en': '',
      'es': '',
      'fr': '',
    },
    'o1ekz9o6': {
      'pt': '000 000 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'vfsyuyna': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'kdpkmu0p': {
      'pt':
          'Taxas adicionais serão cobradas pelo envio de SMS, conforme a operadora do usuário.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'acfd9e28': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // chooseAccountType
  {
    'c5d1ud1c': {
      'pt': 'Abra sua conta',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7m95rnu4': {
      'pt': 'Abra sua conta',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7izdbfwp': {
      'pt': 'Selecione o tipo de conta que deseja abrir.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'agkdllew': {
      'pt': 'Conta particular',
      'en': '',
      'es': '',
      'fr': '',
    },
    'hyqgtdya': {
      'pt': 'Conta individual para uso pessoal de uma única pessoa',
      'en': '',
      'es': '',
      'fr': '',
    },
    'pb1w01v8': {
      'pt': 'Conta empresa',
      'en': '',
      'es': '',
      'fr': '',
    },
    'yrik0tki': {
      'pt': 'Conta destinada à movimentação financeira de um negócio',
      'en': '',
      'es': '',
      'fr': '',
    },
    'k9d1otyw': {
      'pt': 'Conta conjunta',
      'en': '',
      'es': '',
      'fr': '',
    },
    '41c3ptgu': {
      'pt': 'Conta compartilhada que exige autorização de todos os titulares',
      'en': '',
      'es': '',
      'fr': '',
    },
    'd85wkc4z': {
      'pt': 'Conta solidária',
      'en': '',
      'es': '',
      'fr': '',
    },
    '33xweyfz': {
      'pt':
          'Conta compartilhada em que qualquer titular pode movimentar os recursos',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5r4n3nvw': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // personalData
  {
    'r9am3uzg': {
      'pt': 'Conta particular',
      'en': '',
      'es': '',
      'fr': '',
    },
    'eoj95uc9': {
      'pt': 'Dados pessoais',
      'en': '',
      'es': '',
      'fr': '',
    },
    'z3gw5q4p': {
      'pt': 'Insira seus dados de acesso abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jon81c97': {
      'pt': 'NIF',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gb9g2nzx': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'glntjg5j': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'rnqq45kl': {
      'pt': 'Insira seu NIF aqui',
      'en': '',
      'es': '',
      'fr': '',
    },
    'dvc8s2el': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'm3vjw4m5': {
      'pt': 'Dados pessoais',
      'en': '',
      'es': '',
      'fr': '',
    },
    'tjnrrhao': {
      'pt': 'Insira seus dados de acesso abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'd83clyr1': {
      'pt': 'Senha',
      'en': '',
      'es': '',
      'fr': '',
    },
    'c7v7f6mb': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'qvoo55ww': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '74vbazpz': {
      'pt': 'Qual senha deseja utilizar?',
      'en': '',
      'es': '',
      'fr': '',
    },
    'v7yt0jgy': {
      'pt': 'Mínimo 8 caracteres',
      'en': '',
      'es': '',
      'fr': '',
    },
    'tfwxi3p1': {
      'pt': 'Mínimo 8 caracteres',
      'en': '',
      'es': '',
      'fr': '',
    },
    'pouvhcyj': {
      'pt': 'Letras maiúsculas e minúsculas',
      'en': '',
      'es': '',
      'fr': '',
    },
    'hoioy5ec': {
      'pt': 'Letras maiúsculas e minúsculas',
      'en': '',
      'es': '',
      'fr': '',
    },
    'te0as05b': {
      'pt': 'Números',
      'en': '',
      'es': '',
      'fr': '',
    },
    'f12lsqo7': {
      'pt': 'Números',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8shgaiu2': {
      'pt': 'Símbolos (!@#&...)',
      'en': '',
      'es': '',
      'fr': '',
    },
    'x8hzftxj': {
      'pt': 'Símbolos (!@#&...)',
      'en': '',
      'es': '',
      'fr': '',
    },
    'rp5q6mul': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'z2ycyz8k': {
      'pt': 'Dados pessoais',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ysjs7puk': {
      'pt': 'Insira seus dados pessoais abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'pjrgcg98': {
      'pt': 'Nome completo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'th61gbbq': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3deilnfd': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'a67uz2f8': {
      'pt': 'Nome',
      'en': '',
      'es': '',
      'fr': '',
    },
    'm527dqi7': {
      'pt': 'Data de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0dzr86u0': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7e7nofy3': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '999rklfx': {
      'pt': 'Data de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wxvlyudz': {
      'pt': 'Gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    '6859p5sz': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3dvu5c7d': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'xrg4mi52': {
      'pt': 'Gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zqfnx5bw': {
      'pt': 'Especifique seu gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jiqn2aob': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lpjlu4w1': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'sl7hvrzg': {
      'pt': 'Especifique seu gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    'srsy6h16': {
      'pt': 'Estado civil',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5fmawzpe': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'hzehz42s': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8civ4zo4': {
      'pt': 'Estado civil',
      'en': '',
      'es': '',
      'fr': '',
    },
    '6tlpe3u7': {
      'pt': 'Nacionalidade',
      'en': '',
      'es': '',
      'fr': '',
    },
    'chnhi343': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'pk2zxoy4': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'nfst01tv': {
      'pt': 'Nacionalidade',
      'en': '',
      'es': '',
      'fr': '',
    },
    '69jsi4fx': {
      'pt': 'Search...',
      'en': '',
      'es': '',
      'fr': '',
    },
    'pv4eoskl': {
      'pt': 'País de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    '63800p8q': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '6q6w78na': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'x1agwah5': {
      'pt': 'País de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'va4dtm5g': {
      'pt': 'Província de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0mybuaq3': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'i9bj7kdb': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8p9lkynu': {
      'pt': 'Província de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'smvee56o': {
      'pt': 'Telefone Móvel',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gvx08kb3': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'w1o1hcj5': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jixp7v7l': {
      'pt': '+ 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'cwp2xtbw': {
      'pt': '000 000 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2e05tgyq': {
      'pt': 'Telefone Móvel',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9lhqvfj2': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '31l26j9p': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'y2nu7avy': {
      'pt': '+ 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'n7k0182n': {
      'pt': '000 000 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'nw2ahl2v': {
      'pt': 'Email principal',
      'en': '',
      'es': '',
      'fr': '',
    },
    '03qzupwo': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9gmfvkg3': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8i9sutog': {
      'pt': 'Email princial',
      'en': '',
      'es': '',
      'fr': '',
    },
    '6fhowqgp': {
      'pt': 'Email alternativo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'npuqeatk': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ptauqwoo': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '95bzdkmd': {
      'pt': 'Nome',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wzrkmth5': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2i8c6ywq': {
      'pt': 'Dados pessoais',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8ayw2bqe': {
      'pt': 'Insira informações do seu documento de identidade abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jhi0k9wc': {
      'pt': 'Nome completo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gx0v1ju3': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4lwkds4t': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'q9sqe8tg': {
      'pt': 'Nome',
      'en': '',
      'es': '',
      'fr': '',
    },
    'chccdxve': {
      'pt': 'Data de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'bkm0k4gs': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'dwlvyyb9': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'le9oylai': {
      'pt': 'Data de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4wen39lr': {
      'pt': 'Gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    'mhy015wp': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0vcw3ilx': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'spurftxa': {
      'pt': 'Gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    'c13twi0v': {
      'pt': 'Especifique seu gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lfnlagx7': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4b5sngza': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'mifu6q3l': {
      'pt': 'Especifique seu gênero',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zifygwwh': {
      'pt': 'Estado civil',
      'en': '',
      'es': '',
      'fr': '',
    },
    'io8qe9j7': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ckr4ozlr': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '65zrxb30': {
      'pt': 'Estado civil',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0bolrk2z': {
      'pt': 'Nacionalidade',
      'en': '',
      'es': '',
      'fr': '',
    },
    'vpazunil': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zzuagui2': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'mw9mgvvz': {
      'pt': 'Nacionalidade',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ztle15jl': {
      'pt': 'Search...',
      'en': '',
      'es': '',
      'fr': '',
    },
    'kkwqb0ae': {
      'pt': 'País de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'i6h3e0kd': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wppqs9th': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'oc91nhzp': {
      'pt': 'País de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'oa3etusq': {
      'pt': 'Província de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'd7vhgri1': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7q3f4mnd': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '720o3emr': {
      'pt': 'Província de nascimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zkkj5rfi': {
      'pt': 'Telefone Móvel',
      'en': '',
      'es': '',
      'fr': '',
    },
    'bszo5343': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'e3c8yeq8': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3tdbmc4j': {
      'pt': '+ 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'qwpl7cmu': {
      'pt': '000 000 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'm0ibhbxk': {
      'pt': 'Telefone Móvel',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ah16beel': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ol1zci5d': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    'w4vgn5g6': {
      'pt': '+ 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'b7ml2qnn': {
      'pt': '000 000 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'edl1ewv5': {
      'pt': 'Email principal',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lrgnx35y': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'rtujfxtd': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3dlnf2n1': {
      'pt': 'Email princial',
      'en': '',
      'es': '',
      'fr': '',
    },
    'l6b7b2ue': {
      'pt': 'Email alternativo',
      'en': '',
      'es': '',
      'fr': '',
    },
    '14w94vtq': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9s7n6d5g': {
      'pt': 'Hello World',
      'en': '',
      'es': '',
      'fr': '',
    },
    '700y1o5s': {
      'pt': 'Nome',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9q9f3kcq': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'f77ogj58': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // professionalData
  {
    'jpf7mnnm': {
      'pt': 'Conta particular',
      'en': '',
      'es': '',
      'fr': '',
    },
    'auxwsrsq': {
      'pt': 'Dados pessoais',
      'en': '',
      'es': '',
      'fr': '',
    },
    '0rk2mh8i': {
      'pt': 'Insira seus dados de acesso abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    't7iusevv': {
      'pt': 'Situação profissional',
      'en': '',
      'es': '',
      'fr': '',
    },
    'f3rtfwii': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '42xigmty': {
      'pt': 'Situação profissional',
      'en': '',
      'es': '',
      'fr': '',
    },
    'bl5r11ye': {
      'pt': 'Search...',
      'en': '',
      'es': '',
      'fr': '',
    },
    'aavftqwq': {
      'pt': 'Setor de atividade',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9378zta7': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'yezunuk3': {
      'pt': 'Setor de atividade',
      'en': '',
      'es': '',
      'fr': '',
    },
    'rxb8dqmk': {
      'pt': 'Search...',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gc8p39cl': {
      'pt': 'Património líquido total estimado',
      'en': '',
      'es': '',
      'fr': '',
    },
    'piaxf691': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'phpg9gpd': {
      'pt': 'Rendimento mensal',
      'en': '',
      'es': '',
      'fr': '',
    },
    'pbzau1qc': {
      'pt': 'Search...',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8ybuix94': {
      'pt': 'Fonte principal de fundos',
      'en': '',
      'es': '',
      'fr': '',
    },
    'l5rupzgg': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'z810akac': {
      'pt': 'Património líquido total estimado',
      'en': '',
      'es': '',
      'fr': '',
    },
    'eoxts399': {
      'pt': 'Search...',
      'en': '',
      'es': '',
      'fr': '',
    },
    '6441p6ps': {
      'pt': 'Espefique a fonte principal de fundos',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lvjtmc03': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'x2p6v9h2': {
      'pt': 'Fonte principal de fundos',
      'en': '',
      'es': '',
      'fr': '',
    },
    'u68011wg': {
      'pt': 'Mínimo 50 caracteres',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jwylm1fz': {
      'pt': 'Comprovativo de origem de fundos',
      'en': '',
      'es': '',
      'fr': '',
    },
    'bho2hmdq': {
      'pt': 'Clique na área abaixo para fazer upload do documento.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'imb65dbx': {
      'pt': 'Documentos aceitos:',
      'en': '',
      'es': '',
      'fr': '',
    },
    'vjlwmnb6': {
      'pt':
          '•   Extrato bancário Documento de venda de  bens (escrituras, contratos) \n•   Certidão de herança ou partilha \n•   Declaração de doação\n•   Comprovativo de recebimento de indenização \n•   Outros documentos relevantes',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gfcu7lvi': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'tf1xf27t': {
      'pt': 'Dados pessoais',
      'en': '',
      'es': '',
      'fr': '',
    },
    'm5ch43zk': {
      'pt': 'Insira seus dados de acesso abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    '424kyb7e': {
      'pt': 'Entidade empregadora',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wz9r2xoq': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'clwh49re': {
      'pt': 'Red Deer S.A.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lndaan4l': {
      'pt': 'NIF da entidade empregadora',
      'en': '',
      'es': '',
      'fr': '',
    },
    '88k9u1rv': {
      'pt': 'Telefone da entidade empregadora',
      'en': '',
      'es': '',
      'fr': '',
    },
    'o4ed7g7n': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    'sdr71h91': {
      'pt': '+244',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4d6a43jt': {
      'pt': '000 000 000',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ythvz75b': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'u5mxtpjc': {
      'pt': 'Dados pessoais',
      'en': '',
      'es': '',
      'fr': '',
    },
    'vn2hd7wv': {
      'pt': 'Insira informações do seu documento de identidade abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'j8e8t49g': {
      'pt': 'Busque o endereço da entidade ',
      'en': '',
      'es': '',
      'fr': '',
    },
    'xs56j2s3': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'w5va7lli': {
      'pt': 'Você tem outras fontes de rendimento?',
      'en': '',
      'es': '',
      'fr': '',
    },
    'nlb705hv': {
      'pt': 'Não',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3ssll4mo': {
      'pt': 'Sim',
      'en': '',
      'es': '',
      'fr': '',
    },
    'egyzxp9r': {
      'pt': 'Fontes de rendimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4ud5adi8': {
      'pt': 'Selecione abaixo suas fontes de rendimento.',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4188sbzz': {
      'pt': 'Rendimentos de Capital',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5zjqu04z': {
      'pt': 'Dividendos, juros de investimentos ',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9mm2hv4n': {
      'pt': 'Rendimentos Prediais',
      'en': '',
      'es': '',
      'fr': '',
    },
    'i8curu64': {
      'pt': 'Arrendamento de imóveis',
      'en': '',
      'es': '',
      'fr': '',
    },
    '1miw6j91': {
      'pt': 'Pensões de Reforma',
      'en': '',
      'es': '',
      'fr': '',
    },
    'putg863q': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'kx5kf88x': {
      'pt': 'Heranças',
      'en': '',
      'es': '',
      'fr': '',
    },
    'xut18ke3': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'ql3u4ars': {
      'pt': 'Doações',
      'en': '',
      'es': '',
      'fr': '',
    },
    'wlp19p9d': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7gbr8phz': {
      'pt': 'Rendimentos de Investimentos',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8fpz9x1t': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'nvee11r2': {
      'pt': 'Outro',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5a573gga': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '50sqnixx': {
      'pt': 'Fonte de rendimento',
      'en': '',
      'es': '',
      'fr': '',
    },
    '99uvuff1': {
      'pt': '*',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2y3etnd1': {
      'pt': 'Especifique a outra fonte de rendimento aqui',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zuwrasfn': {
      'pt': 'Próximo',
      'en': '',
      'es': '',
      'fr': '',
    },
    'dfii1uae': {
      'pt': 'Upload do comprovativo de rendimentos',
      'en': '',
      'es': '',
      'fr': '',
    },
    'khhc6spe': {
      'pt':
          'Envie um ou mais documentos comprovativos de rendimentos\nno campo abaixo.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'zhhvq5mx': {
      'pt': 'Comprovativo de origem de fundos',
      'en': '',
      'es': '',
      'fr': '',
    },
    '9w9i2ost': {
      'pt': 'Clique na área abaixo para fazer upload do documento.',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7h3b1p5e': {
      'pt': 'Documentos aceitos:',
      'en': '',
      'es': '',
      'fr': '',
    },
    'e315ncke': {
      'pt':
          '•   Extrato bancário Documento de venda de  bens (escrituras, contratos) \n•   Certidão de herança ou partilha \n•   Declaração de doação\n•   Comprovativo de recebimento de indenização \n•   Outros documentos relevantes',
      'en': '',
      'es': '',
      'fr': '',
    },
    '7k5crlhl': {
      'pt': 'Home',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // selectCountry
  {
    '3pp0wrue': {
      'pt': 'Busque o seu país/região',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // errorMsg
  {
    '2ahax2pu': {
      'pt': 'NIF ou senha incorrectos',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2qmv0hzo': {
      'pt': 'Tente novamente.',
      'en': '',
      'es': '',
      'fr': '',
    },
    '8rfhcco0': {
      'pt': 'OK',
      'en': '',
      'es': '',
      'fr': '',
    },
    'u3oih5qj': {
      'pt': 'Código Incorreto',
      'en': '',
      'es': '',
      'fr': '',
    },
    'o4xlm7j5': {
      'pt': 'Tente novamente.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'tdiuadqd': {
      'pt': 'OK',
      'en': '',
      'es': '',
      'fr': '',
    },
    'gtf6enwv': {
      'pt': 'E-mail inválido',
      'en': '',
      'es': '',
      'fr': '',
    },
    '2payvveo': {
      'pt': 'Tente novamente.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'yebzk3kl': {
      'pt': 'OK',
      'en': '',
      'es': '',
      'fr': '',
    },
    'b06vxc8u': {
      'pt': 'Erro ao enviar o código para o e-mail',
      'en': '',
      'es': '',
      'fr': '',
    },
    '39qvxbn7': {
      'pt': 'Tente novamente.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'npb7gdw8': {
      'pt': 'OK',
      'en': '',
      'es': '',
      'fr': '',
    },
    '44g7inzl': {
      'pt': 'As senhas não coincidem.',
      'en': '',
      'es': '',
      'fr': '',
    },
    '21a33kz2': {
      'pt': 'Tente novamente.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'hp1mhelv': {
      'pt': 'OK',
      'en': '',
      'es': '',
      'fr': '',
    },
    '5zafbq8x': {
      'pt': 'Erro desconhecido',
      'en': '',
      'es': '',
      'fr': '',
    },
    'i8umko9j': {
      'pt': 'Tente novamente.',
      'en': '',
      'es': '',
      'fr': '',
    },
    'jef1ydsq': {
      'pt': 'OK',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // selectBottomSheet
  {
    'nt3wxoiz': {
      'pt': 'Título',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
  // Miscellaneous
  {
    'sqskf5rq': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'tx7lw8kl': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'o92l6qm5': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'v6lbp8px': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'csqqv4nm': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '4w34sfc2': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'fzdzrmq9': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3atm45bt': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'lr7axicf': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'noiyt63a': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'g1csqwcl': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'qrgnol6z': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'kiw3yog2': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'x3vxwotg': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    're4qgafq': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'q378th3f': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    't11w9npo': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'z4b30do6': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'c0b1r59x': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'asz1djkw': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'qi2v1mls': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'kvh6ejw7': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'mt50texb': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    'dv53zlul': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
    '3gyrwyzk': {
      'pt': '',
      'en': '',
      'es': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
