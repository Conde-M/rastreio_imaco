import 'dart:convert';

import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Classe que representa um repositório de registros de IMC
class RegistersRepository {
  // Lista interna de registros
  final List<CalcImc> _registers = [];
  bool _isInit = false;
  // Construtor padrão
  RegistersRepository();

  // Inicializa o repositório com alguns registros
  Future<void> initRepository() async {
    if (!_isInit) {
      final SharedPreferences savedLocalRegisters =
          await SharedPreferences.getInstance();
      List<String>? list = savedLocalRegisters.getStringList('ListCalcImc');
      _registers.clear();
      if (list != null) {
        for (String item in list) {
          addRegister(CalcImc.fromJson(json.decode(item)));
        }
      }
      _isInit = true;
    }
  }

  // Adiciona um novo registro ao repositório
  void addRegister(CalcImc register) {
    _registers.add(register);
    saveRegisters();
  }

  // Remove um registro com o ID especificado do repositório
  void removeRegister(String id) {
    _registers
        .remove(_registers.where((register) => (register.id == id)).first);
    saveRegisters();
  }

  // Atualiza o status de arquivamento de um registro com o ID especificado
  void archiveUnarchiveRegister(String id, bool archived) {
    (_registers.where((register) => (register.id == id)).first).estaArquivado =
        archived;
    saveRegisters();
  }

  // Atualiza o peso de um registro com o ID especificado
  void updateRegister(CalcImc imc) {
    (_registers.where((register) => (register.id == imc.id)).first).peso =
        imc.peso;
    (_registers.where((register) => (register.id == imc.id)).first).altura =
        imc.altura;
    saveRegisters();
  }

  // Retorna uma lista de registros arquivados
  List<CalcImc> listArchived() {
    return _registers.where((register) => (register.estaArquivado)).toList();
  }

  // Retorna uma lista de registros não arquivados
  List<CalcImc> listNotArchived() {
    return _registers.where((register) => (!register.estaArquivado)).toList();
  }

  // Retorna o número total de registros, considerando a opção de exibir apenas arquivados
  int length(int showOnlyArchived) {
    if (showOnlyArchived == 0) {
      return listArchived().length;
    }
    if (showOnlyArchived == 1) {
      return listNotArchived().length;
    }
    return _registers.length;
  }

  // Retorna uma lista com todos os registros
  List<CalcImc> listAllRegisters() {
    return _registers;
  }

  Future<void> saveRegisters() async {
    final savedLocalRegisters = await SharedPreferences.getInstance();
    final List<String> list = [];
    for (CalcImc item in _registers) {
      list.add(json.encode(calcImcToJson(item)));
    }
    savedLocalRegisters.setStringList('ListCalcImc', list);
  }

  CalcImc calcImcFromJson(String imcJson) {
    Map<String, dynamic> map = json.decode(imcJson);
    DateTime dataRegistro =
        DateTime.fromMillisecondsSinceEpoch(int.parse(map['dataRegistro']));
    return CalcImc(
      id: map['id'],
      peso: map['peso'],
      altura: map['altura'],
      dataRegistro: dataRegistro,
      arquivado: map['arquivado'],
    );
  }

  Map<String, dynamic> calcImcToJson(CalcImc imc) {
    return {
      'id': imc.id,
      'peso': imc.peso,
      'altura': imc.altura,
      'dataRegistro': imc.dataRegistro.millisecondsSinceEpoch.toString(),
      'arquivado': imc.estaArquivado,
    };
  }
}
