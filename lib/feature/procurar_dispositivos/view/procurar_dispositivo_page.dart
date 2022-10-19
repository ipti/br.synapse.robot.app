import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tag_ui/tag_ui.dart';
import 'package:teaching_car/core/menu_item_widget.dart';
import 'package:teaching_car/core/widget/appbar_widget.dart';
import 'package:teaching_car/feature/procurar_dispositivos/controller/cubit/procurar_dispositivo_cubit.dart';

class ProcurarDispositivoPage extends StatefulWidget {
  const ProcurarDispositivoPage({Key? key}) : super(key: key);

  @override
  State<ProcurarDispositivoPage> createState() =>
      _ProcurarDispositivoPageState();
}

class _ProcurarDispositivoPageState extends State<ProcurarDispositivoPage> {
  late ProcurarDispositivoCubit cubit;
  @override
  void initState() {
    cubit = context.read<ProcurarDispositivoCubit>();
    if (cubit.state is! ProcurarDispositivoConectado) {
      cubit.escanearPorDispositivos();
    } else if (cubit.deviceConectado()) {
      cubit.possuiDeviceConectado();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuItemWidget(),
      appBar: const AppBarWidget(
        title: Text(
          'Procurar dispositivo',
          style: TextStyle(
            color: TagColors.colorBaseProductDark,
          ),
        ),
      ),
      body: BlocBuilder<ProcurarDispositivoCubit, ProcurarDispositivoState>(
        builder: (context, state) {
          if (state is ProcurarDispositivoCarregados) {
            return ListView.builder(
              itemCount: state.dispositivos.length,
              itemBuilder: (context, index) {
                final dispositivo = state.dispositivos[index];
                  return ListTile(
                    title: Text(
                      dispositivo.device.name ?? 'Sem nome',
                    ),
                    subtitle: Text(dispositivo.device.address),
                    onTap: () {
                      cubit.conectarDispositivo(
                        device: dispositivo.device,
                      );
                    },
                  );
              },
            );
          } else if (state is ProcurarDispositivoConectado) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dispositivo conectado. Já pode começar a controlar o carrinho!',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                      onPressed: () => cubit.desconectarDispositivo(
                        device: state.device,
                      ),
                      child: const Text('Desconectar'),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProcurarDispositivoAguardandoConectar) {
            return const Center(
              child: Text('Estamos conectando ao dispositivo.'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
