import 'package:flutter/material.dart';

/// Classe para armazenar informações sobre campos de formulário de texto.
class TextFormInfo {
  /// Indica se este campo é o último campo no formulário.
  final bool isLastField;

  /// Sufixo que aparece após o campo de entrada de texto.
  final String suffix;

  /// Rótulo que descreve o campo de entrada de texto.
  final String label;

  /// Texto de dica que aparece dentro do campo de entrada de texto.
  final String hint;

  /// Ícone associado a este campo de entrada de texto.
  final IconData icon;

  /// Indica se o campo de entrada de texto deve ser inicializado com um valor.
  final bool initField;

  /// Chave do formulário associada a este campo de entrada de texto.
  final GlobalKey<FormState> formKey;

  /// Node de foco usado para controlar o foco deste campo de entrada de texto.
  final FocusNode focus;

  /// Controlador de texto associado a este campo de entrada de texto.
  final TextEditingController controller;

  /// Construtor para inicializar uma instância de [TextFormInfo].
  TextFormInfo({
    this.isLastField = false,
    required this.suffix,
    required this.label,
    required this.hint,
    required this.icon,
    required this.initField,
    required this.formKey,
    required this.focus,
    required this.controller,
  });
}
