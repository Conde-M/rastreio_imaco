import 'package:flutter/material.dart';

class SecondaryWelcomePage extends StatefulWidget {
  final int showOnlyArchived;
  const SecondaryWelcomePage({super.key, required this.showOnlyArchived});

  @override
  State<SecondaryWelcomePage> createState() => _SecondaryWelcomePageState();
}

class _SecondaryWelcomePageState extends State<SecondaryWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ícone exibido no topo da tela
          Flexible(
            fit: FlexFit.loose,
            flex: 2,
            child: Icon(
              Icons.filter_list_off,
              size: 80,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          // Texto destacado dinamicamente de acordo com a condição
          Flexible(
            child: _highlightedText(
              'Ops! Nenhum registro ',
              widget.showOnlyArchived == 0 ? 'arquivado' : 'não arquivado',
              ' encontrado.',
            ),
          ),
          // Texto destacado fixo
          Flexible(
            child: _highlightedText(
              'Tente usar uma ',
              'opção de filtragem',
              ' diferente.',
            ),
          ),
          // Texto destacado condicionalmente de acordo com a opção de exibição
          widget.showOnlyArchived == 0
              ? Flexible(
                  child: _highlightedText(
                    'Lembre-se de que você pode ',
                    'arrastar os itens',
                    ' da lista para a esquerda para excluí-los e para a direita para arquivá-los.',
                  ),
                )
              : Flexible(
                  child: _highlightedText(
                    'Adicione um novo registro clicando no botão ',
                    '"Calcular IMC"',
                    ' logo abaixo.',
                  ),
                ),
          // Espaço flexível para preencher o espaço vazio
          const Spacer(),
        ],
      ),
    );
  }

  // Cria um widget RichText com partes do texto destacadas
  Widget _highlightedText(
      String prefixText, String mainText, String sufixText) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize!,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        children: [
          TextSpan(text: prefixText),
          TextSpan(
            text: mainText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withOpacity(
                        0.8,
                      ),
            ),
          ),
          if (sufixText.isNotEmpty) TextSpan(text: sufixText),
        ],
      ),
    );
  }
}
