import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/calc_imc.dart';

class ListImcTile extends StatefulWidget {
  final CalcImc listInfo;
  final void Function(String id) removeRegister;
  final void Function(String id, bool isArchived) archiveRegister;
  final int showOnlyArchived;
  final void Function({String id, double altura, double peso})
      editCreateRegister;
  const ListImcTile({
    super.key,
    required this.listInfo,
    required this.removeRegister,
    required this.archiveRegister,
    required this.showOnlyArchived,
    required this.editCreateRegister,
  });

  @override
  State<ListImcTile> createState() => _ListImcTileState();
}

class _ListImcTileState extends State<ListImcTile> {
  bool tileSelected = false;
  @override
  Widget build(BuildContext context) {
    var formatedData = DateFormat('dd/MM').format(widget.listInfo.dataRegistro);
    return Material(
      // Constrói o componente Dismissible
      child: _dimissible(formatedData),
    );
  }

  Widget _dimissible(formatedData) {
    return Dismissible(
      key: Key(widget.listInfo.id),
      // Confirma a ação de deslizar
      confirmDismiss: _confirmDismiss,
      // Background de arquivamento
      background: _buildArchiveBackground(),
      // Background de exclusão
      secondaryBackground: _buildDeleteBackground(),
      // Constrói o ListTile
      child: _listTile(formatedData),
    );
  }

  Future<bool> _confirmDismiss(DismissDirection direction) async {
    if (direction == DismissDirection.endToStart) {
      // Mostra o diálogo de exclusão
      return await _showDeleteDialog();
    } else if (direction == DismissDirection.startToEnd) {
      // Arquiva ou desarquiva o registro
      return _archiveOrUnarchive();
    }
    return false;
  }

  Future<bool> _showDeleteDialog() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Excluir registro"),
          content: const Text("Tem certeza que deseja excluir este registro?"),
          scrollable: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value) {
        widget.removeRegister(widget.listInfo.id);
        // Mostra SnackBar
        _showSnackBar("Registro excluído com sucesso!");
      }
      return value;
    });
  }

  _archiveOrUnarchive() {
    if (widget.showOnlyArchived == 2) {
      _showSnackBar(
          "Não é possível arquivar ou desarquivar registros quando a lista está filtrada para exibir todos os registros.");
      return false;
    }
    widget.archiveRegister(widget.listInfo.id, !widget.listInfo.estaArquivado);
    // Mostra SnackBar com a mensagem de arquivamento
    _showSnackBar(widget.listInfo.estaArquivado
        ? "Registro arquivado!"
        : "Registro desarquivado!");
    return true;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Constrói o background de arquivamento
  Widget _buildArchiveBackground() {
    return Container(
      color: Theme.of(context).colorScheme.inverseSurface,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Icon(
            Icons.archive,
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          Text(
            widget.listInfo.estaArquivado ? ' Desarquivar' : ' Arquivar',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
          ),
        ],
      ),
    );
  }

  // Constrói o background de exclusão
  Widget _buildDeleteBackground() {
    return Container(
      color: Theme.of(context).colorScheme.errorContainer,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Excluir ',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
          ),
          Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ],
      ),
    );
  }

  Widget _listTile(formatedData) {
    return Tooltip(
      key: Key(widget.listInfo.id),
      enableFeedback: widget.listInfo.estaArquivado ? false : true,
      triggerMode: TooltipTriggerMode.tap,
      message: widget.listInfo.estaArquivado ? 'Arquivado' : 'Não arquivado',
      child: ListTile(
        onLongPress: () {
          tileSelected = !tileSelected;
          widget.editCreateRegister(
            id: widget.listInfo.id,
            altura: widget.listInfo.altura,
            peso: widget.listInfo.peso,
          );
        },
        onTap: null,
        key: Key(widget.listInfo.id),
        // Define as propriedades do ListTile
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        isThreeLine: true,
        enabled: widget.listInfo.estaArquivado ? false : true,
        titleAlignment: ListTileTitleAlignment.center,
        // Constrói o título
        title: _titleListTile(formatedData),
        // Constrói o subtítulo
        subtitle: _subTitlelistTile(),
      ),
    );
  }

  Widget _titleListTile(formatedData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _highlightedTextValue(
        "Valor do IMC:",
        widget.listInfo.valorImc.toStringAsFixed(2),
        Theme.of(context).textTheme.bodyLarge!.fontSize!,
        formatedData,
      ),
    );
  }

  // Retorna um widget de texto formatado com destaque
  Widget _highlightedTextValue(
      String prefixText, String mainText, double fontSize, String sufixText) {
    return ListTileTheme(
      data: Theme.of(context).listTileTheme,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            prefixText,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          RichText(
            text: TextSpan(
              text: mainText,
              style:
                  Theme.of(context).listTileTheme.subtitleTextStyle!.copyWith(
                        fontSize: fontSize,
                        fontStyle: FontStyle.normal,
                        color: Theme.of(context).colorScheme.onSurface,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 0.2
                                    : 0.8),
                      ),
            ),
          ),
          if (sufixText.isNotEmpty)
            Text(
              sufixText,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _subTitlelistTile() {
    return Column(
      children: [
        // Espaçamento entre os widgets do subtítulo
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          // Linha com os valores de peso e altura
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Valor numérico formatado para peso
              _highlightedTextValue(
                  "Peso: ",
                  "${widget.listInfo.peso.toStringAsFixed(2)} ",
                  Theme.of(context).textTheme.bodySmall!.fontSize!,
                  "kg"),
              // Valor numérico formatado para altura
              _highlightedTextValue(
                  "Altura: ",
                  "${widget.listInfo.altura.toStringAsFixed(2)} ",
                  Theme.of(context).textTheme.bodySmall!.fontSize!,
                  "m"),
            ],
          ),
        ),
        // Linha de classificação
        _highlightedTextValue("Classificação:", widget.listInfo.classificacao,
            Theme.of(context).textTheme.bodySmall!.fontSize!, ''),
      ],
    );
  }
}
