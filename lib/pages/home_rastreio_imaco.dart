import 'dart:async';

import 'package:flutter/material.dart';
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Inicializa o repositório de registros
    _initializeRepository();
  }

  void _initializeRepository() async {
    await registersRepository.initRepository().then((_) {
      setState(() {
        // Quando os dados estiverem prontos, defina isLoading como falso
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // Certifique-se de cancelar o timer ao sair da tela
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Mostra uma tela de carregamento enquanto os dados estão sendo carregados
      return const Center(child: CircularProgressIndicator());
    } else {
      // Quando os dados estiverem prontos, exiba a tela principal
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
      registersRepository: registersRepository,
      updateListView: _updateListView,
    );
  }
}
