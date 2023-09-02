import 'package:rastreio_imaco/models/calc_imc.dart';

// Classe que representa um repositório de registros de IMC
class RegistersRepository {
  // Lista interna de registros
  final List<CalcImc> _registers = [];
  // Construtor padrão
  RegistersRepository();

  // Adiciona um novo registro ao repositório
  void addRegister(CalcImc register) {
    _registers.add(register);
  }

  // Remove um registro com o ID especificado do repositório
  void removeRegister(String id) {
    _registers
        .remove(_registers.where((register) => (register.id == id)).first);
  }

  // Atualiza o status de arquivamento de um registro com o ID especificado
  void archiveUnarchiveRegister(String id, bool archived) {
    (_registers.where((register) => (register.id == id)).first).estaArquivado =
        archived;
  }

  // Atualiza o peso de um registro com o ID especificado
  void updateRegister(CalcImc imc) {
    (_registers.where((register) => (register.id == imc.id)).first).peso =
        imc.peso;
    (_registers.where((register) => (register.id == imc.id)).first).altura =
        imc.altura;
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
}
