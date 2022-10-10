import 'package:get_it/get_it.dart';
import 'package:teaching_car/core/bluetooth_connection/bluetooth_connection.dart';
import 'package:teaching_car/core/bluetooth_connection/ibluetooth_connection.dart';
import 'package:teaching_car/feature/acao_carrinho/controller/cubit/acao_carrinho_cubit.dart';
import 'package:teaching_car/feature/acao_carrinho/model/acao_carrinho_service.dart';
import 'package:teaching_car/feature/acao_carrinho_direcionado/controller/cubit/acao_carrinho_direcionado_cubit.dart';
import 'package:teaching_car/feature/acao_carrinho_direcionado/model/service/acao_carrinho_direcionado_service.dart';
import 'package:teaching_car/feature/procurar_dispositivos/controller/cubit/procurar_dispositivo_cubit.dart';

final injector = GetIt.instance;
Future<void> init() async {
  injector.registerLazySingleton<IBluetoothConnection>(
    () => BlueToothConnection(),
  );
  injector.registerFactory(
    () => AcaoCarrinhoService(
      injector(),
    ),
  );
  injector.registerFactory(
    () => AcaoCarrinhoDirecionadoService(
      injector(),
    ),
  );
  injector.registerLazySingleton(
    () => ProcurarDispositivoCubit(
      bluetoothConnection: injector(),
    ),
  );
  injector.registerLazySingleton(
    () => AcaoCarrinhoCubit(
      acaoCarrinhoService: injector(),
    ),
  );
  injector.registerLazySingleton(
    () => AcaoCarrinhoDirecionadoCubit(
      injector(),
    ),
  );
}
