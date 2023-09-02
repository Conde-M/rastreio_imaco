import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:rastreio_imaco/pages/imc_list_page.dart';
import 'package:rastreio_imaco/pages/welcome_page.dart';
import 'package:rastreio_imaco/pages/secondary_welcome_page.dart';
import 'package:rastreio_imaco/repositories/registers_repository.dart';
import 'package:rastreio_imaco/widgets/app_bar/app_bar_rastreio_imaco.dart';
import 'package:rastreio_imaco/widgets/dialog/dialog_main.dart';
import 'package:rastreio_imaco/widgets/float_action_button_rastreio_imaco.dart';

// RastreioImacoHome: O widget principal do aplicativo
class HomeRastreioImaco extends StatefulWidget {
  // Função para alternar o tema do aplicativo
  final VoidCallback toggleTheme;

  const HomeRastreioImaco({super.key, required this.toggleTheme});

  @override
  State<HomeRastreioImaco> createState() => _HomeRastreioImacoState();
}

class _HomeRastreioImacoState extends State<HomeRastreioImaco> {
  // Instância do repositório de registros
  RegistersRepository registersRepository = RegistersRepository();
  // Flag para indicar como os registros devem ser filtrados
  int showOnlyArchived = 2;
  int oldShowOnlyArchived = 2;
  Timer? _bannerTimer;

  @override
  void dispose() {
    // Certifique-se de cancelar o timer ao sair da tela
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      // Barra de título do aplicativo
      appBar: AppBarRastreioImaco(
        toggleTheme: widget.toggleTheme,
        filterRegisters: _filterRegisters,
        showOnlyArchived: showOnlyArchived,
      ),
      // Botão flutuante para adicionar um novo registro
      floatingActionButton: FloatActionButtonRastreioImaco(
        editCreateRegister: _editCreateRegister,
        registersRepository: registersRepository,
        updateListView: _updateListView,
      ),
      // Página da lista de registros
      body: _buildBodyPage(),
    );
  }

  void _editCreateRegister(
      {String id = '', double peso = 0, double altura = 0}) {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => DialogMain(
        registersRepository: registersRepository,
        updateListView: _updateListView,
        peso: peso,
        altura: altura,
        id: id,
      ),
    );
  }

  // Função para alternar entre exibir apenas registros arquivados ou não
  Widget _filterRegisters() {
    return PopupMenuButton<int>(
      splashRadius: 48,
      tooltip: 'Filtrar registros',
      onSelected: (value) {
        // Atualiza a opção de filtro e redesenha a interface
        showOnlyArchived = value;
        _updateListView();
      },
      itemBuilder: (context) {
        // Itens do menu de filtro
        return [
          const PopupMenuItem<int>(
            value: 0,
            child: Text('Exibir arquivados'),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Text('Exibir não arquivados'),
          ),
          const PopupMenuItem<int>(
            value: 2,
            child: Text('Exibir todos'),
          ),
        ];
      },
      child: _filterIcon(),
    );
  }

  // Função para construir o ícone de filtro
  Widget _filterIcon() {
    return Container(
      alignment: Alignment.center,
      width: 48,
      height: 48,
      child: Icon(
        showOnlyArchived == 0
            ? Icons.filter_alt
            : showOnlyArchived == 1
                ? Icons.filter_alt_outlined
                : Icons.filter_list,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  // Função para atualizar a exibição da lista
  void _updateListView({bool changeFilter = false}) {
    if (changeFilter) showOnlyArchived = 1;
    if (showOnlyArchived != oldShowOnlyArchived) {
      oldShowOnlyArchived = showOnlyArchived;
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      // mostrar uma mensagem no topo da tela com um Banner contando que o filtro foi alterado
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Row(
            children: [
              _filterIcon(),
              Text(
                showOnlyArchived == 0
                    ? 'Apenas arquivados'
                    : showOnlyArchived == 1
                        ? 'Apenas não arquivados'
                        : 'Todos os registros',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
          actions: [
            CloseButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
            ),
          ],
        ),
      );
      // Cancelar o timer anterior (se existir)
      _bannerTimer?.cancel();
      // Definir um novo timer para esconder o banner após 2 segundos
      _bannerTimer = Timer(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });
    }
    setState(() {});
  }

  // Função para construir o corpo da página
  Widget _buildBodyPage() {
    if (registersRepository.length(showOnlyArchived) > 0) {
      // Retorna a página de listagem de registros
      return ImcListPage(
        registersRepository: registersRepository,
        showOnlyArchived: showOnlyArchived,
        updateListView: _updateListView,
        editCreateRegister: _editCreateRegister,
      );
    }
    if (showOnlyArchived < 2 &&
        registersRepository.length(showOnlyArchived) == 0) {
      // Retorna a página de boas-vindas secundária caso não haja registros
      return SecondaryWelcomePage(showOnlyArchived: showOnlyArchived);
    }
    // Retorna a página de boas-vindas caso não haja registros
    return WelcomePage(
      startDemo: _startDemo,
    );
  }

  void _startDemo() {
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
  _addDemoRegisters() {
    for (int i = 0; i < 100; i++) {
      final random = Random();
      double randomPeso = random.nextDouble() * 100 + 30;
      double randomAltura = random.nextDouble() * 0.5 + 1.5;
      registersRepository.addRegister(
        CalcImc(
          peso: randomPeso,
          altura: randomAltura,
          dataRegistro: DateTime.now(),
        ),
      );
    }
    _updateListView(changeFilter: true);
  }
}
