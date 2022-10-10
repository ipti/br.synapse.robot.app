import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tag_ui/tag_ui.dart';
import 'package:teaching_car/core/menu_item_widget.dart';
import 'package:teaching_car/core/widget/appbar_widget.dart';
import 'package:teaching_car/feature/acao_carrinho_direcionado/controller/cubit/acao_carrinho_direcionado_cubit.dart';

class AcaoCarrinhoDirecionadoPage extends StatefulWidget {
  const AcaoCarrinhoDirecionadoPage({Key? key}) : super(key: key);

  @override
  State<AcaoCarrinhoDirecionadoPage> createState() =>
      _AcaoCarrinhoDirecionadoPageState();
}

class _AcaoCarrinhoDirecionadoPageState
    extends State<AcaoCarrinhoDirecionadoPage> {
  late AcaoCarrinhoDirecionadoCubit cubit;

  @override
  void initState() {
    cubit = context.read<AcaoCarrinhoDirecionadoCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuItemWidget(),
      appBar: const AppBarWidget(
        title: Text(
          'Ação Direcionada',
          style: TextStyle(
            color: TagColors.colorBaseProductDark,
          ),
        ),
      ),
      body: BlocBuilder<AcaoCarrinhoDirecionadoCubit,
          AcaoCarrinhoDirecionadoState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              24,
              24,
              0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Linha:'),
                    DropdownButton<String>(
                      onChanged: (value) => cubit.alterarLinha(
                        linha: value ?? state.linha,
                      ),
                      value: state.linha,
                      items: <String>[
                        'a',
                        'b',
                        'c',
                        'd',
                        'e',
                        'f',
                        'g',
                      ]
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const Text('Coluna:'),
                    DropdownButton<String>(
                      onChanged: (value) => cubit.alterarColuna(
                        coluna: value ?? state.coluna,
                      ),
                      value: state.coluna,
                      items: <String>[
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                      ]
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: TagButton(
                    text: 'Enviar Comandos',
                    onPressed: () => cubit.enviarComandosDirecionados(
                      linha: state.linha,
                      coluna: state.coluna,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, indexColuna) => Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: state.coluna == '1' &&
                                        (indexColuna + 1) ==
                                            cubit.converterLetraEmInteiro(
                                              linha: state.linha,
                                            )
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, indexColuna) => Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: state.coluna == '2' &&
                                        (indexColuna + 1) ==
                                            cubit.converterLetraEmInteiro(
                                              linha: state.linha,
                                            )
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, indexColuna) => Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: state.coluna == '3' &&
                                        (indexColuna + 1) ==
                                            cubit.converterLetraEmInteiro(
                                              linha: state.linha,
                                            )
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, indexColuna) => Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: state.coluna == '4' &&
                                        (indexColuna + 1) ==
                                            cubit.converterLetraEmInteiro(
                                              linha: state.linha,
                                            )
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, indexColuna) => Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: state.coluna == '5' &&
                                        (indexColuna + 1) ==
                                            cubit.converterLetraEmInteiro(
                                              linha: state.linha,
                                            )
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, indexColuna) => Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: state.coluna == '6' &&
                                        (indexColuna + 1) ==
                                            cubit.converterLetraEmInteiro(
                                              linha: state.linha,
                                            )
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7,
                        itemBuilder: (context, indexColuna) => Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: state.coluna == '7' &&
                                        (indexColuna + 1) ==
                                            cubit.converterLetraEmInteiro(
                                              linha: state.linha,
                                            )
                                    ? Colors.green
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
