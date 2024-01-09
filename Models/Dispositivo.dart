class Dispositivo {
  int _id;
  String _nSerie;
  String _senha;
  int _primeiroAcesso;
  String _updatedAt;

  Dispositivo(
    this._id,
    this._nSerie,
    this._senha,
    this._primeiroAcesso,
    this._updatedAt,
  );
  int get id => _id;
  set id(int value) {
    _id = value;
  }

  String get nSerie => _nSerie;
  set nSerie(String value) {
    _nSerie = value;
  }

  String get senha => _senha;
  set senha(String value) {
    _senha = value;
  }

  int get primeiroAcesso => _primeiroAcesso;
  set primeiroAcesso(int value) {
    _primeiroAcesso = value;
  }

  String get updatedAt => _updatedAt;
  set updatedAt(String value) {
    _updatedAt = value;
  }
}
