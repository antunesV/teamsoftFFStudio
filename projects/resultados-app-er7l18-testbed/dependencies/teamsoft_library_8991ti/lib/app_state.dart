import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _menuCollpased = prefs.getBool('ff_menuCollpased') ?? _menuCollpased;
    });
    _safeInit(() {
      _menuOptions = prefs.getStringList('ff_menuOptions')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _menuOptions;
    });
    _safeInit(() {
      _menuHorizontal = prefs.getStringList('ff_menuHorizontal')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _menuHorizontal;
    });
    _safeInit(() {
      _gearOptions = prefs.getStringList('ff_gearOptions')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _gearOptions;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _menuCollpased = false;
  bool get menuCollpased => _menuCollpased;
  set menuCollpased(bool value) {
    _menuCollpased = value;
    prefs.setBool('ff_menuCollpased', value);
  }

  dynamic _mockJson = jsonDecode(
      '{\"meta\":{\"totalItems\":1,\"itemCount\":1,\"itemsPerPage\":10,\"totalPages\":1,\"currentPage\":1},\"items\":[{\"id\":\"6576a577-dc11-4b0b-ad0f-d9e0420d823c\",\"name\":\"Ciclano de Tal\",\"id_user\":\"aeb7d78c-8caf-4355-a51f-5294ca919104\",\"cpf\":\"83370653036\",\"birth_date\":\"1991-03-17T00:00:00.000Z\",\"phone_number\":null,\"code\":\"000002\",\"photo_url\":null,\"position\":null,\"journey_type\":null,\"repositions\":{\"2025-08-01\":[{\"id\":\"3266e603-a759-4578-9640-6d910888a4e5\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-01\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"},{\"id\":\"203e6c41-23d3-4efe-b969-686ee201a849\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-01\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"cfe36b8e-c9ce-457f-ad7a-2a0351a2ddcf\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-01\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"c8027224-842f-4186-bbc3-4d099257ef07\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-01\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"}],\"2025-08-02\":[{\"id\":\"88eee7ad-ed88-4553-bc7e-9c4716645a33\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-02\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"}],\"2025-08-03\":[{\"id\":\"5f9a0dcb-84ca-4403-add2-99de53b252ef\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-03\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"}],\"2025-08-04\":[{\"id\":\"5572677b-25f2-4881-8876-60329dc2d156\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-04\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"},{\"id\":\"41f41ef0-7dc9-4839-81da-834863537272\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-04\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"5735f242-e2d4-431f-8b2c-e67a2988bdee\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-04\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"1a30a33e-b23f-4052-bfdb-8d99655267d3\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-04\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"}],\"2025-08-05\":[{\"id\":\"1e9158c0-4803-469f-b13c-0d8da6a43d8b\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-05\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"0c9ea4db-54d9-4e66-8c5a-9e2d4f59b481\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-05\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"ac990d40-5517-4fec-82ba-fc3ac47d5c92\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-05\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"889cfba9-f2b6-4575-94f8-7717749da4fd\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-05\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"}],\"2025-08-06\":[{\"id\":\"bc08c79d-4aa6-4b98-86ab-79371b197088\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-06\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"af739c8b-f415-42ae-bf62-b9c8e830866a\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-06\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"a9791ede-e8fa-4ca2-8fc7-4a834229a4ed\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-06\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"10974439-4784-4857-883c-9d944d1665a5\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-06\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"}],\"2025-08-07\":[{\"id\":\"f1b27f1b-5944-4f8a-a6bb-f5bb0a22a43f\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-07\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"6c8ff0f6-deff-4013-a0dc-3373b1bcc8df\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-07\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"a339458d-b73e-4bc1-a3a1-4952c532e8ce\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-07\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"5cdd862d-4a4a-4213-b952-ee8fe12b1994\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-07\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"}],\"2025-08-08\":[{\"id\":\"b9184c16-0ee4-41d4-9273-0752610eed75\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-08\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"b0e8b6af-44e9-427d-95bd-7f0ba8d3d2f5\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-08\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"a46761e7-2289-4469-aa39-7e9fbf8d3fde\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-08\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"},{\"id\":\"271b6ac5-240f-48ad-b2f0-7f90e99147db\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-08\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"}],\"2025-08-09\":[{\"id\":\"f74f37f7-35be-43b6-9570-d7ce99490563\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-09\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"}],\"2025-08-10\":[{\"id\":\"e803804a-7c0f-4436-a5fe-d95de6bed0fc\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-10\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"}],\"2025-08-11\":[{\"id\":\"67d3c7c2-5d4b-4753-aca9-cf5cd4a2dff6\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-11\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"ca09a3ef-145d-49e0-b204-dce242a5cbf3\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-11\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"},{\"id\":\"040b8644-e163-4673-b261-2a8e61b30592\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-11\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"228dd19e-05e5-424b-a5f3-62911f3da755\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-11\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"}],\"2025-08-12\":[{\"id\":\"2118645d-4930-440d-ad8d-2ca5c7040b44\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-12\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"65055da1-93b8-4b7e-981c-ecc24dd151fb\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-12\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"15eab0ac-89c7-4396-8ff8-b30e48eb202b\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-12\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"2283db5f-176a-4041-8b53-68425ab8a8de\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-12\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"}],\"2025-08-13\":[{\"id\":\"57b6e9ef-f2d1-4969-9869-0145721be423\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-13\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"e48573de-f9ef-4aae-b798-2870cf82e9b9\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-13\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"},{\"id\":\"2a159b2c-8abc-4969-abf0-f5bd1e1a7a23\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-13\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"a0b45afb-29e6-487f-8a6e-33a5dd3487d9\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-13\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"}],\"2025-08-14\":[{\"id\":\"5d11852c-3870-431c-973e-20bafba30e77\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-14\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"0efb120b-747c-42d5-a0a1-7e7e66ef49e8\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-14\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"f4700c18-6692-46df-acc4-0d0b939fab25\",\"store_name\":\"Teste gaby \",\"address_id\":\"9c2b3065-2fe9-48b8-9cf9-0d26c46d6fc2\",\"address_street_address\":\"Rua HW\",\"address_neighborhood\":\"Recreio dos Bandeirantes\",\"address_city\":\"Rio de Janeiro\",\"address_state\":\"RJ\",\"address_cep\":\"22795585\"},{\"id\":\"7c51d128-b7f1-4fad-884b-0e6a64eb6cb7\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-14\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"b1f60869-edb3-4525-b28c-17c7e95a2c2a\",\"store_name\":\"Fátima e Matheus Corretores Associados ME\",\"address_id\":\"6c9878af-f10f-4126-bff5-928b7ff71203\",\"address_street_address\":\"Rua Vitorino Carmilo\",\"address_neighborhood\":\"Barra Funda\",\"address_city\":\"São Paulo\",\"address_state\":\"SP\",\"address_cep\":\"01153000\"},{\"id\":\"b124d9c0-9b39-46d8-975e-b49ed59b060e\",\"status\":\"NOT_STARTED\",\"status_view\":\"Não iniciado\",\"date_reference\":\"2025-08-14\",\"flag_id\":\"80fe60c7-75d6-429f-bafb-917b8f352b2d\",\"flag_name\":\"Atacadão\",\"store_id\":\"4b7b2d4a-d818-48e5-a62e-4450a3260c6d\",\"store_name\":\"Nova lojat\",\"address_id\":\"88d2d8ef-b2ab-46ba-a761-8e793121fad5\",\"address_street_address\":\"Rua Meireles\",\"address_neighborhood\":\"Centro\",\"address_city\":\"Campo Formoso\",\"address_state\":\"BA\",\"address_cep\":\"44790000\"}]}}]}');
  dynamic get mockJson => _mockJson;
  set mockJson(dynamic value) {
    _mockJson = value;
  }

  dynamic _tempRoadmap = jsonDecode(
      '{\"id_collaborator\":\"16afb75c-a210-417d-8681-4c5cb67ce558\",\"collaborator_name\":\"Guilherme Kauê Theo da Costa\",\"visits\":[{\"line\":1,\"items\":[{\"id\":1,\"dh_visit_start\":\"2025-09-29T09:00:00+00:00\",\"dh_visit_finish\":\"2025-09-29T11:00:00+00:00\",\"id_visit_status\":\"09bd0926-dbf1-4cc9-b3ff-5e37890c0859\",\"padding_start\":100,\"width\":100},{\"id\":2,\"dh_visit_start\":\"2025-09-29T14:00:00+00:00\",\"dh_visit_finish\":\"2025-09-29T15:00:00+00:00\",\"id_visit_status\":\"09bd0926-dbf1-4cc9-b3ff-5e37890c0859\",\"padding_start\":150,\"width\":50}]},{\"line\":2,\"items\":[{\"id\":3,\"dh_visit_start\":\"2025-09-29T10:00:00+00:00\",\"dh_visit_finish\":\"2025-09-29T12:00:00+00:00\",\"id_visit_status\":\"09bd0926-dbf1-4cc9-b3ff-5e37890c0859\",\"padding_start\":150,\"width\":100},{\"id\":5,\"dh_visit_start\":\"2025-09-29T14:30:00+00:00\",\"dh_visit_finish\":\"2025-09-29T15:30:00+00:00\",\"id_visit_status\":\"09bd0926-dbf1-4cc9-b3ff-5e37890c0859\",\"padding_start\":125,\"width\":50}]},{\"line\":3,\"items\":[{\"id\":4,\"dh_visit_start\":\"2025-09-29T10:30:00+00:00\",\"dh_visit_finish\":\"2025-09-29T11:30:00+00:00\",\"id_visit_status\":\"09bd0926-dbf1-4cc9-b3ff-5e37890c0859\",\"padding_start\":175,\"width\":50}]}]}');
  dynamic get tempRoadmap => _tempRoadmap;
  set tempRoadmap(dynamic value) {
    _tempRoadmap = value;
  }

  dynamic _tempScheduleSector = jsonDecode(
      '{\"id\":\"df5bf571-0e70-4a79-aa9e-519d1e2841da\",\"id_schedule_sector_serie\":\"aaaaaaa2-0000-0000-0000-000000000002\",\"id_sector\":\"b0efda4c-18b4-4a8e-b5fb-0b2eedee891d\",\"id_collaborator\":\"bb04f930-3872-468c-bcfb-79c511e2faaa\",\"schedule_date\":\"2025-07-13\",\"start_time\":\"07:30:00+00\",\"end_time\":\"10:00:00+00\",\"created_at\":\"2025-10-01T21:06:58.484041+00:00\",\"updated_at\":\"2025-10-01T21:06:58.484041+00:00\",\"height\":125,\"padding\":25}');
  dynamic get tempScheduleSector => _tempScheduleSector;
  set tempScheduleSector(dynamic value) {
    _tempScheduleSector = value;
  }

  List<dynamic> _menuOptions = [
    jsonDecode(
        '{\"name\":\"Sair\",\"key\":\"LOGOUT\",\"icon\":\"signOut\",\"color\":\"#E96265\"}'),
    jsonDecode(
        '{\"name\":\"Sair\",\"key\":\"LOGOUT\",\"icon\":\"signOut\",\"color\":\"#E96265\"}')
  ];
  List<dynamic> get menuOptions => _menuOptions;
  set menuOptions(List<dynamic> value) {
    _menuOptions = value;
    prefs.setStringList(
        'ff_menuOptions', value.map((x) => jsonEncode(x)).toList());
  }

  void addToMenuOptions(dynamic value) {
    menuOptions.add(value);
    prefs.setStringList(
        'ff_menuOptions', _menuOptions.map((x) => jsonEncode(x)).toList());
  }

  void removeFromMenuOptions(dynamic value) {
    menuOptions.remove(value);
    prefs.setStringList(
        'ff_menuOptions', _menuOptions.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromMenuOptions(int index) {
    menuOptions.removeAt(index);
    prefs.setStringList(
        'ff_menuOptions', _menuOptions.map((x) => jsonEncode(x)).toList());
  }

  void updateMenuOptionsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    menuOptions[index] = updateFn(_menuOptions[index]);
    prefs.setStringList(
        'ff_menuOptions', _menuOptions.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInMenuOptions(int index, dynamic value) {
    menuOptions.insert(index, value);
    prefs.setStringList(
        'ff_menuOptions', _menuOptions.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _menuHorizontal = [
    jsonDecode(
        '{\"icon\":\"Package\",\"title\":\"Logística\",\"page\":\"HomePage\",\"children\":[]}'),
    jsonDecode(
        '{\"icon\":\"ShoppingCart\",\"title\":\"Logística\",\"page\":null,\"children\":[{\"icon\":\"home\",\"title\":\"Calendario\",\"page\":\"Calendars\"}]}')
  ];
  List<dynamic> get menuHorizontal => _menuHorizontal;
  set menuHorizontal(List<dynamic> value) {
    _menuHorizontal = value;
    prefs.setStringList(
        'ff_menuHorizontal', value.map((x) => jsonEncode(x)).toList());
  }

  void addToMenuHorizontal(dynamic value) {
    menuHorizontal.add(value);
    prefs.setStringList('ff_menuHorizontal',
        _menuHorizontal.map((x) => jsonEncode(x)).toList());
  }

  void removeFromMenuHorizontal(dynamic value) {
    menuHorizontal.remove(value);
    prefs.setStringList('ff_menuHorizontal',
        _menuHorizontal.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromMenuHorizontal(int index) {
    menuHorizontal.removeAt(index);
    prefs.setStringList('ff_menuHorizontal',
        _menuHorizontal.map((x) => jsonEncode(x)).toList());
  }

  void updateMenuHorizontalAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    menuHorizontal[index] = updateFn(_menuHorizontal[index]);
    prefs.setStringList('ff_menuHorizontal',
        _menuHorizontal.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInMenuHorizontal(int index, dynamic value) {
    menuHorizontal.insert(index, value);
    prefs.setStringList('ff_menuHorizontal',
        _menuHorizontal.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _UserOptionsNutrindo = [
    jsonDecode('{\"title\":\"Meus dados\",\"page\":\"Dados\"}')
  ];
  List<dynamic> get UserOptionsNutrindo => _UserOptionsNutrindo;
  set UserOptionsNutrindo(List<dynamic> value) {
    _UserOptionsNutrindo = value;
  }

  void addToUserOptionsNutrindo(dynamic value) {
    UserOptionsNutrindo.add(value);
  }

  void removeFromUserOptionsNutrindo(dynamic value) {
    UserOptionsNutrindo.remove(value);
  }

  void removeAtIndexFromUserOptionsNutrindo(int index) {
    UserOptionsNutrindo.removeAt(index);
  }

  void updateUserOptionsNutrindoAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    UserOptionsNutrindo[index] = updateFn(_UserOptionsNutrindo[index]);
  }

  void insertAtIndexInUserOptionsNutrindo(int index, dynamic value) {
    UserOptionsNutrindo.insert(index, value);
  }

  List<dynamic> _gearOptions = [
    jsonDecode('{\"name\":\"Colaboradores\",\"page\":\"Colaborators\"}'),
    jsonDecode('{\"name\":\"Empresas\",\"page\":\"companies\"}')
  ];
  List<dynamic> get gearOptions => _gearOptions;
  set gearOptions(List<dynamic> value) {
    _gearOptions = value;
    prefs.setStringList(
        'ff_gearOptions', value.map((x) => jsonEncode(x)).toList());
  }

  void addToGearOptions(dynamic value) {
    gearOptions.add(value);
    prefs.setStringList(
        'ff_gearOptions', _gearOptions.map((x) => jsonEncode(x)).toList());
  }

  void removeFromGearOptions(dynamic value) {
    gearOptions.remove(value);
    prefs.setStringList(
        'ff_gearOptions', _gearOptions.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromGearOptions(int index) {
    gearOptions.removeAt(index);
    prefs.setStringList(
        'ff_gearOptions', _gearOptions.map((x) => jsonEncode(x)).toList());
  }

  void updateGearOptionsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    gearOptions[index] = updateFn(_gearOptions[index]);
    prefs.setStringList(
        'ff_gearOptions', _gearOptions.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInGearOptions(int index, dynamic value) {
    gearOptions.insert(index, value);
    prefs.setStringList(
        'ff_gearOptions', _gearOptions.map((x) => jsonEncode(x)).toList());
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
