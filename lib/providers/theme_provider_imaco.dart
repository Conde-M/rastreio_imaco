import 'package:flutter/material.dart';
import 'package:rastreio_imaco/providers/app_theme_imaco.dart';
import 'package:rastreio_imaco/providers/theme_notifier_imaco.dart';
import 'package:rastreio_imaco/providers/color_schemes_imaco.dart';

// Widget ProvideTheme: um StatefulWidget que envolve o aplicativo com o tema fornecido
class ThemeProviderImaco extends StatefulWidget {
  // Notificador de alterações de tema
  final ThemeNotifierImaco themeNotifier;
  // Widget do corpo do aplicativo
  final Widget body;
  const ThemeProviderImaco({
    required this.themeNotifier,
    required this.body,
    super.key,
  });

  @override
  State<ThemeProviderImaco> createState() => _ThemeProviderImacoState();
}

class _ThemeProviderImacoState extends State<ThemeProviderImaco> {
  @override
  AppThemeImaco build(BuildContext context) {
    return AppThemeImaco(
      // Configurações de tema do notificador
      settings: widget.themeNotifier,
      // Esquema de cores dinâmico para tema claro
      lightDynamic: lightColorScheme,
      // Esquema de cores dinâmico para tema escuro
      darkDynamic: darkColorScheme,
      // Corpo do aplicativo
      child: widget.body,
    );
  }
}
