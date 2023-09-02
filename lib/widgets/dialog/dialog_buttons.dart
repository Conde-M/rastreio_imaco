import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:rastreio_imaco/repositories/registers_repository.dart';

class DialogButtons extends StatefulWidget {
  final RegistersRepository registersRepository;
  final ValueNotifier<CalcImc> dadosImcNotifier;
  final FocusNode focus;
  final void Function({bool changeFilter}) updateListView;
  final void Function() resetFields;
  final bool isAnEdit;
  const DialogButtons({
    super.key,
    required this.registersRepository,
    required this.dadosImcNotifier,
    required this.updateListView,
    required this.focus,
    required this.resetFields,
    required this.isAnEdit,
  });

  @override
  State<DialogButtons> createState() => _DialogButtonsState();
}

class _DialogButtonsState extends State<DialogButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Botão para reiniciar campos
          _buildResetButton(),
          // Botão para guardar o IMC
          widget.isAnEdit ? _buildUpdateButton() : _buildSaveButton(),
        ],
      ),
    );
  }

  // Constrói o botão de reiniciar campos
  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _shouldResetButtonBeEnabled()
          ? () {
              setState(() {
                _resetFieldsAndShowResetDialog();
                widget.focus.requestFocus();
              });
            }
          : null,
      child: Row(
        children: [
          Icon(
            Icons.restart_alt,
            size: Theme.of(context).textTheme.labelLarge!.fontSize,
          ),
          const Text(" Reiniciar"),
        ],
      ),
    );
  }

  // Constrói o botão de guardar o IMC
  Widget _buildSaveButton() {
    return FilledButton(
      onPressed: _shouldSaveButtonBeEnabled()
          ? () {
              _saveImcAndShowSnackBar();
              widget.updateListView(changeFilter: true);
            }
          : null,
      child: const Row(
        children: [
          Icon(Icons.data_saver_on),
          Text("Guardar IMC"),
        ],
      ),
    );
  }

  // Constrói o botão de guardar o IMC
  Widget _buildUpdateButton() {
    return FilledButton(
      onPressed: _shouldSaveButtonBeEnabled()
          ? () {
              _updateImcAndSnackBar();
              widget.updateListView();
            }
          : null,
      child: const Row(
        children: [
          Icon(Icons.data_saver_on),
          Text("Atualizar IMC"),
        ],
      ),
    );
  }

  // Editar um registro
  void _updateImcAndSnackBar() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Registro atualizado na lista."),
      ),
    );
    widget.registersRepository.updateRegister(widget.dadosImcNotifier.value);
  }

  // Verifica se o botão de reiniciar deve ser habilitado
  bool _shouldResetButtonBeEnabled() {
    return widget.dadosImcNotifier.value.classificacao != "Inválido";
  }

  // Verifica se o botão de guardar o IMC deve ser habilitado
  bool _shouldSaveButtonBeEnabled() {
    final dadosImc = widget.dadosImcNotifier.value;
    return dadosImc.peso != 0 && dadosImc.altura != 0;
  }

  // Reinicia os campos e exibe o diálogo de reinício
  void _resetFieldsAndShowResetDialog() {
    widget.resetFields();
    _showResetDialog();
  }

  // Exibe o diálogo de reinício
  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Icon(Icons.restore_rounded, color: Colors.green),
              ),
              Text(
                "Campos reiniciados",
                style: Theme.of(context).dialogTheme.titleTextStyle,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 24),
                child: Divider(),
              ),
              Text(
                "Insira os valores novamente",
                style: Theme.of(context).dialogTheme.contentTextStyle,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Divider(),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Ok"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Salva o IMC, exibe o Snackbar e atualiza a lista
  void _saveImcAndShowSnackBar() {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Novo registro de IMC salvo na lista."),
      ),
    );
    widget.registersRepository.addRegister(widget.dadosImcNotifier.value);
  }
}
