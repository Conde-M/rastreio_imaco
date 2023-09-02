import 'package:flutter/material.dart';
import 'package:rastreio_imaco/providers/app_theme_imaco.dart';

// Importa os pacotes necessários do Flutter e o arquivo theme.dart

class ThemeNotifierImaco extends ValueNotifier<ImacoAppThemeSettings> {
  // Cria uma classe chamada ThemeNotifier que estende ValueNotifier<ThemeSettings>.
  // A classe é responsável por notificar quando as configurações de tema mudam.

  ThemeNotifierImaco(ImacoAppThemeSettings value) : super(value);
  // Construtor da classe. Ele recebe um valor inicial de ThemeSettings (representando as configurações de tema)
  // e passa esse valor para o construtor da classe pai (ValueNotifier) usando a palavra-chave "super".
  // Isso permite que o ValueNotifier gerencie o estado interno e notifique os ouvintes quando o valor muda.

  // A partir deste ponto, você pode adicionar métodos ou funcionalidades específicas
  // para manipular as mudanças nas configurações de tema e notificar os ouvintes.
}
