// Importações de pacotes e bibliotecas
import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:rastreio_imaco/repositories/registers_repository.dart';
import 'package:rastreio_imaco/widgets/list_tile/list_imc_tile.dart';

// Página que exibe uma lista de entradas de IMC
class ImcListPage extends StatefulWidget {
  final RegistersRepository registersRepository;
  final int showOnlyArchived;
  final void Function() updateListView;
  final void Function({String id, double altura, double peso})
      editCreateRegister;
  const ImcListPage({
    super.key,
    required this.registersRepository,
    required this.showOnlyArchived,
    required this.updateListView,
    required this.editCreateRegister,
  });

  @override
  State<ImcListPage> createState() => _ImcListPageState();
}

// Estado da página ImcListPage
class _ImcListPageState extends State<ImcListPage> {
  // Lista de entradas de IMC
  late List<CalcImc> imcEntries;
  // Flag para controle de inicialização do repositório
  bool _repositoryInitialized = false;

  @override
  Widget build(BuildContext context) {
    // Carregar registros, se necessário
    _loadRegistersIfNeeded();
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        itemCount: imcEntries.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListBody(
            children: [
              ListImcTile(
                // Informações da entrada de IMC
                listInfo: imcEntries[index],
                // Função para remover o registro
                removeRegister: _removeRegister,
                // Função para arquivar o registro
                archiveRegister: _archiveUnarchiveRegister,
                // Função para mostrar o diálogo de edição de registro
                editCreateRegister: widget.editCreateRegister,
                // Opção de mostrar apenas arquivados
                showOnlyArchived: widget.showOnlyArchived,
              ),
              // Espaço adicional após a última entrada
              if (index == imcEntries.length - 1) const SizedBox(height: 70),
            ],
          );
        },
      ),
    );
  }

  // Carregar registros, se necessário
  void _loadRegistersIfNeeded() {
    if (!_repositoryInitialized) {
      // Inicializar o repositório
      imcEntries = _initRepository();
      _repositoryInitialized = true;
    }
    if (widget.showOnlyArchived == 0) {
      // Mostrar registros arquivados
      imcEntries = widget.registersRepository.listArchived();
    } else if (widget.showOnlyArchived == 1) {
      // Mostrar registros não arquivados
      imcEntries = widget.registersRepository.listNotArchived();
    } else if (widget.showOnlyArchived == 2) {
      // Mostrar todos os registros
      imcEntries = widget.registersRepository.listAllRegisters();
    }
  }

  // Inicializar o repositório
  List<CalcImc> _initRepository() {
    return widget.registersRepository.listAllRegisters();
  }

  // Remover um registro
  void _removeRegister(String id) {
    widget.registersRepository.removeRegister(id);
    widget.updateListView();
  }

  // Arquivar ou desarquivar um registro
  void _archiveUnarchiveRegister(String id, bool isArchived) {
    widget.registersRepository.archiveUnarchiveRegister(id, isArchived);
    widget.updateListView();
  }
}
