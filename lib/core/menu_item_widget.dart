import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tag_ui/tag_ui.dart';
import 'package:teaching_car/core/icon_path.dart';
import 'package:teaching_car/core/injecao_dependencia.dart';
import 'package:teaching_car/feature/acao_carrinho/controller/cubit/acao_carrinho_cubit.dart';
import 'package:teaching_car/feature/acao_carrinho/view/acao_carrinho_page.dart';
import 'package:teaching_car/feature/acao_carrinho_direcionado/controller/cubit/acao_carrinho_direcionado_cubit.dart';
import 'package:teaching_car/feature/acao_carrinho_direcionado/view/acao_carrinho_direcionado_page.dart';
import 'package:teaching_car/feature/procurar_dispositivos/controller/cubit/procurar_dispositivo_cubit.dart';
import 'package:teaching_car/feature/procurar_dispositivos/view/procurar_dispositivo_page.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TagMenu(
      items: [
        TagMenuItem(
          route: 'Início',
          title: 'Início',
          icon: TagIcon(
            defaultVersionPath: FilePaths.logoSVG,
            disabledVersionPath: FilePaths.logoSVG,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<AcaoCarrinhoCubit>(
                create: (context) => injector<AcaoCarrinhoCubit>(),
                child: const AcaoCarrinhoPage(),
              ),
            ),
          ),
        ),
        TagMenuItem(
          route: 'procurar-dispositvo',
          title: 'Procurar Dispositivo',
          icon: TagIcon(
            defaultVersionPath: FilePaths.bluetoothSVG,
            disabledVersionPath: FilePaths.bluetoothSVG,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<ProcurarDispositivoCubit>(
                  create: (context) => injector<ProcurarDispositivoCubit>(),
                  child: const ProcurarDispositivoPage(),
                ),
              ),
            );
          },
        ),
        TagMenuItem(
          route: 'acao-direcionada',
          title: 'Ação Direcionada',
          icon: TagIcon(
            defaultVersionPath: FilePaths.logoSVG,
            disabledVersionPath: FilePaths.logoSVG,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider<AcaoCarrinhoDirecionadoCubit>(
                create: (context) => injector<AcaoCarrinhoDirecionadoCubit>(),
                child: const AcaoCarrinhoDirecionadoPage(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
