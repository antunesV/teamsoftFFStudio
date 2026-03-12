import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

LatLng? toStringCoordinates(
  String? latitude,
  String? longitude,
) {
// receive latitude and longitude in arguments, and convert return format type LatLng
  if (latitude == null || longitude == null) {
    return null;
  }

  double lat = double.tryParse(latitude) ?? 0.0;
  double long = double.tryParse(longitude) ?? 0.0;

  return LatLng(lat, long);
}

dynamic toCoordinatesString(LatLng coordinate) {
  if (coordinate == null) {
    return null; // Return null if the coordinate is null
  }

  // Create a map with latitude and longitude as separate keys
  return {
    'latitude': coordinate.latitude,
    'longitude': coordinate.longitude,
  };
}

dynamic searchObject(
  List<dynamic> object,
  String key,
  String value,
) {
// Check if json, key, and value are not null
  if (object == null || key == null || value == null) {
    return null;
  }

  // Iterate through the list of JSON objects
  for (var obj in object) {
    // Check if the object is a map and contains the specified key
    if (obj is Map<String, dynamic> && obj.containsKey(key)) {
      // Check if the value associated with the key matches the specified value
      if (obj[key].toString() == value.toString()) {
        // Return the value associated with the key
        return obj;
      }
    }
  }

  // Return null if no match is found
  return null;
}

String? removeSpecialCharacters(String text) {
  // remove all special characters using regex
  return text.replaceAll(RegExp(r'[^\w\s]'), '');
}

String? toPrecision(
  double? value,
  int? precision,
) {
  // Check if the value or precision is null
  if (value == null || precision == null) {
    return null;
  }

  // Create a NumberFormat instance with the specified precision
  final NumberFormat formatter = NumberFormat('0.${'0' * precision}');

  // Format the value and return it as a string
  return formatter.format(value);
}

String? dateTimeToDate(String? date) {
  if (date == null) return null;

  try {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
  } catch (e) {
    return null;
  }
}

Color stringToColor(String color) {
  // Remove o "#" se estiver presente
  if (color.startsWith('#')) {
    color = color.substring(1);
  }

  // Se a cor estiver no formato RGB, adiciona o alpha (FF)
  if (color.length == 6) {
    color = 'FF' + color;
  }

  try {
    return Color(int.parse(color, radix: 16));
  } catch (e) {
    return Colors.black; // cor padrão em caso de erro
  }
}

DateTime timestampToDateTime(int? timestamp) {
  // convert params timestamp integer, receive timestamp unix to datetime
  if (timestamp == null) {
    return DateTime.now(); // Return current time if timestamp is null
  }
  return DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000); // Convert Unix timestamp to DateTime
}

List<dynamic> randomJsonList() {
  // return JSON list [  {"id": 1, "name": "João"},  {"id": 2, "name": "Maria"},  {"id": 3, "name": "Carlos"},  {"id": 4, "name": "Ana"},];
  return [
    {
      "id": "540bc978-1a8e-4e7f-abee-d871db96250a",
      "name": "Novo",
      "key": "NEW",
      "created_at": "2025-07-08T20:09:15.536209+00:00",
      "description":
          "Candidato acabou de ser cadastrado na plataforma e ainda não foi realizada nenhuma etapa do processo",
      "color_background": "#FFCCE8",
      "color_text": "#E21283",
      "name_es": "Nuevo",
      "name_en": "New",
      "description_es":
          "El candidato acaba de ser registrado en la plataforma y aún no se ha realizado ninguna etapa del proceso.",
      "description_en":
          "Candidate has just been registered on the platform and no step of the process has yet been completed"
    },
    {
      "id": "852095cf-31f4-4225-815f-b2c7c81bc1c6",
      "name": "Proposta enviada",
      "key": "PROPOSAL_SENT",
      "created_at": "2025-07-08T20:09:56.041881+00:00",
      "description":
          "A proposta com o cargo, descrição de suas atividades e salário foi enviada para o candidato via email.",
      "color_background": "#C9D8F7",
      "color_text": "#0F2B66",
      "name_es": "Propuesta enviada",
      "name_en": "Proposal sent",
      "description_es":
          "La propuesta con el cargo, descripción de actividades y salario fue enviada al candidato por correo electrónico.",
      "description_en":
          "The proposal with the position, description of activities and salary has been sent to the candidate via email."
    },
    {
      "id": "4034a2f1-e7a6-4258-829e-2931bcf7bad5",
      "name": "Proposta aceita",
      "key": "PROPOSAL_ACCEPTED",
      "created_at": "2025-07-08T20:13:49.671922+00:00",
      "description":
          "O candidato entrou na plataforma e aceitou a proposta. Estamos aguardando ele preencher os dados de informação complementares.",
      "color_background": "#C9D8F7",
      "color_text": "#0F2B66",
      "name_es": "Propuesta aceptada",
      "name_en": "Proposal accepted",
      "description_es":
          "El candidato ingresó a la plataforma y aceptó la propuesta. Ahora esperamos que complete los datos complementarios.",
      "description_en":
          "The candidate logged into the platform and accepted the proposal. We are now waiting for them to fill out the complementary information."
    },
    {
      "id": "4881c7f2-8af9-4c66-9e2c-69075e1d4c88",
      "name": "Em validação",
      "key": "IN_VALIDATION",
      "created_at": "2025-07-08T20:15:00.063892+00:00",
      "description":
          "O candidato preencheu todo o formulário necessário e agora as informações estão sendo analisadas internamente.",
      "color_background": "#FEF9C3",
      "color_text": "#854D0E",
      "name_es": "En validación",
      "name_en": "Under validation",
      "description_es":
          "El candidato ha completado el formulario necesario y la información está siendo revisada internamente.",
      "description_en":
          "The candidate has completed the required form and the information is now being internally reviewed."
    },
    {
      "id": "7b5c0df2-0b30-4717-8c76-f36d84783dfc",
      "name": "Contrato enviado",
      "key": "CONTRACT_SENT",
      "created_at": "2025-07-08T20:16:08.815341+00:00",
      "description":
          "O contrato foi enviado para o candidato, estamos aguardando a assinatura das partes.",
      "color_background": "#FEF9C3",
      "color_text": "#854D0E",
      "name_es": "Contrato enviado",
      "name_en": "Contract sent",
      "description_es":
          "El contrato fue enviado al candidato, estamos esperando las firmas.",
      "description_en":
          "The contract has been sent to the candidate, we are waiting for the signatures."
    },
    {
      "id": "d5e32044-ecb9-45ee-a579-179e0fa01092",
      "name": "Assinado",
      "key": "SIGNED",
      "created_at": "2025-07-08T20:17:06.945732+00:00",
      "description": "O contrato já foi assinado por ambas as partes.",
      "color_background": "#ACECC4",
      "color_text": "#13532B",
      "name_es": "Firmado",
      "name_en": "Signed",
      "description_es": "El contrato ya ha sido firmado por ambas partes.",
      "description_en": "The contract has been signed by both parties."
    },
    {
      "id": "4fdda6ff-f512-4df5-9db1-08422e330f1a",
      "name": "Concluído",
      "key": "COMPLETED",
      "created_at": "2025-07-08T20:17:41.866702+00:00",
      "description": "Tudo finalizado! O processo foi concluído.",
      "color_background": "#F2F2F2",
      "color_text": "#404040",
      "name_es": "Concluido",
      "name_en": "Completed",
      "description_es": "¡Todo finalizado! El proceso ha sido concluido.",
      "description_en": "All done! The process has been completed."
    }
  ];
}

String getDataFromField(
  dynamic json,
  String field,
) {
  return json[field].toString();
}

List<dynamic> mockMenu() {
  return [
    {
      "icon": "home",
      "title": "Dashboard",
      "page": "HomePage",
      "children": [] // sem submenu
    },
    {
      "icon": "folder",
      "title": "Cadastros",
      "page": null, // nível pai, não abre página
      "children": [
        {
          "icon": "user",
          "title": "Clientes",
          "page": "ClientesPage",
          "children": [],
        },
        {
          "icon": "store",
          "title": "Lojas",
          "page": "LojasPage",
          "children": [],
        },
      ]
    },
    {
      "icon": "settings",
      "title": "Configurações",
      "page": null,
      "children": [
        {
          "icon": "shield",
          "title": "Permissões",
          "page": "PermissoesPage",
          "children": [],
        },
        {
          "icon": "bell",
          "title": "Notificações",
          "page": "NotificacoesPage",
          "children": [],
        },
      ]
    }
  ];
}

dynamic configMenuMock() {
  return {"radioContainer": 4, "borderRadiusTag": 8};
}

dynamic userDataMenuMock() {
  return {
    "id": "01985211-6e6b-7215-b736-cf32c12fcbd2",
    "name": "João da Silva"
  };
}

int dateMonth(DateTime date) {
// return the month of a datae sent by argument
  return date.month;
}

int dateDay(DateTime date) {
// return the day of a datae sent by argument
  return date.day;
}

int dateYear(DateTime date) {
// return the year of a datae sent by argument
  return date.year;
}

List<DateTime> dateCalendarDays(
  int month,
  int year,
) {
  // Primeiro dia do mês atual
  DateTime firstDayOfMonth = DateTime(year, month, 1);
  int weekdayOfFirstDay =
      firstDayOfMonth.weekday % 7; // Segunda (1) → 1, Domingo (7) → 0

  // Dias anteriores para preencher a primeira linha (até domingo)
  int daysBefore = weekdayOfFirstDay;

  // Total de dias no mês atual
  int daysInMonth = DateTime(year, month + 1, 0).day;

  // Último dia do mês atual
  DateTime lastDayOfMonth = DateTime(year, month, daysInMonth);
  int weekdayOfLastDay =
      lastDayOfMonth.weekday % 7; // Segunda (1) → 1, Domingo (7) → 0

  // Dias posteriores para completar a semana (até sábado = 6)
  int daysAfter = (6 - weekdayOfLastDay) % 7;

  // Último dia do mês anterior
  DateTime lastDayOfPreviousMonth = DateTime(year, month, 0);
  int daysInPreviousMonth = lastDayOfPreviousMonth.day;

  // Gera dias do mês anterior para preencher o início da grade
  List<DateTime> daysBeforeList = List.generate(
    daysBefore,
    (index) => DateTime(
      year,
      month - 1,
      daysInPreviousMonth - daysBefore + index + 1,
    ),
  );

  // Dias do mês atual
  List<DateTime> daysCurrentList = List.generate(
    daysInMonth,
    (index) => DateTime(year, month, index + 1),
  );

  // Dias do próximo mês para completar a grade
  List<DateTime> daysAfterList = List.generate(
    daysAfter,
    (index) => DateTime(year, month + 1, index + 1),
  );

  return [...daysBeforeList, ...daysCurrentList, ...daysAfterList];
}

int dateWeekday(DateTime date) {
// return the weekday of a datae sent by argument
  return date.weekday;
}

String dateMonthSpelled(int month) {
  DateTime data = DateTime(2025, month, 1);

  return DateFormat.MMMM('pt_BR').format(data);
}

String dateWeekdaySpelled(DateTime date) {
  // extract weekday by argument date and convert in weekday spelled in portuguese
  List<String> weekdaysInPortuguese = [
    'domingo',
    'segunda-feira',
    'terça-feira',
    'quarta-feira',
    'quinta-feira',
    'sexta-feira',
    'sábado'
  ];
  return weekdaysInPortuguese[date.weekday % 7];
}

int dateLastDay(DateTime date) {
  // return the last day of the month of a date sent by parameter
// Get the first day of the next month
  DateTime firstDayNextMonth = DateTime(date.year, date.month + 1, 1);
  // Subtract one day to get the last day of the current month
  DateTime lastDayCurrentMonth = firstDayNextMonth.subtract(Duration(days: 1));
  return lastDayCurrentMonth.day;
}

DateTime dateCreate(
  int year,
  int month,
  int day,
) {
  // receives year, month and day and returns the date
  return DateTime(year, month, day);
}

List<dynamic> jsonByKey(
  dynamic json,
  String key,
) {
  if (json is String) {
    // Tenta decodificar se for uma string JSON
    try {
      json = jsonDecode(json);
    } catch (e) {
      print('Erro ao decodificar JSON: $e');
      return [];
    }
  }

  if (json is Map<String, dynamic> && json.containsKey(key)) {
    final value = json[key];
    print('Valor encontrado para a chave "$key": $value');

    // Garante que o valor retornado seja uma lista
    if (value is List) {
      return value;
    } else {
      print('Valor para a chave não é uma lista.');
      return [];
    }
  }

  print('Chave "$key" não encontrada no JSON.');
  return [];
}

String? formateValueToReal(String? input) {
  if (input == null) return '';

  final onlyNumbers = input.replaceAll(RegExp(r'[^0-9]'), '');

  if (onlyNumbers.isEmpty) return '';

  final value = int.parse(onlyNumbers) / 100.0;

  final formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '', // Sem R$
    name: '', // Sem BRL
    decimalDigits: 2,
  );

  return formatter.format(value).trim();
}

bool filterSingleSelecte(
  dynamic item,
  String fieldName,
  String search,
) {
  return search.isEmpty ||
      item[fieldName].toUpperCase().contains(search.toUpperCase());
}

dynamic jsonUpdateField(
  dynamic json,
  String key,
  String value,
  TypeField? type,
) {
  if (json is Map<String, dynamic>) {
    dynamic convertedValue = value;

    if (type != null) {
      switch (type) {
        case TypeField.INTEGER:
          convertedValue = int.tryParse(value);
          break;
        case TypeField.STRING:
          convertedValue = value.toString();
          break;
        case TypeField.BOOLEAN:
          convertedValue = (value == "TRUE") ? true : false;
          break;
        default:
          convertedValue = value;
      }
    }

    json[key] = convertedValue;
  }
  return json;
}

int jsonLength(dynamic json) {
  // count lenght json
  if (json is Map) {
    return json.length;
  } else if (json is List) {
    return json.length;
  }
  return 0; // Return 0 for non-iterable types
}

String getWeekday(
  int year,
  int month,
  int day,
) {
  final date = DateTime(year, month, day);

  const weekdays = {
    1: 'Seg',
    2: 'Ter',
    3: 'Qua',
    4: 'Qui',
    5: 'Sex',
    6: 'Sáb',
    7: 'Dom',
  };

  return weekdays[date.weekday] ?? '';
}

String? timestampToString(String? inputDate) {
  if (inputDate == null) return null;
  DateTime dateTime = DateTime.parse(inputDate);
  return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
}

DateTime? stringToDate(
  String date,
  String? mode,
) {
  if (date == null || date.trim().isEmpty) {
    return null;
  }

  // Define o comportamento padrão (datetime)
  final String finalMode = (mode == null || mode.isEmpty) ? 'datetime' : mode;

  DateTime dateTime;

  // Tenta identificar se tem horário junto
  if (date.contains(' ')) {
    // dd/MM/yyyy HH:mm
    try {
      dateTime = DateFormat("dd/MM/yyyy HH:mm").parse(date);
    } catch (_) {
      // fallback caso só esteja dd/MM/yyyy
      dateTime = DateFormat("dd/MM/yyyy").parse(date);
    }
  } else {
    // Apenas dd/MM/yyyy
    dateTime = DateFormat("dd/MM/yyyy").parse(date);
  }

  // Quando o modo for apenas "date"
  if (finalMode == 'date') {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  // Modo padrão: datetime
  return dateTime;
}

String? dateFormat(String? input) {
  if (input == null || input.isEmpty) {
    return null;
  }

  input = input.replaceAll(RegExp(r'[^0-9]'), '');

  // usa apenas os 8 primeiros dígitos (aqui: yyyyMMdd)
  input = input.substring(0, 8);

  // quando a string é yyyyMMdd:
  final yyyy = input.substring(0, 4);
  final mm = input.substring(4, 6);
  final dd = input.substring(6, 8);

  return "$dd/$mm/$yyyy";
}

String? dateOnChange(String input) {
  // Se input for vazio, retorna string vazia
  if (input.isEmpty) {
    return '';
  }

  // Remove tudo que não for número
  String numbers = input.replaceAll(RegExp(r'[^0-9]'), '');

  // Se não houver números, retorna string vazia
  if (numbers.isEmpty) {
    return '';
  }

  // Limita a 8 dígitos (ddMMyyyy)
  if (numbers.length > 8) {
    numbers = numbers.substring(0, 8);
  }

  // --- Validações básicas de dia, mês e ano ---

  // Validação do dia (não pode ser maior que 31) quando já tiver 2 dígitos
  if (numbers.length >= 2) {
    String day = numbers.substring(0, 2);
    int dayValue = int.tryParse(day) ?? 0;
    if (dayValue > 31) {
      // Se o dia for inválido, mantém apenas o primeiro dígito
      day = day.substring(0, 1);
      numbers = day + (numbers.length > 2 ? numbers.substring(2) : '');
    }
  }

  // Validação do mês:
  //  - quando tiver 3 dígitos: valida apenas o primeiro dígito do mês (deve ser 0 ou 1)
  //  - quando tiver 4 dígitos: valida se o mês completo (2 dígitos) é <= 12
  if (numbers.length == 3) {
    // Primeiro dígito do mês (3º dígito da string)
    String firstMonthDigit = numbers.substring(2, 3);
    if (firstMonthDigit != '0' && firstMonthDigit != '1') {
      // Se começar com 2-9, descarta o último dígito digitado (não permite 12/2, por ex.)
      numbers = numbers.substring(0, 2);
    }
  } else if (numbers.length >= 4) {
    String month = numbers.substring(2, 4);
    int monthValue = int.tryParse(month) ?? 0;
    // mês deve estar entre 01 e 12 (não pode ser 00, 13, 14, ...)
    if (monthValue == 0 || monthValue > 12) {
      // Se o mês for inválido, mantém apenas o primeiro dígito do mês
      month = month.substring(0, 1);
      // Mantém dia (2 primeiros dígitos) + primeiro dígito do mês + resto
      numbers = numbers.substring(0, 2) +
          month +
          (numbers.length > 4 ? numbers.substring(4) : '');
    }
  }

  // Validação do ano (deve começar com 1 ou 2) somente a partir do 5º dígito
  if (numbers.length >= 5) {
    String year = numbers.substring(4);
    String firstYearDigit = year.substring(0, 1);
    if (firstYearDigit != '1' && firstYearDigit != '2') {
      // Se o ano não começar com 1 ou 2, remove o último dígito digitado
      numbers = numbers.substring(0, numbers.length - 1);
    }
  }

  // --- Formatação conforme a quantidade de dígitos digitados ---
  // Reaproveita apenas a string `numbers` sanitizada/acertada

  if (numbers.length <= 2) {
    // Apenas dia (dd)
    return numbers;
  } else if (numbers.length <= 4) {
    // Dia e mês (dd/MM) → suporta 3 dígitos: ex: 311 -> 31/1
    return '${numbers.substring(0, 2)}/${numbers.substring(2)}';
  } else {
    // Dia, mês e ano (dd/MM/yyyy)
    final day = numbers.substring(0, 2);
    final month = numbers.substring(2, 4);
    final year = numbers.substring(4);
    return '$day/$month/$year';
  }
}

bool currentPageExistsInMenu(
  List<dynamic> menu,
  String currentPage,
) {
  // print(currentPage);
  // print(menu);

  for (final item in menu) {
    // print(item);
    // print(currentPage);
    if (item is Map<String, dynamic>) {
      if (item['page'] == currentPage) {
        return true;
      }
    }
  }
  return false;
}
