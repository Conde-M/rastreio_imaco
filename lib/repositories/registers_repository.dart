import 'dart:convert';

import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:rastreio_imaco/services/imaco_storage_service.dart';

// Classe que representa um repositório de registros de IMC
class RegistersRepository {
  final RegistersStorageService imacoStorage = RegistersStorageService();
  static const listCalcImc = 'ListCalcImc';
  // Construtor padrão
  RegistersRepository();

  // Adiciona um novo registro ao repositório
  Future<void> addRegister(CalcImc calcImc) async {
    await imacoStorage.saveCalcImc(calcImc);
  }

  // Remove um registro com o ID especificado do repositório
  Future<void> removeRegister(String id) async {
    await imacoStorage.removeCalcImc(id);
  }

  // Atualiza o status de arquivamento de um registro com o ID especificado
  Future<void> archiveUnarchiveRegister(String id, bool archived) async {
    await imacoStorage.updateIsArchived(id, archived);
  }

  // Atualiza o peso de um registro com o ID especificado
  Future<void> updateRegister(CalcImc calcImc) async {
    await imacoStorage.updateCalcImc(calcImc);
  }

  // Retorna o número total de registros, considerando a opção de exibir apenas arquivados
  Future<int> length({bool? showOnlyArchived}) async {
    return await imacoStorage.length(showOnlyArchived: showOnlyArchived);
  }

  // Retorna uma lista com todos os registros
  Future<List<CalcImc>> listAllRegisters({bool? showOnlyArchived}) async {
    return await imacoStorage.getCalcImcList(
        showOnlyArchived: showOnlyArchived);
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
      'arquivado': imc.isArchieved,
    };
  }
}
