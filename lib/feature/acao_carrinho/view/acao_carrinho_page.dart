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
  final ScrollController _scrollController = ScrollController();
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
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: BlocConsumer<AcaoCarrinhoCubit, AcaoCarrinhoState>(
          listener: (context, state) {
        if (state is AcaoCarrinhoAcaoAdicionada) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent + 80,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
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
            child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/0a/09/df/0a09df17ffcb4b3723f8c03698eeeace.jpg'),
                      fit: BoxFit.fitWidth),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        IntrinsicHeight(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF9CE6FF),
                                      Color(0xC3AC6AFF)
                                    ])),
                            width: 370,
                            height: 300,
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: state.icones.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onLongPress: () {
                                        cubit.removerComandos(
                                            listaComandos: state.icones,
                                            index: state.icones.length - 1);
                                      },
                                      child: Center(
                                        child: Container(
                                          width: 75,
                                          height: 70,
                                          alignment: Alignment.topCenter,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xBD2918F1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Icon(
                                            state.icones[state.icones.length -
                                                index -
                                                1],
                                            color: const Color(0xFFFFFFFF),
                                            size: 64,
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      //color: Colors.white,
                      child: Expanded(
                        child: Center(
                          child: Joystick(
                            sizeIcon: 50,
                            size: 150,
                            isDraggable: false,
                            iconColor: const Color(0xFFFFFFFF),
                            backgroundColor: const Color(0xDA0A1745),
                            opacity: 0.95,
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
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      //color: Colors.amber,
                      height: 40,
                      margin: const EdgeInsets.all(16),
                      // color: Colors.white,
                      child: Expanded(
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
                                minimumSize: MaterialStateProperty.all(
                                    const Size(200, 50)),
                                shadowColor: MaterialStateProperty.all(
                                    const Color(0xFF757575)),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF3C40B8),
                                ),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontSize: 20),
                                ),
                                overlayColor: MaterialStateProperty.all(
                                    const Color(0xFF1E216B)),
                                elevation: MaterialStateProperty.all(5),
                              ),
                              child: const Text('Enviar Comandos'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
      }),
    );
  }
}
