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
  List<CalcImc> imcEntries = [];

  @override
  Widget build(BuildContext context) {
    // Carregar registros, se necessário
    return FutureBuilder(
      future: _loadRegisters(widget.showOnlyArchived),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildBodyPage();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // Construir o corpo da página
  Widget _buildBodyPage() {
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
  Future<bool> _loadRegisters(int showOnlyArchived) async {
    debugPrint('showOnlyArchived: $showOnlyArchived');
    imcEntries = await _initRepository(
      showOnlyArchived: (showOnlyArchived == 0
          ? true
          : showOnlyArchived == 1
              ? false
              : null),
    );
    return true;
  }

  // Inicializar o repositório
  Future<List<CalcImc>> _initRepository({bool? showOnlyArchived}) async {
    return await widget.registersRepository
        .listAllRegisters(showOnlyArchived: showOnlyArchived);
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
