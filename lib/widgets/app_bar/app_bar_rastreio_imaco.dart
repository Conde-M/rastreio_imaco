import 'package:flutter/material.dart';

class AppBarRastreioImaco extends StatefulWidget
    implements PreferredSizeWidget {
  final VoidCallback toggleTheme;
  final Widget Function() filterRegisters;
  final int showOnlyArchived;

  // Construtor da AppBar
  const AppBarRastreioImaco({
    super.key,
    required this.toggleTheme,
    required this.filterRegisters,
    required this.showOnlyArchived,
  });

  @override
  State<AppBarRastreioImaco> createState() => _AppBarRastreioImacoState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarRastreioImacoState extends State<AppBarRastreioImaco> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Rastreio Imaco'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 16),
          child: Row(
            children: [
              // Adiciona ícone com ação para filtrar os registros
              widget.filterRegisters(),
              // Adiciona ícone com ação para alternar entre tema claro e escuro na AppBar
              _changeThemeModeIcon(context, () {
                widget.toggleTheme();
              }),
            ],
          ),
        ),
      ],
    );
  }
}

// Função para criar o ícone de alternar tema
Widget _changeThemeModeIcon(BuildContext context, VoidCallback toggleTheme) {
  return Tooltip(
    message: 'Alternar entre tema claro e escuro',
    child: InkWell(
      onTap: toggleTheme,
      child: Container(
        alignment: Alignment.center,
        width: 48,
        height: 48,
        child: Icon(
          Theme.of(context).brightness == Brightness.dark
              ? Icons.lightbulb_outline_rounded
              : Icons.lightbulb_rounded,
          semanticLabel: 'Alternar entre tema claro e escuro',
        ),
      ),
    ),
  );
}
