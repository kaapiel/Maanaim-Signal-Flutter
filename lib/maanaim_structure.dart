import 'package:json_annotation/json_annotation.dart';
part 'maanaim_structure.g.dart';

@JsonSerializable()
class MaanaimStructure {

  final List<Regiao> regs;
  final Map<dynamic,dynamic> u;

  MaanaimStructure(this.regs, this.u);

  factory MaanaimStructure.fromJson(Map<dynamic, dynamic> json) => _$MaanaimStructureFromJson(json);
}

@JsonSerializable()
class Regiao {

  final String cor;
  final List<Setor> sets;
  final Map<dynamic,dynamic> u;

  Regiao(this.cor, this.sets, this.u);

  factory Regiao.fromJson(Map<dynamic, dynamic> json) => _$RegiaoFromJson(json);
}

@JsonSerializable()
class Setor {

  final String n;
  final List<Supervisao> sups;
  final Map<dynamic,dynamic> u;

  Setor(this.n, this.sups, this.u);

  factory Setor.fromJson(Map<dynamic,dynamic> json) => _$SetorFromJson(json);
}

@JsonSerializable()
class Supervisao {

  final String n;
  final List<IC> ics;
  final Map<dynamic,dynamic> u;

  Supervisao(this.n, this.ics, this.u);

  factory Supervisao.fromJson(Map<dynamic, dynamic> json) => _$SupervisaoFromJson(json);
}

@JsonSerializable()
class IC {

  final String n;
  final int s;
  final Map<dynamic,dynamic> u;

  IC(this.n, this.s, this.u);

  factory IC.fromJson(Map<dynamic, dynamic> json) => _$ICFromJson(json);
}