import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/calc_imc.dart';
import 'package:rastreio_imaco/models/text_form_info.dart';
import 'package:rastreio_imaco/repositories/registers_repository.dart';
import 'package:rastreio_imaco/widgets/dialog/dialog_show_value.dart';
import 'package:rastreio_imaco/widgets/dialog/dialog_buttons.dart';
import 'package:rastreio_imaco/widgets/dialog/input/input_text_form_field.dart';

class DialogMain extends StatefulWidget {
  final RegistersRepository registersRepository;
  final void Function({bool changeFilter}) updateListView;
  final double peso;
  final double altura;
  final String id;
  const DialogMain({
    super.key,
    required this.registersRepository,
    required this.updateListView,
    required this.peso,
    required this.altura,
    required this.id,
  });
  @override
  State<DialogMain> createState() => _DialogMainState();
}

class _DialogMainState extends State<DialogMain> {
  // GlobalKey para o formulário
  final formKey = GlobalKey<FormState>();

  // FocusNode para os campos de peso e altura
  final FocusNode pesoFocus = FocusNode();
  final FocusNode alturaFocus = FocusNode();

  // Controllers para os campos de peso e altura
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  // ValueNotifier para os dados do IMC
  late ValueNotifier<CalcImc> dadosImcNotifier;

  @override
  void initState() {
    super.initState();
    // Inicialize dadosImcNotifier aqui, onde você pode acessar widget.peso e widget.altura.
    dadosImcNotifier = ValueNotifier<CalcImc>(
      CalcImc(
        id: widget.id,
        altura: widget.altura,
        peso: widget.peso,
        dataRegistro: DateTime.now(),
      ),
    );
    if (widget.altura > 0) {
      alturaController.text = widget.altura.toStringAsFixed(2);
    }
    if (widget.peso > 0) {
      pesoController.text = widget.peso.toStringAsFixed(2);
    }

    _addListeners();
  }

  // Variável para controlar a inicialização dos campos
  bool initField = true;

  @override
  Widget build(BuildContext context) {
    // Inicia os listeners dos campos
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Material(
        color: Theme.of(context).dialogTheme.backgroundColor,
        borderRadius: BorderRadius.circular(28),
        child: _imcForm(),
      ),
    );
  }

  Widget _imcForm() {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _showValue(),
          _formFields(),
          _formButtons(),
        ],
      ),
    );
  }

  Widget _formButtons() {
    return ValueListenableBuilder<CalcImc>(
      valueListenable: dadosImcNotifier,
      builder: (context, dadosImc, child) {
        // Widget que exibe os botões do diálogo
        return DialogButtons(
          registersRepository: widget.registersRepository,
          dadosImcNotifier: dadosImcNotifier,
          updateListView: widget.updateListView,
          focus: pesoFocus,
          resetFields: resetFields,
          isAnEdit: widget.id.isNotEmpty,
        );
      },
    );
  }

  Widget _formFields() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
      child: Column(
        children: [
          // Campo de input para o peso
          InputTextFormField(
            putPointInPosition: 2,
            formData: TextFormInfo(
              suffix: 'kg',
              label: 'Peso',
              hint: 'Insira seu peso.',
              icon: Icons.nature_people_outlined,
              formKey: formKey,
              initField: initField,
              focus: pesoFocus,
              controller: pesoController,
            ),
          ),
          const Divider(),
          // Campo de input para a altura
          InputTextFormField(
            putPointInPosition: 1,
            formData: TextFormInfo(
              suffix: 'm',
              label: 'Altura',
              hint: 'Insira sua altura.',
              icon: Icons.import_export,
              formKey: formKey,
              isLastField: true,
              initField: initField,
              focus: alturaFocus,
              controller: alturaController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _showValue() {
    return ValueListenableBuilder<CalcImc>(
      valueListenable: dadosImcNotifier,
      builder: (context, dadosImc, child) {
        // Widget que exibe os valores do IMC
        return DialogShowValue(dadosImcNotifier: dadosImcNotifier);
      },
    );
  }

  // Função para redefinir os campos
  void resetFields() {
    pesoController.text = '';
    alturaController.text = '';
    dadosImcNotifier.value = CalcImc(
      altura: 0,
      peso: 0,
      dataRegistro: DateTime.now(),
    );
    initField = true;
  }

  @override
  void dispose() {
    alturaController.removeListener(_alturaListener);
    pesoController.removeListener(_pesoListener);
    super.dispose();
  }

  // Função para adicionar os listeners dos campos
  void _addListeners() {
    alturaController.addListener(_alturaListener);
    pesoController.addListener(_pesoListener);
  }

  // Função para adicionar o listener da altura
  void _alturaListener() {
    dadosImcNotifier.value = CalcImc(
        id: widget.id.isEmpty ? dadosImcNotifier.value.id : widget.id,
        altura: double.tryParse(alturaController.text) ?? 0,
        peso: dadosImcNotifier.value.peso,
        dataRegistro: DateTime.now());
  }

  // Função para adicionar o listener do peso
  void _pesoListener() {
    dadosImcNotifier.value = CalcImc(
        id: widget.id.isEmpty ? dadosImcNotifier.value.id : widget.id,
        altura: dadosImcNotifier.value.altura,
        peso: double.tryParse(pesoController.text) ?? 0,
        dataRegistro: DateTime.now());
  }
}
