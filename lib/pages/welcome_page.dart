import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final void Function() startDemo;

  // Construtor da página de boas-vindas
  const WelcomePage({super.key, required this.startDemo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: MediaQuery.of(context).orientation == Orientation.portrait
                ? 2
                : 3,
            child: InkWell(
              onLongPress: () {
                startDemo();
              },
              child: Icon(
                Icons.home,
                size: MediaQuery.of(context).orientation == Orientation.portrait
                    ? 80
                    : 50,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          Flexible(
            child: Text(
              // Mensagem de boas-vindas
              'Bem-vindo ao aplicativo Rastreio Imaco!',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Flexible(
            child: Text(
              // Instrução inicial
              'Para começar, toque no botão "Calcular IMC".',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Flexible(
            flex: MediaQuery.of(context).orientation == Orientation.portrait
                ? 1
                : 2,
            child: Text(
              // Instrução sobre alternar temas
              'Você pode alternar entre os temas claro e escuro tocando na lâmpada no canto superior direito da tela.',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Flexible(
            flex: MediaQuery.of(context).orientation == Orientation.portrait
                ? 1
                : 2,
            child: Text(
              // Instrução sobre arrastar itens da lista
              'Lembre-se de que você pode deslizar os itens da lista para a esquerda para excluí-los e para a direita para arquivá-los. Para editar um item, segure sobre ele.',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Flexible(
            flex: MediaQuery.of(context).orientation == Orientation.portrait
                ? 1
                : 2,
            child: Text(
              // Instrução sobre filtrar registros
              'Você também pode filtrar os registros usando o ícone à esquerda da lâmpada.',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Flexible(
            flex: MediaQuery.of(context).orientation == Orientation.portrait
                ? 1
                : 2,
            child: Text(
              // Instrução sobre o modo de demonstração
              'Para iniciar o modo de demonstração, segure o ícone da casa. Ele adicionará 100 registros aleatórios para testar o aplicativo com muitos registros.',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),

// Espaço flexível para preencher o espaço vazio
          Spacer(
            flex: MediaQuery.of(context).orientation == Orientation.portrait
                ? 1
                : 4,
          ),
        ],
      ),
    );
  }
}
