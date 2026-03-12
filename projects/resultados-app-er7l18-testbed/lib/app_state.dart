import 'package:resultados_app/auth/supabase_auth/auth_util.dart' as auth_utils;
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import "package:teamsoft_library_8991ti/backend/schema/structs/index.dart"
    as teamsoft_library_8991ti_data_schema;
import "package:teamsoft_library_8991ti/backend/schema/enums/enums.dart"
    as teamsoft_library_8991ti_enums;
import 'package:ff_commons/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  // TS_START_TOJSON
  Map<String, dynamic> toJson() {
    try {
      return {
      'carouselConfig': carouselConfig,
      'userData': userData,
      'countryList': countryList,
      'personalDataBottomsheet': personalDataBottomsheet,

      '_auth': {
        'uid': auth_utils.currentUserUid,
        'email': auth_utils.currentUserEmail,
        'displayName': auth_utils.currentUserDisplayName,
        'loggedIn': auth_utils.currentUserUid.isNotEmpty,
      },
      };
    } catch (e) {
      return {'_error': e.toString()};
    }
  }
  // TS_END_TOJSON


  

  

  

  

  

  

  

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {

    // TS_START_STATE_EXT
    try {
      developer.registerExtension('ext.teamsoft.ff.getState', (method, parameters) async {
        try {
          final snapshot = this.toJson();
          return developer.ServiceExtensionResponse.result(jsonEncode({
            'type': 'AppState',
            'variables': snapshot,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          }));
        } catch (e) {
          return developer.ServiceExtensionResponse.result(jsonEncode({'error': e.toString()}));
        }
      });
    } catch (_) {
      // Extension already registered
    }
    // TS_END_STATE_EXT


    

    

    

    

    

    

    
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_carouselConfig')) {
        try {
          _carouselConfig =
              jsonDecode(prefs.getString('ff_carouselConfig') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_countryList')) {
        try {
          _countryList = jsonDecode(prefs.getString('ff_countryList') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_personalDataBottomsheet')) {
        try {
          _personalDataBottomsheet =
              jsonDecode(prefs.getString('ff_personalDataBottomsheet') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  dynamic _carouselConfig = jsonDecode(
      '{\"items\":[{\"imagePath\":\"assets/images/Image_1.png\",\"title\":\"Invista com simplicidade e controle, direto do seu celular.\",\"verticalText\":\"Investimento\"},{\"imagePath\":\"assets/images/Image_2.png\",\"title\":\"Acompanhe seus rendimentos em tempo real e tome decisões melhores.\",\"verticalText\":\"Crescimento\"},{\"imagePath\":\"assets/images/Image_3.png\",\"title\":\"Seu dinheiro trabalhando por você, com segurança e transparência.\",\"verticalText\":\"Simplicidade\"}],\"autoPlayMs\":5000}');
  dynamic get carouselConfig => _carouselConfig;
  set carouselConfig(dynamic value) {
    _carouselConfig = value;
    prefs.setString('ff_carouselConfig', jsonEncode(value));
  }

  dynamic _userData;
  dynamic get userData => _userData;
  set userData(dynamic value) {
    _userData = value;
  }

  /// [
  ///   { "iso": "AF", "pais": "Afeganistão", "ddi": "+93" },
  ///   { "iso": "ZA", "pais": "África do Sul", "ddi": "+27" },
  ///   { "iso": "AL", "pais": "Albânia", "ddi": "+355" },
  ///   { "iso": "DE", "pais": "Alemanha", "ddi": "+49" },
  ///   { "iso": "AD", "pais": "Andorra", "ddi": "+376" },
  ///   { "iso": "AO", "pais": "Angola", "ddi": "+244" },
  ///   { "iso": "AI", "pais": "Anguilla", "ddi": "+1-264" },
  ///   { "iso": "AG", "pais": "Antígua e Barbuda", "ddi": "+1-268" },
  ///   { "iso": "SA", "pais": "Arábia Saudita", "ddi": "+966" },
  ///   { "iso": "DZ", "pais": "Argélia", "ddi": "+213" },
  ///   { "iso": "AR", "pais": "Argentina", "ddi": "+54" },
  ///   { "iso": "AM", "pais": "Armênia", "ddi": "+374" },
  ///   { "iso": "AW", "pais": "Aruba", "ddi": "+297" },
  ///   { "iso": "AU", "pais": "Austrália", "ddi": "+61" },
  ///   { "iso": "AT", "pais": "Áustria", "ddi": "+43" },
  ///   { "iso": "AZ", "pais": "Azerbaijão", "ddi": "+994" },
  ///
  ///   { "iso": "BS", "pais": "Bahamas", "ddi": "+1-242" },
  ///   { "iso": "BH", "pais": "Bahrein", "ddi": "+973" },
  ///   { "iso": "BD", "pais": "Bangladesh", "ddi": "+880" },
  ///   { "iso": "BB", "pais": "Barbados", "ddi": "+1-246" },
  ///   { "iso": "BE", "pais": "Bélgica", "ddi": "+32" },
  ///   { "iso": "BZ", "pais": "Belize", "ddi": "+501" },
  ///   { "iso": "BJ", "pais": "Benin", "ddi": "+229" },
  ///   { "iso": "BM", "pais": "Bermudas", "ddi": "+1-441" },
  ///   { "iso": "BY", "pais": "Bielorrússia", "ddi": "+375" },
  ///   { "iso": "BO", "pais": "Bolívia", "ddi": "+591" },
  ///   { "iso": "BA", "pais": "Bósnia e Herzegovina", "ddi": "+387" },
  ///   { "iso": "BW", "pais": "Botsuana", "ddi": "+267" },
  ///   { "iso": "BR", "pais": "Brasil", "ddi": "+55" },
  ///   { "iso": "BN", "pais": "Brunei", "ddi": "+673" },
  ///   { "iso": "BG", "pais": "Bulgária", "ddi": "+359" },
  ///
  ///   { "iso": "KH", "pais": "Camboja", "ddi": "+855" },
  ///   { "iso": "CM", "pais": "Camarões", "ddi": "+237" },
  ///   { "iso": "CA", "pais": "Canadá", "ddi": "+1" },
  ///   { "iso": "CL", "pais": "Chile", "ddi": "+56" },
  ///   { "iso": "CN", "pais": "China", "ddi": "+86" },
  ///   { "iso": "CO", "pais": "Colômbia", "ddi": "+57" },
  ///   { "iso": "KR", "pais": "Coreia do Sul", "ddi": "+82" },
  ///   { "iso": "CR", "pais": "Costa Rica", "ddi": "+506" },
  ///   { "iso": "HR", "pais": "Croácia", "ddi": "+385" },
  ///   { "iso": "CU", "pais": "Cuba", "ddi": "+53" },
  ///
  ///   { "iso": "DK", "pais": "Dinamarca", "ddi": "+45" },
  ///   { "iso": "DJ", "pais": "Djibouti", "ddi": "+253" },
  ///   { "iso": "DO", "pais": "República Dominicana", "ddi": "+1-809" },
  ///
  ///   { "iso": "EG", "pais": "Egito", "ddi": "+20" },
  ///   { "iso": "AE", "pais": "Emirados Árabes Unidos", "ddi": "+971" },
  ///   { "iso": "EC", "pais": "Equador", "ddi": "+593" },
  ///   { "iso": "ES", "pais": "Espanha", "ddi": "+34" },
  ///   { "iso": "US", "pais": "Estados Unidos", "ddi": "+1" },
  ///   { "iso": "EE", "pais": "Estônia", "ddi": "+372" },
  ///   { "iso": "ET", "pais": "Etiópia", "ddi": "+251" },
  ///
  ///   { "iso": "FI", "pais": "Finlândia", "ddi": "+358" },
  ///   { "iso": "FR", "pais": "França", "ddi": "+33" },
  ///
  ///   { "iso": "GH", "pais": "Gana", "ddi": "+233" },
  ///   { "iso": "GR", "pais": "Grécia", "ddi": "+30" },
  ///   { "iso": "GT", "pais": "Guatemala", "ddi": "+502" },
  ///
  ///   { "iso": "HN", "pais": "Honduras", "ddi": "+504" },
  ///   { "iso": "HK", "pais": "Hong Kong", "ddi": "+852" },
  ///   { "iso": "HU", "pais": "Hungria", "ddi": "+36" },
  ///
  ///   { "iso": "IN", "pais": "Índia", "ddi": "+91" },
  ///   { "iso": "ID", "pais": "Indonésia", "ddi": "+62" },
  ///   { "iso": "IE", "pais": "Irlanda", "ddi": "+353" },
  ///   { "iso": "IL", "pais": "Israel", "ddi": "+972" },
  ///   { "iso": "IT", "pais": "Itália", "ddi": "+39" },
  ///
  ///   { "iso": "JP", "pais": "Japão", "ddi": "+81" },
  ///
  ///   { "iso": "KE", "pais": "Quênia", "ddi": "+254" },
  ///   { "iso": "KW", "pais": "Kuwait", "ddi": "+965" },
  ///
  ///   { "iso": "LB", "pais": "Líbano", "ddi": "+961" },
  ///   { "iso": "LU", "pais": "Luxemburgo", "ddi": "+352" },
  ///
  ///   { "iso": "MX", "pais": "México", "ddi": "+52" },
  ///   { "iso": "MA", "pais": "Marrocos", "ddi": "+212" },
  ///
  ///   { "iso": "NL", "pais": "Países Baixos", "ddi": "+31" },
  ///   { "iso": "NG", "pais": "Nigéria", "ddi": "+234" },
  ///   { "iso": "NO", "pais": "Noruega", "ddi": "+47" },
  ///   { "iso": "NZ", "pais": "Nova Zelândia", "ddi": "+64" },
  ///
  ///   { "iso": "PA", "pais": "Panamá", "ddi": "+507" },
  ///   { "iso": "PY", "pais": "Paraguai", "ddi": "+595" },
  ///   { "iso": "PE", "pais": "Peru", "ddi": "+51" },
  ///   { "iso": "PL", "pais": "Polônia", "ddi": "+48" },
  ///   { "iso": "PT", "pais": "Portugal", "ddi": "+351" },
  ///
  ///   { "iso": "GB", "pais": "Reino Unido", "ddi": "+44" },
  ///   { "iso": "CZ", "pais": "República Tcheca", "ddi": "+420" },
  ///   { "iso": "RO", "pais": "Romênia", "ddi": "+40" },
  ///   { "iso": "RU", "pais": "Rússia", "ddi": "+7" },
  ///
  ///   { "iso": "SE", "pais": "Suécia", "ddi": "+46" },
  ///   { "iso": "CH", "pais": "Suíça", "ddi": "+41" },
  ///
  ///   { "iso": "TH", "pais": "Tailândia", "ddi": "+66" },
  ///   { "iso": "TR", "pais": "Turquia", "ddi": "+90" },
  ///
  ///   { "iso": "UA", "pais": "Ucrânia", "ddi": "+380" },
  ///   { "iso": "UY", "pais": "Uruguai", "ddi": "+598" },
  ///
  ///   { "iso": "VE", "pais": "Venezuela", "ddi": "+58" },
  ///   { "iso": "VN", "pais": "Vietnã", "ddi": "+84" }
  /// ]
  ///
  dynamic _countryList = jsonDecode(
      '[{\"pais\":\"Afeganistão\",\"iso2\":\"AF\",\"ddi\":\"+93\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Albânia\",\"iso2\":\"AL\",\"ddi\":\"+355\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Alemanha\",\"iso2\":\"DE\",\"ddi\":\"+49\",\"mask_display\":\"### #######\",\"example_display\":\"000 0000000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Andorra\",\"iso2\":\"AD\",\"ddi\":\"+376\",\"mask_display\":\"### ###\",\"example_display\":\"000 000\",\"example_raw\":\"000000\"},{\"pais\":\"Angola\",\"iso2\":\"AO\",\"ddi\":\"+244\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Antígua e Barbuda\",\"iso2\":\"AG\",\"ddi\":\"+1\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Arábia Saudita\",\"iso2\":\"SA\",\"ddi\":\"+966\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Argélia\",\"iso2\":\"DZ\",\"ddi\":\"+213\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Argentina\",\"iso2\":\"AR\",\"ddi\":\"+54\",\"mask_display\":\"## #### ####\",\"example_display\":\"00 0000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Armênia\",\"iso2\":\"AM\",\"ddi\":\"+374\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Austrália\",\"iso2\":\"AU\",\"ddi\":\"+61\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Áustria\",\"iso2\":\"AT\",\"ddi\":\"+43\",\"mask_display\":\"### #######\",\"example_display\":\"000 0000000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Azerbaijão\",\"iso2\":\"AZ\",\"ddi\":\"+994\",\"mask_display\":\"## ### ## ##\",\"example_display\":\"00 000 00 00\",\"example_raw\":\"000000000\"},{\"pais\":\"Bahamas\",\"iso2\":\"BS\",\"ddi\":\"+1\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Bahrein\",\"iso2\":\"BH\",\"ddi\":\"+973\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Bangladesh\",\"iso2\":\"BD\",\"ddi\":\"+880\",\"mask_display\":\"## ##### ####\",\"example_display\":\"00 00000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Barbados\",\"iso2\":\"BB\",\"ddi\":\"+1\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Bélgica\",\"iso2\":\"BE\",\"ddi\":\"+32\",\"mask_display\":\"### ## ## ##\",\"example_display\":\"000 00 00 00\",\"example_raw\":\"000000000\"},{\"pais\":\"Belize\",\"iso2\":\"BZ\",\"ddi\":\"+501\",\"mask_display\":\"### ####\",\"example_display\":\"000 0000\",\"example_raw\":\"0000000\"},{\"pais\":\"Benin\",\"iso2\":\"BJ\",\"ddi\":\"+229\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Bielorrússia\",\"iso2\":\"BY\",\"ddi\":\"+375\",\"mask_display\":\"## ### ## ##\",\"example_display\":\"00 000 00 00\",\"example_raw\":\"000000000\"},{\"pais\":\"Bolívia\",\"iso2\":\"BO\",\"ddi\":\"+591\",\"mask_display\":\"# ### ####\",\"example_display\":\"0 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Bósnia e Herzegovina\",\"iso2\":\"BA\",\"ddi\":\"+387\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Botsuana\",\"iso2\":\"BW\",\"ddi\":\"+267\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Brasil\",\"iso2\":\"BR\",\"ddi\":\"+55\",\"mask_display\":\"## ##### #####\",\"example_display\":\"00 00000 0000\",\"example_raw\":\"00000000000\"},{\"pais\":\"Brunei\",\"iso2\":\"BN\",\"ddi\":\"+673\",\"mask_display\":\"### ####\",\"example_display\":\"000 0000\",\"example_raw\":\"0000000\"},{\"pais\":\"Bulgária\",\"iso2\":\"BG\",\"ddi\":\"+359\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Burkina Faso\",\"iso2\":\"BF\",\"ddi\":\"+226\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Burundi\",\"iso2\":\"BI\",\"ddi\":\"+257\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Butão\",\"iso2\":\"BT\",\"ddi\":\"+975\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Cabo Verde\",\"iso2\":\"CV\",\"ddi\":\"+238\",\"mask_display\":\"### ## ##\",\"example_display\":\"000 00 00\",\"example_raw\":\"0000000\"},{\"pais\":\"Camarões\",\"iso2\":\"CM\",\"ddi\":\"+237\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Camboja\",\"iso2\":\"KH\",\"ddi\":\"+855\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Canadá\",\"iso2\":\"CA\",\"ddi\":\"+1\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Catar\",\"iso2\":\"QA\",\"ddi\":\"+974\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Cazaquistão\",\"iso2\":\"KZ\",\"ddi\":\"+7\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Chade\",\"iso2\":\"TD\",\"ddi\":\"+235\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Chile\",\"iso2\":\"CL\",\"ddi\":\"+56\",\"mask_display\":\"# #### ####\",\"example_display\":\"0 0000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"China\",\"iso2\":\"CN\",\"ddi\":\"+86\",\"mask_display\":\"### #### ####\",\"example_display\":\"000 0000 0000\",\"example_raw\":\"00000000000\"},{\"pais\":\"Chipre\",\"iso2\":\"CY\",\"ddi\":\"+357\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Colômbia\",\"iso2\":\"CO\",\"ddi\":\"+57\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Coreia do Norte\",\"iso2\":\"KP\",\"ddi\":\"+850\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Coreia do Sul\",\"iso2\":\"KR\",\"ddi\":\"+82\",\"mask_display\":\"## #### ####\",\"example_display\":\"00 0000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Costa do Marfim\",\"iso2\":\"CI\",\"ddi\":\"+225\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Costa Rica\",\"iso2\":\"CR\",\"ddi\":\"+506\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Croácia\",\"iso2\":\"HR\",\"ddi\":\"+385\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Cuba\",\"iso2\":\"CU\",\"ddi\":\"+53\",\"mask_display\":\"# ### ####\",\"example_display\":\"0 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Dinamarca\",\"iso2\":\"DK\",\"ddi\":\"+45\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Egito\",\"iso2\":\"EG\",\"ddi\":\"+20\",\"mask_display\":\"## #### ####\",\"example_display\":\"00 0000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Emirados Árabes Unidos\",\"iso2\":\"AE\",\"ddi\":\"+971\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Equador\",\"iso2\":\"EC\",\"ddi\":\"+593\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Espanha\",\"iso2\":\"ES\",\"ddi\":\"+34\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Estados Unidos\",\"iso2\":\"US\",\"ddi\":\"+1\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Estônia\",\"iso2\":\"EE\",\"ddi\":\"+372\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Etiópia\",\"iso2\":\"ET\",\"ddi\":\"+251\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Filipinas\",\"iso2\":\"PH\",\"ddi\":\"+63\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Finlândia\",\"iso2\":\"FI\",\"ddi\":\"+358\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"França\",\"iso2\":\"FR\",\"ddi\":\"+33\",\"mask_display\":\"# ## ## ## ##\",\"example_display\":\"0 00 00 00 00\",\"example_raw\":\"000000000\"},{\"pais\":\"Gana\",\"iso2\":\"GH\",\"ddi\":\"+233\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Grécia\",\"iso2\":\"GR\",\"ddi\":\"+30\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Guatemala\",\"iso2\":\"GT\",\"ddi\":\"+502\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Haiti\",\"iso2\":\"HT\",\"ddi\":\"+509\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Holanda\",\"iso2\":\"NL\",\"ddi\":\"+31\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Hungria\",\"iso2\":\"HU\",\"ddi\":\"+36\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Índia\",\"iso2\":\"IN\",\"ddi\":\"+91\",\"mask_display\":\"##### #####\",\"example_display\":\"00000 00000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Indonésia\",\"iso2\":\"ID\",\"ddi\":\"+62\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Irã\",\"iso2\":\"IR\",\"ddi\":\"+98\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Iraque\",\"iso2\":\"IQ\",\"ddi\":\"+964\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Irlanda\",\"iso2\":\"IE\",\"ddi\":\"+353\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Islândia\",\"iso2\":\"IS\",\"ddi\":\"+354\",\"mask_display\":\"### ####\",\"example_display\":\"000 0000\",\"example_raw\":\"0000000\"},{\"pais\":\"Israel\",\"iso2\":\"IL\",\"ddi\":\"+972\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Itália\",\"iso2\":\"IT\",\"ddi\":\"+39\",\"mask_display\":\"### #######\",\"example_display\":\"000 0000000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Jamaica\",\"iso2\":\"JM\",\"ddi\":\"+1\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Japão\",\"iso2\":\"JP\",\"ddi\":\"+81\",\"mask_display\":\"## #### ####\",\"example_display\":\"00 0000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Jordânia\",\"iso2\":\"JO\",\"ddi\":\"+962\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Quênia\",\"iso2\":\"KE\",\"ddi\":\"+254\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Kuwait\",\"iso2\":\"KW\",\"ddi\":\"+965\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Laos\",\"iso2\":\"LA\",\"ddi\":\"+856\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Letônia\",\"iso2\":\"LV\",\"ddi\":\"+371\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Líbano\",\"iso2\":\"LB\",\"ddi\":\"+961\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Líbia\",\"iso2\":\"LY\",\"ddi\":\"+218\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Lituânia\",\"iso2\":\"LT\",\"ddi\":\"+370\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Luxemburgo\",\"iso2\":\"LU\",\"ddi\":\"+352\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Madagascar\",\"iso2\":\"MG\",\"ddi\":\"+261\",\"mask_display\":\"## ## ### ##\",\"example_display\":\"00 00 000 00\",\"example_raw\":\"000000000\"},{\"pais\":\"Malásia\",\"iso2\":\"MY\",\"ddi\":\"+60\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Maldivas\",\"iso2\":\"MV\",\"ddi\":\"+960\",\"mask_display\":\"### ####\",\"example_display\":\"000 0000\",\"example_raw\":\"0000000\"},{\"pais\":\"Mali\",\"iso2\":\"ML\",\"ddi\":\"+223\",\"mask_display\":\"## ## ## ##\",\"example_display\":\"00 00 00 00\",\"example_raw\":\"00000000\"},{\"pais\":\"Malta\",\"iso2\":\"MT\",\"ddi\":\"+356\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Marrocos\",\"iso2\":\"MA\",\"ddi\":\"+212\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"México\",\"iso2\":\"MX\",\"ddi\":\"+52\",\"mask_display\":\"## #### ####\",\"example_display\":\"00 0000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Moçambique\",\"iso2\":\"MZ\",\"ddi\":\"+258\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Namíbia\",\"iso2\":\"NA\",\"ddi\":\"+264\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Nepal\",\"iso2\":\"NP\",\"ddi\":\"+977\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Nicarágua\",\"iso2\":\"NI\",\"ddi\":\"+505\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Nigéria\",\"iso2\":\"NG\",\"ddi\":\"+234\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Noruega\",\"iso2\":\"NO\",\"ddi\":\"+47\",\"mask_display\":\"### ## ###\",\"example_display\":\"000 00 000\",\"example_raw\":\"00000000\"},{\"pais\":\"Nova Zelândia\",\"iso2\":\"NZ\",\"ddi\":\"+64\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Omã\",\"iso2\":\"OM\",\"ddi\":\"+968\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Paquistão\",\"iso2\":\"PK\",\"ddi\":\"+92\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Panamá\",\"iso2\":\"PA\",\"ddi\":\"+507\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Paraguai\",\"iso2\":\"PY\",\"ddi\":\"+595\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Peru\",\"iso2\":\"PE\",\"ddi\":\"+51\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Polônia\",\"iso2\":\"PL\",\"ddi\":\"+48\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Portugal\",\"iso2\":\"PT\",\"ddi\":\"+351\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Reino Unido\",\"iso2\":\"GB\",\"ddi\":\"+44\",\"mask_display\":\"#### ######\",\"example_display\":\"0000 000000\",\"example_raw\":\"0000000000\"},{\"pais\":\"República Dominicana\",\"iso2\":\"DO\",\"ddi\":\"+1\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"República Tcheca\",\"iso2\":\"CZ\",\"ddi\":\"+420\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Romênia\",\"iso2\":\"RO\",\"ddi\":\"+40\",\"mask_display\":\"### ### ###\",\"example_display\":\"000 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Rússia\",\"iso2\":\"RU\",\"ddi\":\"+7\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Senegal\",\"iso2\":\"SN\",\"ddi\":\"+221\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Singapura\",\"iso2\":\"SG\",\"ddi\":\"+65\",\"mask_display\":\"#### ####\",\"example_display\":\"0000 0000\",\"example_raw\":\"00000000\"},{\"pais\":\"Síria\",\"iso2\":\"SY\",\"ddi\":\"+963\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Sri Lanka\",\"iso2\":\"LK\",\"ddi\":\"+94\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Suécia\",\"iso2\":\"SE\",\"ddi\":\"+46\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Suíça\",\"iso2\":\"CH\",\"ddi\":\"+41\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Tailândia\",\"iso2\":\"TH\",\"ddi\":\"+66\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Taiwan\",\"iso2\":\"TW\",\"ddi\":\"+886\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Tanzânia\",\"iso2\":\"TZ\",\"ddi\":\"+255\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Tunísia\",\"iso2\":\"TN\",\"ddi\":\"+216\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"00000000\"},{\"pais\":\"Turquia\",\"iso2\":\"TR\",\"ddi\":\"+90\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Ucrânia\",\"iso2\":\"UA\",\"ddi\":\"+380\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Uganda\",\"iso2\":\"UG\",\"ddi\":\"+256\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Uruguai\",\"iso2\":\"UY\",\"ddi\":\"+598\",\"mask_display\":\"## ### ###\",\"example_display\":\"00 000 000\",\"example_raw\":\"000000000\"},{\"pais\":\"Venezuela\",\"iso2\":\"VE\",\"ddi\":\"+58\",\"mask_display\":\"### ### ####\",\"example_display\":\"000 000 0000\",\"example_raw\":\"0000000000\"},{\"pais\":\"Vietnã\",\"iso2\":\"VN\",\"ddi\":\"+84\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Zâmbia\",\"iso2\":\"ZM\",\"ddi\":\"+260\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"},{\"pais\":\"Zimbábue\",\"iso2\":\"ZW\",\"ddi\":\"+263\",\"mask_display\":\"## ### ####\",\"example_display\":\"00 000 0000\",\"example_raw\":\"000000000\"}]');
  dynamic get countryList => _countryList;
  set countryList(dynamic value) {
    _countryList = value;
    prefs.setString('ff_countryList', jsonEncode(value));
  }

  dynamic _personalDataBottomsheet = jsonDecode(
      '{\"genders\":[{\"title\":\"Masculino\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Feminino\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Prefiro não informar\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Outro\",\"titleColor\":\"#D9D9D9\"}],\"maritalStatus\":[{\"title\":\"Solteiro(a)\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Casado(a)\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Divorciado(a)\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Viúvo(a)\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"União de Facto\",\"titleColor\":\"#D9D9D9\"}],\"provinces\":[{\"title\":\"Bengo\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Benguela\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Bié\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Cabinda\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Cuando Cubango\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Cuanza Norte\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Cuanza Sul\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Cunene\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Huambo\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Huíla\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Luanda\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Lunda Norte\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Lunda Sul\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Malanje\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Moxico\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Namibe\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Uíge\",\"titleColor\":\"#D9D9D9\"},{\"title\":\"Zaire\",\"titleColor\":\"#D9D9D9\"}],\"countries\":{\"config\":{\"searchFields\":[\"title\",\"iso\"],\"checkbox\":{\"checkedColor\":\"#12543A\",\"checkBorderColor\":\"#A5FFFFFF\",\"checkColor\":\"#212121\",\"borderRadius\":30}},\"data\":[{\"title\":\"Afeganistão\",\"subtitle\":\"+93\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AF\"},{\"title\":\"África do Sul\",\"subtitle\":\"+27\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"ZA\"},{\"title\":\"Albânia\",\"subtitle\":\"+355\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AL\"},{\"title\":\"Alemanha\",\"subtitle\":\"+49\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"DE\"},{\"title\":\"Andorra\",\"subtitle\":\"+376\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AD\"},{\"title\":\"Angola\",\"subtitle\":\"+244\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AO\"},{\"title\":\"Argentina\",\"subtitle\":\"+54\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AR\"},{\"title\":\"Armênia\",\"subtitle\":\"+374\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AM\"},{\"title\":\"Austrália\",\"subtitle\":\"+61\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AU\"},{\"title\":\"Áustria\",\"subtitle\":\"+43\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AT\"},{\"title\":\"Azerbaijão\",\"subtitle\":\"+994\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AZ\"},{\"title\":\"Bahamas\",\"subtitle\":\"+1\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BS\"},{\"title\":\"Bahrein\",\"subtitle\":\"+973\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BH\"},{\"title\":\"Bangladesh\",\"subtitle\":\"+880\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BD\"},{\"title\":\"Bélgica\",\"subtitle\":\"+32\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BE\"},{\"title\":\"Benim\",\"subtitle\":\"+229\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BJ\"},{\"title\":\"Bolívia\",\"subtitle\":\"+591\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BO\"},{\"title\":\"Bósnia e Herzegovina\",\"subtitle\":\"+387\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BA\"},{\"title\":\"Botsuana\",\"subtitle\":\"+267\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BW\"},{\"title\":\"Brasil\",\"subtitle\":\"+55\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BR\"},{\"title\":\"Bulgária\",\"subtitle\":\"+359\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BG\"},{\"title\":\"Burkina Faso\",\"subtitle\":\"+226\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BF\"},{\"title\":\"Burundi\",\"subtitle\":\"+257\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"BI\"},{\"title\":\"Cabo Verde\",\"subtitle\":\"+238\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CV\"},{\"title\":\"Camarões\",\"subtitle\":\"+237\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CM\"},{\"title\":\"Canadá\",\"subtitle\":\"+1\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CA\"},{\"title\":\"Catar\",\"subtitle\":\"+974\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"QA\"},{\"title\":\"Chile\",\"subtitle\":\"+56\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CL\"},{\"title\":\"China\",\"subtitle\":\"+86\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CN\"},{\"title\":\"Colômbia\",\"subtitle\":\"+57\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CO\"},{\"title\":\"Coreia do Sul\",\"subtitle\":\"+82\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"KR\"},{\"title\":\"Costa Rica\",\"subtitle\":\"+506\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CR\"},{\"title\":\"Croácia\",\"subtitle\":\"+385\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"HR\"},{\"title\":\"Cuba\",\"subtitle\":\"+53\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CU\"},{\"title\":\"Dinamarca\",\"subtitle\":\"+45\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"DK\"},{\"title\":\"Egito\",\"subtitle\":\"+20\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"EG\"},{\"title\":\"Emirados Árabes Unidos\",\"subtitle\":\"+971\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"AE\"},{\"title\":\"Equador\",\"subtitle\":\"+593\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"EC\"},{\"title\":\"Espanha\",\"subtitle\":\"+34\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"ES\"},{\"title\":\"Estados Unidos\",\"subtitle\":\"+1\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"US\"},{\"title\":\"Etiópia\",\"subtitle\":\"+251\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"ET\"},{\"title\":\"Filipinas\",\"subtitle\":\"+63\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"PH\"},{\"title\":\"Finlândia\",\"subtitle\":\"+358\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"FI\"},{\"title\":\"França\",\"subtitle\":\"+33\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"FR\"},{\"title\":\"Gana\",\"subtitle\":\"+233\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"GH\"},{\"title\":\"Grécia\",\"subtitle\":\"+30\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"GR\"},{\"title\":\"Hungria\",\"subtitle\":\"+36\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"HU\"},{\"title\":\"Índia\",\"subtitle\":\"+91\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"IN\"},{\"title\":\"Indonésia\",\"subtitle\":\"+62\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"ID\"},{\"title\":\"Irlanda\",\"subtitle\":\"+353\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"IE\"},{\"title\":\"Islândia\",\"subtitle\":\"+354\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"IS\"},{\"title\":\"Israel\",\"subtitle\":\"+972\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"IL\"},{\"title\":\"Itália\",\"subtitle\":\"+39\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"IT\"},{\"title\":\"Japão\",\"subtitle\":\"+81\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"JP\"},{\"title\":\"México\",\"subtitle\":\"+52\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"MX\"},{\"title\":\"Moçambique\",\"subtitle\":\"+258\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"MZ\"},{\"title\":\"Nigéria\",\"subtitle\":\"+234\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"NG\"},{\"title\":\"Noruega\",\"subtitle\":\"+47\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"NO\"},{\"title\":\"Nova Zelândia\",\"subtitle\":\"+64\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"NZ\"},{\"title\":\"Países Baixos\",\"subtitle\":\"+31\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"NL\"},{\"title\":\"Peru\",\"subtitle\":\"+51\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"PE\"},{\"title\":\"Polônia\",\"subtitle\":\"+48\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"PL\"},{\"title\":\"Portugal\",\"subtitle\":\"+351\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"PT\"},{\"title\":\"Quênia\",\"subtitle\":\"+254\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"KE\"},{\"title\":\"Reino Unido\",\"subtitle\":\"+44\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"GB\"},{\"title\":\"Romênia\",\"subtitle\":\"+40\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"RO\"},{\"title\":\"Rússia\",\"subtitle\":\"+7\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"RU\"},{\"title\":\"Senegal\",\"subtitle\":\"+221\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"SN\"},{\"title\":\"Singapura\",\"subtitle\":\"+65\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"SG\"},{\"title\":\"Suécia\",\"subtitle\":\"+46\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"SE\"},{\"title\":\"Suíça\",\"subtitle\":\"+41\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"CH\"},{\"title\":\"Tailândia\",\"subtitle\":\"+66\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"TH\"},{\"title\":\"Tanzânia\",\"subtitle\":\"+255\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"TZ\"},{\"title\":\"Turquia\",\"subtitle\":\"+90\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"TR\"},{\"title\":\"Ucrânia\",\"subtitle\":\"+380\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"UA\"},{\"title\":\"Uganda\",\"subtitle\":\"+256\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"UG\"},{\"title\":\"Uruguai\",\"subtitle\":\"+598\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"UY\"},{\"title\":\"Venezuela\",\"subtitle\":\"+58\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"VE\"},{\"title\":\"Vietnã\",\"subtitle\":\"+84\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"VN\"},{\"title\":\"Zâmbia\",\"subtitle\":\"+260\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"ZM\"},{\"title\":\"Zimbábue\",\"subtitle\":\"+263\",\"subtitleColor\":\"#8C8C8C\",\"iso\":\"ZW\"}]}}');
  dynamic get personalDataBottomsheet => _personalDataBottomsheet;
  set personalDataBottomsheet(dynamic value) {
    _personalDataBottomsheet = value;
    prefs.setString('ff_personalDataBottomsheet', jsonEncode(value));
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
