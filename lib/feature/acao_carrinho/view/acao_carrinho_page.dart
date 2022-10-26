import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tag_ui/tag_ui.dart';
import 'package:teaching_car/core/menu_item_widget.dart';
import 'package:teaching_car/core/widget/appbar_widget.dart';
import 'package:teaching_car/core/widget/joystick.dart';
import 'package:teaching_car/feature/acao_carrinho/controller/cubit/acao_carrinho_cubit.dart';

class AcaoCarrinhoPage extends StatefulWidget {
  const AcaoCarrinhoPage({Key? key}) : super(key: key);

  @override
  State<AcaoCarrinhoPage> createState() => _AcaoCarrinhoPageState();
}

class _AcaoCarrinhoPageState extends State<AcaoCarrinhoPage> {
  late AcaoCarrinhoCubit cubit;
  @override
  void initState() {
    cubit = context.read<AcaoCarrinhoCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuItemWidget(),
      appBar: const AppBarWidget(
        title: Text(
          'Início',
          style: TextStyle(
            color: TagColors.colorBaseProductDark,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: BlocConsumer<AcaoCarrinhoCubit, AcaoCarrinhoState>(
            listener: (context, state) {
          if (state is AcaoCarrinhoVazio) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Lista vazia"),
              duration: Duration(seconds: 2),
            ));
          }
          if (state is AcaoCarrinhobloqueada) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Não foi possível conectar com esse dispositivo"),
              duration: Duration(seconds: 2),
            ));
          }
        }, builder: (context, state) {
          return Center(
              child: Column(
            children: [
              Column(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 370,
                    height: 300,
                    alignment: Alignment.center,
                    child: Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.icones.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              cubit.removerComandos(
                                  listaComandos: state.icones, index: index);
                            },
                            child: Container(
                              width: 75,
                              height: 70,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xBD2918F1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                state.icones[state.icones.length - index - 1],
                                color: const Color(0x9CE2E1EF),
                                size: 64,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Joystick(
                  sizeIcon: 50,
                  size: 150,
                  isDraggable: true,
                  iconColor: const Color(0x9CFFFFFF),
                  backgroundColor: const Color(0xA10A1745),
                  opacity: 0.7,
                  joystickMode: JoystickModes.all,
                  onUpPressed: () {
                    cubit.adicionarComandos(
                        icone: Icons.keyboard_arrow_up_rounded);
                  },
                  onLeftPressed: () {
                    cubit.adicionarComandos(
                      icone: Icons.keyboard_arrow_left_rounded,
                    );
                  },
                  onRightPressed: () {
                    cubit.adicionarComandos(
                        icone: Icons.keyboard_arrow_right_rounded);
                  },
                  onDownPressed: () {
                    cubit.adicionarComandos(
                      icone: Icons.keyboard_arrow_down_rounded,
                    );
                  },
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => cubit.enviarComands(
                        listaComandos: state.icones,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                      ),
                      child: const Text('Enviar Comandos'),
                    ),
                  ],
                ),
              ),
            ],
          ));
        }),
      ),
    );
  }
}
