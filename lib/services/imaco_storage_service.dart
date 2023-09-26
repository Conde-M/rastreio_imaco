import 'dart:convert';

import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StorageKeys {
  listCalcImc,
}

// Classe que representa um serviço de armazenamento de registros de IMC
class RegistersStorageService {
  // Armazenamento de registros
  late SharedPreferences registersStorage;
  bool _initialized = false;

  RegistersStorageService() {
    // Inicializa a lista de registros
    _initStorage();
  }

  Future<void> _initStorage() async {
    if (!_initialized) {
      // Inicializa o armazenamento
      await SharedPreferences.getInstance().then((imcStorage) {
        return registersStorage = imcStorage;
      });
      _initialized = true;
    }
  }

  Future<void> saveCalcImc(CalcImc calcImc) async {
    _setString(calcImc.id, await _calcImcToString(calcImc));
  }

  Future<CalcImc> getCalcImc(String id) async {
    return await _calcImcFromString(id);
  }

  Future<List<String>> _getKeys() async {
    await _initStorage();
    final keys = registersStorage.getKeys();
    return keys.isEmpty ? [] : keys.toList();
  }

  Future<List<String>> _getStringList() async {
    await _initStorage();
    List<String> keys = await _getKeys();

    List<String> listString = [];
    for (String key in keys) {
      String calcImcString = await _getString(key);
      if (calcImcString.isNotEmpty) {
        listString.add(key);
      }
    }
    return listString;
  }

  Future<List<CalcImc>> getCalcImcList({bool? showOnlyArchived}) async {
    List<String> idsStringList = await _getStringList();
    if (idsStringList.isEmpty) {
      return [];
    }
    final List<CalcImc> listCalcImc =
        await getCalcImcListFromStringList(idsStringList);
    List<CalcImc> filteredListCalcImc = _filterListCalcImc(
        listCalcImc: listCalcImc, showOnlyArchived: showOnlyArchived);
    return filteredListCalcImc;
  }

  List<CalcImc> _filterListCalcImc(
      {required List<CalcImc> listCalcImc, bool? showOnlyArchived}) {
    List<CalcImc> returnListCalcImc = [];
    if (showOnlyArchived != null) {
      for (CalcImc calcImc in listCalcImc) {
        if (showOnlyArchived && calcImc.isArchieved) {
          returnListCalcImc.add(calcImc);
        } else if (!showOnlyArchived && !calcImc.isArchieved) {
          returnListCalcImc.add(calcImc);
        }
      }
      return returnListCalcImc;
    }
    return listCalcImc;
  }

  Future<List<CalcImc>> getCalcImcListFromStringList(
      List<String> listString) async {
    if (listString.isEmpty) {
      return [];
    }
    await _initStorage();
    List<CalcImc> listCalcImc = [];
    for (String id in listString) {
      CalcImc calcImc = await _calcImcFromString(id);
      if (calcImc.id.isNotEmpty) {
        listCalcImc.add(calcImc);
      }
    }
    return listCalcImc;
  }

  Future<int> length({bool? showOnlyArchived}) async {
    List<CalcImc> listCalcImc =
        await getCalcImcList(showOnlyArchived: showOnlyArchived);
    if (listCalcImc.isEmpty) {
      return 0;
    }
    return listCalcImc.length;
  }

  Future<void> removeCalcImc(String id) async {
    await _remove(id);
  }

  Future<void> updateIsArchived(String id, bool isArchived) async {
    CalcImc calcImc = await _calcImcFromString(id);
    calcImc.isArchieved = isArchived;
    await _setString(id, await _calcImcToString(calcImc));
  }

  Future<void> updateCalcImc(CalcImc calcImc) async {
    await _setString(calcImc.id, await _calcImcToString(calcImc));
  }

  // Retorna um registro a partir de uma string
  Future<CalcImc> _calcImcFromString(String id) async {
    return CalcImc.fromJson(json.decode(await _getString(id)));
  }

  // Retorna uma string a partir de um registro
  Future<String> _calcImcToString(CalcImc calcImc) async {
    return json.encode(calcImc.toJson());
  }

  Future<String> _getString(String key) async {
    await _initStorage();
    return registersStorage.getString(key) ?? '';
  }

  Future<void> _setString(String key, String value) async {
    await _initStorage();
    await registersStorage.setString(key, value);
  }

  Future<void> _remove(String key) async {
    await _initStorage();
    await registersStorage.remove(key);
  }
}
