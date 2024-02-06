class ControleTV {
  late String power;
  late String vol_mais;
  late String vol_menos;
  late String ch_mais;
  late String ch_menos;
  late String seta_cima;
  late String seta_baixo;
  late String seta_esquerda;
  late String seta_direita;
  late String seta_btnOK;
  late String mute;
  late String home;
  late String settings;
  late String conections;
  late String back;
  late String exit;

  final String marca;

  ControleTV({required this.marca}) {
    // Configura os códigos de controle com base na marca
    if (marca.toLowerCase() == 'samsung') {
      power = "E0E040BF";
      vol_mais = "E0E0E01F";
      vol_menos = "E0E0D02F";
      ch_mais = "E0E048B7";
      ch_menos = "E0E008F7";
      seta_cima = "E0E006F9";
      seta_baixo = "E0E08679";
      seta_esquerda = "E0E0A659";
      seta_direita = "E0E046B9";
      seta_btnOK = "E0E016E9";
      mute = "E0E0F00F";
      home = "E0E09E61";
      settings = "E0E058A7";
      conections = "E0E0807F";
      back = "E0E01AE5";
      exit = "E0E0B44B";
    } else if (marca.toLowerCase() == 'lg') {
      power = "20DF10EF";
      vol_mais = "20DF40BF";
      vol_menos = "20DFC03F";
      ch_mais = "20DF00FF";
      ch_menos = "20DF807F";
      seta_cima = "20DF02FD";
      seta_baixo = "20DF827D";
      seta_esquerda = "20DFE01F";
      seta_direita = "20DF609F";
      seta_btnOK = "20DF22DD";
      mute = "20DF906F";
      home = "20DF3EC1";
      settings = "20DFC23D";
      conections = "20DFD02F";
      back = "";
      exit = "";
    } else if (marca.toLowerCase() == 'tv box') {
      // Define códigos padrão caso a marca não seja reconhecida
      power = "807F02FD";
      vol_mais = "807F18E7";
      vol_menos = "807F08F7";
      ch_mais = "";
      ch_menos = "";
      seta_cima = "807F6897";
      seta_baixo = "807F58A7";
      seta_esquerda = "807F8A75";
      seta_direita = "807F0AF5";
      seta_btnOK = "807FC837";
      mute = "807F827D";
      home = "807F8877";
      settings = "807FC23D";
      conections = "807F32CD";
      back = "807F42BD";
      exit = "807F9867";
    }
  }
}
