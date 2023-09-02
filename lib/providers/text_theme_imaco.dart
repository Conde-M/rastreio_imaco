import 'package:flutter/material.dart';

// Função para obter um conjunto de estilos de texto personalizados
TextTheme textThemeImaco() {
  return const TextTheme(
    // Estilo de texto para tamanhos grandes, como cabeçalhos principais
    displayLarge: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 57,
      letterSpacing: -0.25,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para tamanhos médios, como cabeçalhos
    displayMedium: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 45,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para tamanhos pequenos, como números grandes
    displaySmall: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 36,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para cabeçalhos grandes
    headlineLarge: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 32,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para cabeçalhos médios
    headlineMedium: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 28,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para cabeçalhos pequenos
    headlineSmall: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 24,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para títulos grandes
    titleLarge: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 22,
      letterSpacing: 0,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para títulos médios
    titleMedium: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 16,
      letterSpacing: 0.15,
      fontWeight: FontWeight.w500,
    ),

// Estilo de texto para títulos pequenos
    titleSmall: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),

// Estilo de texto para rótulos grandes
    labelLarge: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 14,
      letterSpacing: 0.1,
      fontWeight: FontWeight.w500,
    ),

// Estilo de texto para rótulos médios
    labelMedium: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 12,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),

// Estilo de texto para rótulos pequenos
    labelSmall: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 11,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w500,
    ),

// Estilo de texto para corpo de texto grande
    bodyLarge: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 16,
      letterSpacing: 0.5,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para corpo de texto médio
    bodyMedium: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 14,
      letterSpacing: 0.25,
      fontWeight: FontWeight.w400,
    ),

// Estilo de texto para corpo de texto pequeno
    bodySmall: TextStyle(
      fontFamily: 'Decimal-book',
      fontSize: 12,
      letterSpacing: 0.4,
      fontWeight: FontWeight.w400,
    ),
  );
}
