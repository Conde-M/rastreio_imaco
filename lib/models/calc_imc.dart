import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rastreio_imaco/exception/valor_invalido_error.dart';

/// Classe que representa um cálculo de IMC (Índice de Massa Corporal).
class CalcImc {
  String _id = UniqueKey().toString();
  double _peso = 0;
  double _altura = 0;
  double _valorImc = 0;
  String _classificacao = "";
  DateTime _dataRegistro = DateTime.now();
  bool _estaArquivado = false;

  /// Construtor para criar uma instância de [CalcImc].
  CalcImc({
    String? id,
    required double peso,
    required double altura,
    required DateTime dataRegistro,
    bool arquivado = false,
  }) {
    _id = id == null || id.isEmpty ? _id : id;
    _peso = peso;
    _altura = altura;
    _estaArquivado = arquivado;
    _valorImc = _calcularIMC(_peso, _altura);
    _classificacao = _classificarIMC(_valorImc);
  }

  /// Obtém o ID do cálculo de IMC.
  String get id => _id;

  /// Obtém o peso.
  double get peso => _peso;

  /// Obtém a altura.
  double get altura => _altura;

  /// Obtém o valor do IMC.
  double get valorImc => _calcularIMC(_peso, _altura);

  /// Obtém a classificação do IMC.
  String get classificacao => _classificacao;

  /// Obtém a data de registro.
  // ignore: unnecessary_getters_setters
  DateTime get dataRegistro => _dataRegistro;

  /// Verifica se o cálculo de IMC está arquivado.
  // ignore: unnecessary_getters_setters
  bool get isArchieved => _estaArquivado;

  /// Define o peso e recalcula o IMC e a classificação.
  set peso(double peso) {
    if (peso < 0) {
      throw ValorInvalidoError("O peso deve ser maior que zero.");
    }
    _peso = peso;
    _valorImc = _calcularIMC(_peso, _altura);
    _classificacao = _classificarIMC(_valorImc);
  }

  /// Define a altura e recalcula o IMC e a classificação.
  set altura(double altura) {
    if (altura < 0) {
      throw ValorInvalidoError("A altura deve ser maior que zero.");
    }
    _altura = altura;
    _valorImc = _calcularIMC(_peso, _altura);
    _classificacao = _classificarIMC(_valorImc);
  }

  set valorImc(double novoValorImc) {
    if (novoValorImc <= 0) {
      throw ValorInvalidoError("O IMC deve ser maior que zero.");
    }

    // Atualiza o valor do IMC
    _valorImc = novoValorImc;

    // Recalcula o peso com base no novo IMC
    _peso = _calcularPeso(_valorImc, _altura);

    // Recalcula a altura com base no novo IMC
    _altura = _calcularAltura(_valorImc, _peso);

    // Atualiza a classificação com base no novo IMC
    _classificacao = _classificarIMC(_valorImc);
  }

  set classificacao(String valorImc) {
    _classificacao = _classificarIMC(double.tryParse(valorImc) ?? 0);
  }

  set dataRegistro(DateTime dataRegistro) => _dataRegistro = dataRegistro;
  set isArchieved(bool arquivado) => _estaArquivado = arquivado;

  /// Método privado para classificar o IMC com base nos valores padrão.
  String _classificarIMC(double valorImc) {
    switch (valorImc) {
      case == 0:
        return "Inválido";
      case < 16:
        return "Magreza grave";
      case < 17:
        return "Magreza moderada";
      case < 18.6:
        return "Magreza leve";
      case < 25:
        return "Saudável";
      case < 30:
        return "Sobrepeso";
      case < 35:
        return "Obesidade Grau I";
      case < 40:
        return "Obesidade Grau II (severa)";
      default:
        return "Obesidade Grau III (mórbida)";
    }
  }

  /// Método privado para calcular o IMC.
  double _calcularIMC(double peso, double altura) {
    if (peso == 0 || altura == 0) return 0;
    return peso / (altura * altura);
  }

  /// Método privado para calcular o peso com base no IMC e na altura.
  double _calcularPeso(double imc, double altura) {
    if (imc <= 0 || altura <= 0) {
      return 0;
    }
    return imc * altura * altura;
  }

  /// Método privado para calcular a altura com base no IMC e no peso.
  double _calcularAltura(double imc, double peso) {
    if (imc <= 0 || peso <= 0) {
      return 0;
    }
    return sqrt(peso / imc);
  }

  /// Método para serializar o objeto [CalcImc] em um mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'peso': _peso,
      'altura': _altura,
      'dataRegistro': _dataRegistro.millisecondsSinceEpoch.toString(),
      'arquivado': _estaArquivado,
    };
  }

  /// Método de fábrica para criar uma instância de [CalcImc] a partir de um mapa JSON.
  factory CalcImc.fromJson(Map<String, dynamic> imcJson) {
    DateTime dataRegistro =
        DateTime.fromMillisecondsSinceEpoch(int.parse(imcJson['dataRegistro']));
    return CalcImc(
      id: imcJson['id'],
      peso: imcJson['peso'],
      altura: imcJson['altura'],
      dataRegistro: dataRegistro,
      arquivado: imcJson['arquivado'],
    );
  }
}
