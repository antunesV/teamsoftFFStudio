import 'package:collection/collection.dart';
import "package:teamsoft_library_8991ti/backend/schema/enums/enums.dart"
    as teamsoft_library_8991ti_enums;
import 'package:ff_commons/flutter_flow/enums.dart';
export 'package:ff_commons/flutter_flow/enums.dart';

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (teamsoft_library_8991ti_enums.TypeCalendar):
      return teamsoft_library_8991ti_enums.TypeCalendar.values
          .deserialize(value) as T?;
    case (teamsoft_library_8991ti_enums.Variant):
      return teamsoft_library_8991ti_enums.Variant.values.deserialize(value)
          as T?;
    case (teamsoft_library_8991ti_enums.IconWeight):
      return teamsoft_library_8991ti_enums.IconWeight.values.deserialize(value)
          as T?;
    case (teamsoft_library_8991ti_enums.Projetos):
      return teamsoft_library_8991ti_enums.Projetos.values.deserialize(value)
          as T?;
    case (teamsoft_library_8991ti_enums.TypeCalendarFilter):
      return teamsoft_library_8991ti_enums.TypeCalendarFilter.values
          .deserialize(value) as T?;
    case (teamsoft_library_8991ti_enums.ValidationRules):
      return teamsoft_library_8991ti_enums.ValidationRules.values
          .deserialize(value) as T?;
    case (teamsoft_library_8991ti_enums.TypeField):
      return teamsoft_library_8991ti_enums.TypeField.values.deserialize(value)
          as T?;
    case (teamsoft_library_8991ti_enums.ValidationCpfCnpj):
      return teamsoft_library_8991ti_enums.ValidationCpfCnpj.values
          .deserialize(value) as T?;
    default:
      return null;
  }
}
