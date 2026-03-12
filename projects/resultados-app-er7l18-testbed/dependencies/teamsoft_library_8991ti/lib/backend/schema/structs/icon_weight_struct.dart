// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IconWeightStruct extends BaseStruct {
  IconWeightStruct({
    String? name,
    IconWeight? weight,
  })  : _name = name,
        _weight = weight;

  // "name" field.
  String? _name;
  String get name => _name ?? 'Regular';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "weight" field.
  IconWeight? _weight;
  IconWeight get weight => _weight ?? IconWeight.regular;
  set weight(IconWeight? val) => _weight = val;

  bool hasWeight() => _weight != null;

  static IconWeightStruct fromMap(Map<String, dynamic> data) =>
      IconWeightStruct(
        name: data['name'] as String?,
        weight: data['weight'] is IconWeight
            ? data['weight']
            : deserializeEnum<IconWeight>(data['weight']),
      );

  static IconWeightStruct? maybeFromMap(dynamic data) => data is Map
      ? IconWeightStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'weight': _weight?.serialize(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'weight': serializeParam(
          _weight,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static IconWeightStruct fromSerializableMap(Map<String, dynamic> data) =>
      IconWeightStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        weight: deserializeParam<IconWeight>(
          data['weight'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'IconWeightStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IconWeightStruct &&
        name == other.name &&
        weight == other.weight;
  }

  @override
  int get hashCode => const ListEquality().hash([name, weight]);
}

IconWeightStruct createIconWeightStruct({
  String? name,
  IconWeight? weight,
}) =>
    IconWeightStruct(
      name: name,
      weight: weight,
    );
