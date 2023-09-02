import 'package:flutter/material.dart';
import 'package:rastreio_imaco/models/text_form_info.dart';
import 'package:rastreio_imaco/utils/numeric_text_formatter.dart';

class InputTextFormField extends StatefulWidget {
  final TextFormInfo formData;
  final int putPointInPosition;
  const InputTextFormField(
      {super.key, required this.formData, required this.putPointInPosition});

  @override
  State<InputTextFormField> createState() => _InputTextFormFieldState();
}

class _InputTextFormFieldState extends State<InputTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      autocorrect: false,
      enableSuggestions: false,
      focusNode: widget.formData.focus,
      controller: widget.formData.controller,
      textInputAction: widget.formData.isLastField
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        NumericTextFormatter(
          putPointInPosition: widget.putPointInPosition,
        )
      ],
      validator: (value) {
        // Valida se o campo está vazio quando não é o campo inicial
        if (widget.formData.initField == false &&
            (value == null || value.isEmpty)) {
          return "Insira um valor.";
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 12.0),
          child: Icon(
            widget.formData.icon,
            color: Theme.of(context).inputDecorationTheme.iconColor,
          ),
        ),
        suffixText: widget.formData.suffix,
        labelText: widget.formData.label,
        hintText: widget.formData.hint,
      ),
      onChanged: (value) {
        // Atualiza o valor do controlador se a validação for bem-sucedida
        if (widget.formData.formKey.currentState!.validate()) {
          widget.formData.controller.text = value;
        }
        // Define a seleção de texto para o final
        widget.formData.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.formData.controller.text.length),
        );
      },
      onFieldSubmitted: (value) {
        // Atualiza o valor do controlador se a validação for bem-sucedida
        if (widget.formData.formKey.currentState!.validate()) {
          widget.formData.controller.text = value;
        }
      },
      onTapOutside: (event) {
        // Remove o foco do campo quando tocado fora
        widget.formData.focus.unfocus();
      },
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
