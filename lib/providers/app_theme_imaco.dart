import 'dart:math';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:rastreio_imaco/providers/text_theme_imaco.dart';

// Classe principal para gerenciar o tema do aplicativo
class AppThemeImaco extends InheritedWidget {
  const AppThemeImaco({
    Key? key,
    required this.settings,
    required this.lightDynamic,
    required this.darkDynamic,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );
// Métodos para definir o tema claro e escuro
  ThemeData light([ColorScheme? colorScheme]) {
    return ThemeData.light().copyWith(
      appBarTheme: appBarTheme(colorScheme!),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      bottomSheetTheme: bottomSheetTheme(colorScheme),
      brightness: Brightness.light,
      cardTheme: cardTheme(colorScheme),
      colorScheme: colorScheme,
      dialogTheme: dialogTheme(colorScheme),
      dividerTheme: dividerTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      filledButtonTheme: filledButtonTheme(colorScheme),
      floatingActionButtonTheme: floatingActionButtonTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
      navigationRailTheme: navigationRailTheme(colorScheme),
      pageTransitionsTheme: pageTransitionsTheme,
      scaffoldBackgroundColor: colorScheme.background,
      switchTheme: switchTheme(colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      textTheme: textThemeImaco(),
      snackBarTheme: snackBarTheme(colorScheme),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  ThemeData dark([ColorScheme? colorScheme]) {
    return ThemeData.dark().copyWith(
      appBarTheme: appBarTheme(colorScheme!),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      bottomSheetTheme: bottomSheetTheme(colorScheme),
      brightness: Brightness.dark,
      cardTheme: cardTheme(colorScheme),
      colorScheme: colorScheme,
      dialogTheme: dialogTheme(colorScheme),
      dividerTheme: dividerTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      filledButtonTheme: filledButtonTheme(colorScheme),
      floatingActionButtonTheme: floatingActionButtonTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
      navigationRailTheme: navigationRailTheme(colorScheme),
      pageTransitionsTheme: pageTransitionsTheme,
      scaffoldBackgroundColor: colorScheme.background,
      switchTheme: switchTheme(colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      textTheme: textThemeImaco(),
      snackBarTheme: snackBarTheme(colorScheme),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  final ValueNotifier<ImacoAppThemeSettings> settings;
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;

  final pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
    },
  );
  // Propriedades e métodos para definição de cores personalizadas
  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColor) {
    return Color(
        Blend.harmonize(targetColor.value, settings.value.sourceColor.value));
  }

  Color source(Color? target) {
    Color source = settings.value.sourceColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light
        ? lightDynamic?.primary
        : darkDynamic?.primary;
    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? source(targetColor),
      brightness: brightness,
    );
  }

// Métodos para definição de estilos de elementos de interface do usuário
  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );

  CardTheme cardTheme(ColorScheme colors) {
    return const CardTheme().copyWith(
      color: colors.surface,
      shadowColor: colors.shadow,
      surfaceTintColor: colors.surfaceTint,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return const ListTileThemeData().copyWith(
      iconColor: colors.onSurfaceVariant,
      leadingAndTrailingTextStyle: textThemeImaco().labelSmall,
      selectedTileColor: colors.primaryContainer,
      selectedColor: colors.secondary,
      style: ListTileStyle.list,
      textColor: colors.onSurfaceVariant,
      tileColor: colors.surfaceVariant,
      titleTextStyle: textThemeImaco().bodyLarge,
      subtitleTextStyle:
          textThemeImaco().bodyMedium!.copyWith(fontStyle: FontStyle.italic),
      shape: shapeMedium,
      enableFeedback: true,
    );
  }

  AppBarTheme appBarTheme(ColorScheme colorScheme) {
    return const AppBarTheme().copyWith(
      foregroundColor: colorScheme.onSurfaceVariant,
      titleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: textThemeImaco().titleLarge!.fontSize,
        fontFamily: textThemeImaco().titleLarge!.fontFamily,
        fontWeight: textThemeImaco().titleLarge!.fontWeight,
      ),
      surfaceTintColor: colorScheme.surfaceTint,
      color: colorScheme.surface,
      shadowColor: colorScheme.shadow,
      actionsIconTheme: IconThemeData(
        size: textThemeImaco().titleLarge!.fontSize,
        color: colorScheme.onSurface,
      ),
    );
  }

// Método para definição do tema do interruptor (switch)
  switchTheme(ColorScheme colorScheme) {
    SwitchThemeData(
      thumbColor: MaterialStateProperty.all(colorScheme.onPrimary),
      trackOutlineColor: MaterialStateProperty.all(
        adjustColor(colorScheme.brightness, colorScheme.surface, 45),
      ),
      thumbIcon: MaterialStateProperty.all(
        Icon(
          colorScheme.brightness == Brightness.dark
              ? Icons.dark_mode
              : Icons.lightbulb_rounded,
        ),
      ),
      overlayColor: MaterialStateProperty.all(colorScheme.primary),
      splashRadius: 20,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }

  DialogTheme dialogTheme(ColorScheme colorScheme) {
    return const DialogTheme().copyWith(
      backgroundColor:
          adjustColor(colorScheme.brightness, colorScheme.surface, 45),
      titleTextStyle: textThemeImaco().headlineSmall!.copyWith(
          color: adjustColor(colorScheme.brightness, colorScheme.onSurface, 45),
          fontSize: textThemeImaco().headlineSmall!.fontSize),
      contentTextStyle: textThemeImaco().bodyMedium!.copyWith(
            color: adjustColor(
                colorScheme.brightness, colorScheme.onSurfaceVariant, 45),
          ),
      iconColor: colorScheme.secondary,
      shadowColor: colorScheme.shadow,
      surfaceTintColor: colorScheme.surfaceTint,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
      ),
    );
  }

  BottomSheetThemeData bottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      backgroundColor:
          adjustColor(colorScheme.brightness, colorScheme.surface, 8),
      elevation: 1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(16),
        topEnd: Radius.circular(16),
      )),
      showDragHandle: true,
      dragHandleColor: colorScheme.onSurfaceVariant.withOpacity(0.4),
    );
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return const TabBarTheme().copyWith(
      labelColor: colors.secondary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return const BottomAppBarTheme().copyWith(
      color: colors.surface,
      elevation: 0,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return const BottomNavigationBarThemeData().copyWith(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.surfaceVariant,
      selectedItemColor: colors.onSurface,
      unselectedItemColor: colors.onSurfaceVariant,
      elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    );
  }

  NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData().copyWith();
  }

  FloatingActionButtonThemeData floatingActionButtonTheme(
      ColorScheme colorScheme) {
    return const FloatingActionButtonThemeData().copyWith(
      extendedTextStyle: TextStyle(
        fontStyle: textThemeImaco().bodyLarge!.fontStyle,
        fontFamily: textThemeImaco().bodyLarge!.fontFamily,
        textBaseline: textThemeImaco().bodyLarge!.textBaseline,
        color: colorScheme.primaryContainer,
      ),
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
      focusColor: colorScheme.onSecondaryContainer,
      hoverColor: colorScheme.onPrimaryContainer,
      splashColor: colorScheme.secondaryContainer,
    );
  }

  DrawerThemeData drawerTheme(ColorScheme colorScheme) {
    return const DrawerThemeData().copyWith(
      backgroundColor: colorScheme.surface,
    );
  }

  InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {
    return const InputDecorationTheme().copyWith(
      activeIndicatorBorder: BorderSide(color: colorScheme.outline),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.outline),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      counterStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.onSurface),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.outline),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      errorMaxLines: 1,
      errorStyle: TextStyle(color: colorScheme.error),
      fillColor: colorScheme.surfaceVariant,
      filled: true,
      floatingLabelStyle: TextStyle(color: colorScheme.primary),
      focusColor: colorScheme.primary,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      helperMaxLines: 1,
      helperStyle: TextStyle(color: colorScheme.error),
      hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      hoverColor: colorScheme.surfaceVariant,
      iconColor: colorScheme.onSurfaceVariant,
      isDense: true,
      outlineBorder: BorderSide(
        style: BorderStyle.solid,
        color: colorScheme.outline,
        width: 10,
      ),
      prefixIconColor: colorScheme.surfaceVariant,
      prefixStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      suffixIconColor: colorScheme.surfaceVariant,
      suffixStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
    );
  }

  DividerThemeData dividerTheme(ColorScheme colorScheme) {
    return const DividerThemeData().copyWith(
      color: colorScheme.outline,
    );
  }

  SnackBarThemeData snackBarTheme(ColorScheme colorScheme) {
    return const SnackBarThemeData().copyWith(
      backgroundColor: colorScheme.surface
          .withOpacity(0.8), // Inverse surface color with reduced opacity
      actionTextColor: colorScheme.onSurface, // On-surface color
      closeIconColor: colorScheme.onSurface, // On-surface color
      elevation: 3, // Elevation level 3
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // Small corner radius
      ),
      contentTextStyle: TextStyle(
        color: colorScheme.onSurface, // On-surface color
        fontFamily: 'Roboto', // Font family
        fontSize: 14, // Body medium size
        fontWeight: FontWeight.w500, // Body medium weight
        height: 1.5, // Body medium line height
        letterSpacing: 0.4, // Body medium tracking
      ),
    );
  }

  ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: const ButtonStyle().copyWith(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontFamily: textThemeImaco().labelLarge!.fontFamily,
            fontSize: textThemeImaco().labelLarge!.fontSize,
            fontWeight: textThemeImaco().labelLarge!.fontWeight,
            decorationThickness: 20,
          ),
        ),
        iconSize:
            MaterialStateProperty.all(textThemeImaco().labelLarge!.fontSize),
        enableFeedback: true,
      ),
    );
  }

  FilledButtonThemeData filledButtonTheme(ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: const ButtonStyle().copyWith(
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontFamily: textThemeImaco().labelLarge!.fontFamily,
            fontSize: textThemeImaco().labelLarge!.fontSize,
            fontWeight: textThemeImaco().labelLarge!.fontWeight,
            decorationThickness: 20,
          ),
        ),
        iconSize:
            MaterialStateProperty.all(textThemeImaco().labelLarge!.fontSize),
        enableFeedback: true,
      ),
    );
  }

// Método para ajustar a cor com base no brilho e quantidade de ajuste
  Color adjustColor(Brightness brightness, Color baseColor, int adjustAmount) {
    if (brightness == Brightness.light) {
      adjustAmount = -adjustAmount;
    }
    int r = (baseColor.red + adjustAmount).clamp(0, 255);
    int g = (baseColor.green + adjustAmount).clamp(0, 255);
    int b = (baseColor.blue + adjustAmount).clamp(0, 255);

    return Color.fromARGB(255, r, g, b);
  }

// Método para obter o modo de tema do aplicativo (claro ou escuro)
  ThemeMode themeMode() {
    return settings.value.themeMode;
  }

// Método para obter o tema com base no contexto e na cor de destino
  ThemeData theme(BuildContext context, [Color? targetColor]) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final colorScheme = colors(brightness, targetColor);
    return brightness == Brightness.light
        ? light(colorScheme)
        : dark(colorScheme);
  }

// Método estático para obter uma instância de AppThemeImaco do contexto
  static AppThemeImaco of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppThemeImaco>()!;
  }

// Override para notificar quando as configurações do tema mudam
  @override
  bool updateShouldNotify(covariant AppThemeImaco oldWidget) {
    return oldWidget.settings != settings;
  }
}

// Classe para armazenar configurações do tema do aplicativo
class ImacoAppThemeSettings {
  ImacoAppThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}

// Função para gerar uma cor aleatória
Color randomColor() {
  return Color(Random().nextInt(0xFFFFFFFF));
}

// Classe para representar uma cor personalizada
const linkColor = CustomColor(
  name: 'Link Color',
  color: Color(0xFF00B0FF),
);

class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(AppThemeImaco provider) {
    return provider.custom(this);
  }
}

// Classe para criar transições de página sem animação
class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  const NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

// Classe de notificação para alterações nas configurações do tema
class ThemeSettingChange extends Notification {
  ThemeSettingChange({required this.settings});
  final ImacoAppThemeSettings settings;
}
