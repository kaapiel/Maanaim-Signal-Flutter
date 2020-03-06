// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maanaim_structure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaanaimStructure _$MaanaimStructureFromJson(Map<dynamic, dynamic> json) {
  return MaanaimStructure(
    (json['regs'] as List)
        ?.map((e) =>
            e == null ? null : Regiao.fromJson(e as Map<dynamic, dynamic>))
        ?.toList(),
    json['u'] as Map
  );
}

Regiao _$RegiaoFromJson(Map<dynamic, dynamic> json) {
  return Regiao(
    json['cor'] as String,
    (json['sets'] as List)
        ?.map(
            (e) => e == null ? null : Setor.fromJson(e as Map<dynamic, dynamic>))
        ?.toList(),
    json['u'] as Map
  );
}

Setor _$SetorFromJson(Map<dynamic, dynamic> json) {
  return Setor(
    json['n'] as String,
    (json['sups'] as List)
        ?.map((e) =>
            e == null ? null : Supervisao.fromJson(e as Map<dynamic, dynamic>))
        ?.toList(),
    json['u'] as Map
  );
}

Supervisao _$SupervisaoFromJson(Map<dynamic, dynamic> json) {
  return Supervisao(
    json['n'] as String,
    (json['ics'] as List)
        ?.map((e) => e == null ? null : IC.fromJson(e as Map<dynamic, dynamic>))
        ?.toList(),
    json['u'] as Map
  );
}

IC _$ICFromJson(Map<dynamic, dynamic> json) {
  return IC(
    json['n'] as String,
    json['s'] as int,
    json['u'] as Map
  );
}