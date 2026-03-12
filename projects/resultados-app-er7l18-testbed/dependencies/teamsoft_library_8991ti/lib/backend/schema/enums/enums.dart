import 'package:collection/collection.dart';
import 'package:ff_commons/flutter_flow/enums.dart';
export 'package:ff_commons/flutter_flow/enums.dart';

enum TypeCalendar {
  exact,
  interval,
}

enum Variant {
  neutral,
  primary,
  dark,
}

enum IconWeight {
  regular,
  thin,
  light,
  bold,
  fill,
  duotone,
}

enum Projetos {
  MemoMusica,
  TeamTalent,
}

enum TypeCalendarFilter {
  day,
  month,
  year,
  week,
}

enum ValidationRules {
  REQUIRED,
  EQUAL,
  GREATER_THAN,
  GREATER_THAN_OR_EQUAL,
  LESS_THAN,
  LESS_THAN_OR_EQUAL,
}

enum TypeField {
  INTEGER,
  STRING,
  BOOLEAN,
}

enum ValidationCpfCnpj {
  cpf,
  cnpj,
  ambos,
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (TypeCalendar):
      return TypeCalendar.values.deserialize(value) as T?;
    case (Variant):
      return Variant.values.deserialize(value) as T?;
    case (IconWeight):
      return IconWeight.values.deserialize(value) as T?;
    case (Projetos):
      return Projetos.values.deserialize(value) as T?;
    case (TypeCalendarFilter):
      return TypeCalendarFilter.values.deserialize(value) as T?;
    case (ValidationRules):
      return ValidationRules.values.deserialize(value) as T?;
    case (TypeField):
      return TypeField.values.deserialize(value) as T?;
    case (ValidationCpfCnpj):
      return ValidationCpfCnpj.values.deserialize(value) as T?;
    default:
      return null;
  }
}
