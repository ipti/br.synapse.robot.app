import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tag_ui/tag_ui.dart';
import 'package:teaching_car/core/menu_item_widget.dart';
import 'package:teaching_car/core/widget/appbar_widget.dart';
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
        child: BlocBuilder<AcaoCarrinhoCubit, AcaoCarrinhoState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: cubit.limparComandos,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.yellow,
                        ),
                      ),
                      child: const Text('Limpar Comandos'),
                    ),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
