import 'package:flutter/services.dart';

// NumericTextFormatter: Um formato de texto personalizado para campos de entrada numérica
class NumericTextFormatter extends TextInputFormatter {
  int putPointInPosition;
  NumericTextFormatter({required this.putPointInPosition});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newNumber = newValue.text;

    // Função para obter os caracteres numéricos de uma string
    String getIntegerCharacters(String inputString) {
      List<String> integerCharacters = inputString
          .split('')
          .where((character) => int.tryParse(character) != null)
          .toList();
      return integerCharacters.join('');
    }

    // Função para modificar a string de entrada para um formato específico
    String modifyString(String inputString) {
      // Se a string tiver mais de 5 caracteres, remove o primeiro caractere
      if (inputString.length > 5) {
        inputString = inputString.substring(1);
      }

      // Remove zeros à esquerda, mas mantém pelo menos um dígito
      while (inputString.length > 1 && inputString.startsWith('0')) {
        inputString = inputString.substring(1);
      }

      if (putPointInPosition == 0) putPointInPosition = 1;

      // Formata a string como um número decimal se tiver pelo menos dois dígitos
      if (inputString.length >= putPointInPosition + 1) {
        int index;
        if (inputString.length == putPointInPosition + 1) {
          index = inputString.length - 1;
        } else {
          index = inputString.length - 2;
        }
        // Insere um ponto decimal no local apropriado
        inputString =
            '${inputString.substring(0, index)}.${inputString.substring(index)}';
      }
      return inputString;
    }

    // Aplicar a formatação para restringir entrada a caracteres numéricos e formato específico
    newNumber = getIntegerCharacters(newNumber);
    newNumber = modifyString(newNumber);

    // Retornar o valor formatado com a seleção no final
    return TextEditingValue(
      text: newNumber,
      selection: TextSelection.collapsed(offset: newNumber.length),
    );
  }
}
