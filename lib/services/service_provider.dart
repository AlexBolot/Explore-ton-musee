import 'package:explore_ton_musee/services/nfc_game_service.dart';
import 'package:explore_ton_musee/services/path_service.dart';
import 'package:explore_ton_musee/services/qr_game_service.dart';

class ServiceProvider {
  static QRGameService qrGameService = QRGameService();

  static NFCGameService nfcGameService = NFCGameService();

  static PathService pathService = PathService();

  static init({QRGameService qrService, NFCGameService nfcService, PathService pathService}) {
    if (qrService != null) ServiceProvider.qrGameService = qrService;
    if (nfcService != null) ServiceProvider.nfcGameService = nfcService;
    if (pathService != null) ServiceProvider.pathService = pathService;
  }
}
