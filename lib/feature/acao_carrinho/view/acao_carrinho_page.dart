import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_car/core/menu_item_widget.dart';
import 'package:teaching_car/core/widget/appbar_widget.dart';
import 'package:teaching_car/core/widget/joystick.dart';
import 'package:teaching_car/feature/acao_carrinho/controller/cubit/acao_carrinho_cubit.dart';

class AcaoCarrinhoPage extends StatefulWidget {
  const AcaoCarrinhoPage({Key? key}) : super(key: key);

  @override
  State<AcaoCarrinhoPage> createState() => _AcaoCarrinhoPageState();
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFF383A3F)
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    var path = Path();
    final segmentWidth = size.width / 3 / 2;
    path.moveTo(0, 0);
    path.cubicTo(segmentWidth, 0, 2 * segmentWidth, size.height / 2,
        3 * segmentWidth, size.height / 2);
    path.cubicTo(4 * segmentWidth, size.height / 2, 5 * segmentWidth, 0,
        6 * segmentWidth, 0);

    canvas.drawPath(path, paint);
    canvas.drawPath(
      path,
      paint
        ..style = PaintingStyle.stroke
        ..color = const Color(0xFF41434B),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
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
        return Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 38, 41),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/0a/09/df/0a09df17ffcb4b3723f8c03698eeeace.jpg'),
                  opacity: 0.08,
                  fit: BoxFit.fitWidth),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Comandos(
                    scrollController: _scrollController, icones: state.icones),
                CustomJoystick(cubit: cubit),
                EnviarComandos(icones: state.icones),
              ],
            ));
      }),
    );
  }
}

class Comandos extends StatelessWidget {
  const Comandos({
    Key? key,
    required ScrollController scrollController,
    required this.icones,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<IconData> icones;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AcaoCarrinhoCubit>();
    return SizedBox(
      height: 240,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20, bottom: 0),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 56, 58, 63),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 2.0,
                    color: const Color(0xFF41434B),
                  )),
              width: 370,
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: icones.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            cubit.removerComandos(
                                listaComandos: icones,
                                index: icones.length - 1);
                          },
                          child: Center(
                            child: Container(
                              width: 75,
                              height: 70,
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(86, 5, 160, 100),
                                      Color.fromRGBO(161, 39, 216, 100),
                                    ]),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                icones[icones.length - index - 1],
                                color: const Color(0xFFFFFFFF),
                                size: 64,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              // ),
            ),
          ),
          Positioned(
            top: 218,
            width: 80,
            height: 35,
            child: CustomPaint(
              painter: ShapePainter(),
            ),
            // ),
          ),
        ],
      ),
    );
  }
}

class CustomJoystick extends StatelessWidget {
  const CustomJoystick({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AcaoCarrinhoCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Joystick(
                sizeIcon: 50,
                size: 150,
                isDraggable: false,
                iconColor: const Color(0xFFFFFFFF),
                backgroundColor: const Color(0xDA0A1745),
                //aqui
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
        ],
      ),
    );
  }
}

class EnviarComandos extends StatelessWidget {
  const EnviarComandos({
    Key? key,
    required this.icones,
  }) : super(key: key);
  final List<IconData> icones;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AcaoCarrinhoCubit>();
    return Container(
      alignment: Alignment.topCenter,
      height: 100,
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () => cubit.enviarComands(
                    listaComandos: icones,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 91, 7, 164),
                    ),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Enviar Comandos'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
