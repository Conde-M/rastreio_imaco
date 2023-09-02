import 'package:flutter/material.dart';
import 'package:rastreio_imaco/repositories/registers_repository.dart';

class FloatActionButtonRastreioImaco extends StatefulWidget {
  final RegistersRepository registersRepository;
  final void Function({bool changeFilter}) updateListView;
  final Function() editCreateRegister;

  // Construtor do botão de ação flutuante
  const FloatActionButtonRastreioImaco({
    super.key,
    required this.registersRepository,
    required this.updateListView,
    required this.editCreateRegister,
  });

  @override
  State<FloatActionButtonRastreioImaco> createState() =>
      _FloatActionButtonRastreioImacoState();
}

class _FloatActionButtonRastreioImacoState
    extends State<FloatActionButtonRastreioImaco> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        // Exibe o diálogo para calcular o IMC
        widget.editCreateRegister();
      },
      tooltip: 'Abrir painel para calcular o valor do IMC',
      label: const Text('Calcular IMC'),
      icon: const Icon(Icons.calculate),
      shape: const StadiumBorder(
        side: BorderSide.none,
      ),
    );
  }
}
