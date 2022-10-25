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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              cubit.adicionarComandos(
                icone: Icons.arrow_back,
              );
              break;
            case 1:
              cubit.adicionarComandos(
                icone: Icons.arrow_downward,
              );
              break;
            case 2:
              cubit.adicionarComandos(
                icone: Icons.arrow_upward,
              );
              break;
            case 3:
              cubit.adicionarComandos(
                icone: Icons.arrow_forward,
              );
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedItemColor: TagColors.colorBaseProductDark,
        unselectedItemColor: TagColors.colorBaseProductDark,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_back,
              color: TagColors.colorBaseProductDark,
            ),
            label: 'Esquerda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_downward,
              color: TagColors.colorBaseProductDark,
            ),
            label: 'Baixo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_upward,
              color: TagColors.colorBaseProductDark,
            ),
            label: 'Cima',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.arrow_forward,
              color: TagColors.colorBaseProductDark,
            ),
            label: 'Direita',
          ),
        ],
      ),
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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.icones.length,
                  itemBuilder: (context, index) {
                    return Icon(
                      state.icones[state.icones.length - index - 1],
                    );
                  },
                ),
              ),
              Joystick(
                sizeIcon: 50,
                size: 150,
                isDraggable: true,
                iconColor: const Color(0x9CFFFFFF),
                backgroundColor: const Color(0xA10A1745),
                opacity: 0.7,
                joystickMode: JoystickModes.all,
                onUpPressed: () {
                  cubit.adicionarComandos(
                    icone: Icons.arrow_forward,
                  );
                },
                onLeftPressed: () {
                  cubit.adicionarComandos(
                    icone: Icons.arrow_back,
                  );
                },
                onRightPressed: () {
                  cubit.adicionarComandos(
                    icone: Icons.arrow_upward,
                  );
                },
                onDownPressed: () {
                  cubit.adicionarComandos(
                    icone: Icons.arrow_downward,
                  );
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
