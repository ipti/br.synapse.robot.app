import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

abstract class IBluetoothConnection {
  Stream<BluetoothDiscoveryResult> escanearPorDispositivos();
  Future<void> enviarComandosLista({
    required List<String> listaComandos,
  });
  Future<void> desconectarDispositivo({required BluetoothDevice device});
  Future<bool?> conectarDispositivo({required BluetoothDevice device});
  void enviarComandoCedula({required String comando});
  bool deviceConectado();
  BluetoothDevice device();
}
