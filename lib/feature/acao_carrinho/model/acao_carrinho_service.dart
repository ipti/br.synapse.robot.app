import 'package:teaching_car/core/bluetooth_connection/ibluetooth_connection.dart';

class AcaoCarrinhoService {
  final IBluetoothConnection _iBluetoothConnection;

  AcaoCarrinhoService(this._iBluetoothConnection);

  Future<void> enviarComandos({
    required List<String> listaComandos,
  }) async {
    await _iBluetoothConnection.enviarComandosLista(
      listaComandos: listaComandos,
    );
  }
}
