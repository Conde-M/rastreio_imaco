import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/calc_imc.dart';

// Widget para exibir um diálogo com informações do IMC
class DialogShowValue extends StatelessWidget {
  final ValueNotifier<CalcImc> dadosImcNotifier;

  // Construtor que recebe um objeto ValueNotifier<CalcImc>
  const DialogShowValue({Key? key, required this.dadosImcNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 16, 0),
      child: Column(
        children: [
          // Exibe o valor do IMC formatado com duas casas decimais
          Text(
            "Valor IMC: ${dadosImcNotifier.value.valorImc.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          // Exibe a classificação do IMC, se for válido
          if (dadosImcNotifier.value.classificacao != 'Inválido')
            Text(
              "Classificação: ${dadosImcNotifier.value.classificacao}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
        ],
      ),
    );
  }
}
