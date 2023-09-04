import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:rastreio_imaco/repositories/registers_repository.dart';

class WelcomePage extends StatefulWidget {
  final RegistersRepository registersRepository;
  final void Function({bool changeFilter}) updateListView;
  // Construtor da página de boas-vindas
  const WelcomePage(
      {super.key,
      required this.registersRepository,
      required this.updateListView});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                _startDemo(context);
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

  void _startDemo(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Iniciar demonstração?'),
          content: const Text(
            'Isso irá adicionar 100 registros aleatórios ao aplicativo.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addDemoRegisters();
              },
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  // Função para adicionar registros de demonstração
  void _addDemoRegisters() {
    for (int i = 0; i < 100; i++) {
      final random = Random();
      double randomPeso = random.nextDouble() * 100 + 30;
      double randomAltura = random.nextDouble() * 0.5 + 1.5;
      widget.registersRepository.addRegister(
        CalcImc(
          peso: randomPeso,
          altura: randomAltura,
          dataRegistro: DateTime.now(),
        ),
      );
    }
    widget.updateListView(changeFilter: true);
  }
}
