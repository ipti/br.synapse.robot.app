import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'package:teaching_car/core/bluetooth_connection/ibluetooth_connection.dart';

class BlueToothConnection implements IBluetoothConnection {
  FlutterBluetoothSerial flutterBluetoothSerial =
      FlutterBluetoothSerial.instance;
  late BluetoothDevice savedDevice;
  @override
  Stream<BluetoothDiscoveryResult> escanearPorDispositivos() {
    return flutterBluetoothSerial.startDiscovery();
  }

  @override
  void enviarComandosLista({
    required List<String> listaComandos,
  }) async {
    try {
      final dataFormatada = 's ${listaComandos.join(' ')}';
      final connection = await BluetoothConnection.toAddress(
        savedDevice.address,
      );
      connection.output.add(
        ascii.encode(dataFormatada),
      );
      await connection.output.allSent;
      connection.close();
    } catch (exception) {
      log("Não foi possivel enviar comandos para esse dispositivo");
      //buscar a partir daqui colocar um BlocConsumer
    }
  }

  @override
  Future<void> desconectarDispositivo({required BluetoothDevice device}) async {
    await flutterBluetoothSerial.removeDeviceBondWithAddress(device.address);
  }

  @override
  Future<bool?> conectarDispositivo({required BluetoothDevice device}) async {
    savedDevice = device;
    return await flutterBluetoothSerial.bondDeviceAtAddress(device.address);
  }

  @override
  void enviarComandoCedula({required String comando}) async {
    final dataFormatada = 'c $comando';
    debugPrint(dataFormatada);
    final connection = await BluetoothConnection.toAddress(
      savedDevice.address,
    );

    connection.output.add(
      ascii.encode(
        dataFormatada,
      ),
    );
  }

  @override
  bool deviceConectado() {
    return savedDevice.isConnected;
  }

  @override
  BluetoothDevice device() {
    return savedDevice;
  }
}
