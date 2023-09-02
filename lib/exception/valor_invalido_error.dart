class ValorInvalidoError extends Error {
  final String mensagem;

  ValorInvalidoError(this.mensagem);

  @override
  String toString() {
    return 'ValorInvalidoError: $mensagem';
  }
}
