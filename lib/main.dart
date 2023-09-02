import 'package:flutter/material.dart';
import 'package:rastreio_imaco/providers/app_theme_imaco.dart';
import 'package:rastreio_imaco/providers/theme_notifier_imaco.dart';
import 'package:rastreio_imaco/pages/home_rastreio_imaco.dart';
import 'package:rastreio_imaco/providers/color_schemes_imaco.dart';
import 'package:rastreio_imaco/providers/theme_provider_imaco.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Define se o modo escuro está ativado ou não
  bool isDarkMode = false;
  // Esquema de cores com base no modo escuro
  late ColorScheme colorScheme;
  // Modo do tema (escuro ou claro)
  late ThemeMode themeMode;
  // Define se o modo inicial foi definido
  bool _initialThemeModeIsSetted = false;
  // Notificador de alterações de tema
  late ThemeNotifierImaco themeNotifier;

  @override
  Widget build(BuildContext context) {
    // Inicializa modo do tema de acordo com a configuração no sistema
    if (_initialThemeModeIsSetted == false) _setInitialThemeMode(context);
    // Define as configurações de acordo com o modo do tema
    _setThemeColorsModeAndNotifier();
    // Obtém o provedor de tema da árvore de widgets
    final themeData = AppThemeImaco(
      // Configurações de tema do notificador
      settings: themeNotifier,
      // Esquema de cores dinâmico para tema claro
      lightDynamic: lightColorScheme,
      // Esquema de cores dinâmico para tema escuro
      darkDynamic: darkColorScheme,
      // Corpo do aplicativo
      child: Container(),
    );
    // Constrói a interface do usuário com base nas configurações do tema
    return ValueListenableBuilder<ImacoAppThemeSettings>(
      valueListenable: themeNotifier,
      builder: (context, settings, _) {
        return ThemeProviderImaco(
          themeNotifier: themeNotifier,
          body: MaterialApp(
            themeMode: themeMode,
            key: const Key('rastreio_imaco'),
            title: 'Rastreio Imaco',
            debugShowCheckedModeBanner: false,
            theme: themeData.light(lightColorScheme),
            darkTheme: themeData.dark(darkColorScheme),
            home: HomeRastreioImaco(
              toggleTheme: toggleTheme,
            ),
          ),
        );
      },
    );
  }

  // Função para alternar entre os modos de tema
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // Função para definir o modo inicial com base no brilho do sistema
  void _setInitialThemeMode(BuildContext context) {
    setState(() {
      isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
      _initialThemeModeIsSetted = true;
    });
  }

  // Função para configurar as variáveis de cores e notificador de tema
  void _setThemeColorsModeAndNotifier() {
    colorScheme = isDarkMode ? darkColorScheme : lightColorScheme;
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    // altera o notificador de acordo com o tema e as cores do tema
    themeNotifier = ThemeNotifierImaco(
      ImacoAppThemeSettings(
        sourceColor: colorScheme.primary,
        themeMode: themeMode,
      ),
    );
  }
}
