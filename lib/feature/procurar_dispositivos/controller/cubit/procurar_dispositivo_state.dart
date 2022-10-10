part of 'procurar_dispositivo_cubit.dart';

@immutable
abstract class ProcurarDispositivoState {}

class ProcurarDispositivoInitial extends ProcurarDispositivoState {}

class ProcurarDispositivoLoading extends ProcurarDispositivoState {}

class ProcurarDispositivoCarregados extends ProcurarDispositivoState {
  final List<BluetoothDiscoveryResult> dispositivos;
  final bool isChanged;
  ProcurarDispositivoCarregados(
    this.dispositivos,
    this.isChanged,
  );
}

class ProcurarDispositivoAguardandoConectar extends ProcurarDispositivoState {}

class ProcurarDispositivoConectarErro extends ProcurarDispositivoState {}

class ProcurarDispositivoConectado extends ProcurarDispositivoState {
  final BluetoothDevice device;

  ProcurarDispositivoConectado({required this.device});
}
