import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 37, 38, 41),
          image: DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/564x/0a/09/df/0a09df17ffcb4b3723f8c03698eeeace.jpg'),
              opacity: 0.08,
              fit: BoxFit.fitWidth),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child:
              BlocBuilder<ProcurarDispositivoCubit, ProcurarDispositivoState>(
            builder: (context, state) {
              if (state is ProcurarDispositivoCarregados) {
                return ListView.separated(
                  itemCount: state.dispositivos.length,
                  itemBuilder: (context, index) {
                    final dispositivo = state.dispositivos[index];

                    return ListTile(
                      title: Text(
                        dispositivo.device.name ?? 'Sem nome',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      subtitle: Text(
                        dispositivo.device.address,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        cubit.conectarDispositivo(
                          device: dispositivo.device,
                        );
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: Colors.white,
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
                  child: Text(
                    'Estamos conectando ao dispositivo.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
