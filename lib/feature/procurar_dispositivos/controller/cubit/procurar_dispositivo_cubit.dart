import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:teaching_car/core/bluetooth_connection/ibluetooth_connection.dart';

part 'procurar_dispositivo_state.dart';

class ProcurarDispositivoCubit extends Cubit<ProcurarDispositivoState> {
  ProcurarDispositivoCubit({
    required IBluetoothConnection bluetoothConnection,
  })  : _iBluetoothConnection = bluetoothConnection,
        super(ProcurarDispositivoInitial());

  final IBluetoothConnection _iBluetoothConnection;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);

  bool isChanged = false;
  void escanearPorDispositivos() {
    emit(ProcurarDispositivoLoading());
    final result = _iBluetoothConnection.escanearPorDispositivos();
    result.listen((r) {
      final existingIndex = results
          .indexWhere((element) => element.device.address == r.device.address);
      if (existingIndex >= 0) {
        results[existingIndex] = r;
        emit(
          ProcurarDispositivoCarregados(results, !isChanged),
        );
      } else {
        results.add(r);
        emit(
          ProcurarDispositivoCarregados(
            results,
            !isChanged,
          ),
        );
      }
    });
  }

  bool deviceConectado() {
    return _iBluetoothConnection.deviceConectado();
  }

  void possuiDeviceConectado() {
    emit(
      ProcurarDispositivoConectado(
        device: _iBluetoothConnection.device(),
      ),
    );
  }

  void desconectarDispositivo({required BluetoothDevice device}) async {
    emit(
      ProcurarDispositivoLoading(),
    );
    await _iBluetoothConnection.desconectarDispositivo(
      device: device,
    );
    escanearPorDispositivos();
  }

  void conectarDispositivo({
    required BluetoothDevice device,
  }) async {
    emit(
      ProcurarDispositivoAguardandoConectar(),
    );
    try {
      final result = await _iBluetoothConnection.conectarDispositivo(
        device: device,
      );
      if (result != null && result) {
        emit(
          ProcurarDispositivoConectado(
            device: device,
          ),
        );
      } else {
        escanearPorDispositivos();
      }
    } catch (e) {
      e as PlatformException;
      if (e.message == 'device already bonded') {
        emit(ProcurarDispositivoConectado(device: device));
      } else {
        escanearPorDispositivos();
      }
    }
  }
}
