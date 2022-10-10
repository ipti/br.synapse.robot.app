import 'package:teaching_car/core/bluetooth_connection/ibluetooth_connection.dart';

class AcaoCarrinhoDirecionadoService {
  final IBluetoothConnection _iBluetoothConnection;

  AcaoCarrinhoDirecionadoService(this._iBluetoothConnection);

  void enviarComandoDirecionado({
    required String comando,
  }) {
    _iBluetoothConnection.enviarComandoCedula(
      comando: comando,
    );
  }
}