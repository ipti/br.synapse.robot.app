import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_car/feature/acao_carrinho/model/acao_carrinho_service.dart';

part 'acao_carrinho_state.dart';

class AcaoCarrinhoCubit extends Cubit<AcaoCarrinhoState> {
  AcaoCarrinhoCubit({required AcaoCarrinhoService acaoCarrinhoService})
      : _acaoCarrinhoService = acaoCarrinhoService,
        super(
          const AcaoCarrinhoInitial(
            icones: [],
          ),
        );

  final AcaoCarrinhoService _acaoCarrinhoService;

  void adicionarComandos({
    required IconData icone,
  }) {
    List<IconData> novaLista = [];
    novaLista.add(icone);
    novaLista.addAll(state.icones);
    emit(
      AcaoCarrinhoAcaoAdicionada(
        icones: novaLista,
      ),
    );
  }

  void enviarComands({required List<IconData> listaComandos}) {
    List<String> listaComandosString = [];
    for (IconData icons in listaComandos) {
      if (icons == Icons.arrow_back) {
        listaComandosString.add("e");
      } else if (icons == Icons.arrow_forward) {
        listaComandosString.add('d');
      } else if (icons == Icons.arrow_upward) {
        listaComandosString.add('f');
      } else {
        listaComandosString.add('r');
      }
    }
    _acaoCarrinhoService.enviarComandos(
      listaComandos: listaComandosString.reversed.toList(),
    );
  }

  void limparComandos() {
    emit(
      const AcaoCarrinhoInitial(
        icones: [],
      ),
    );
  }
}
