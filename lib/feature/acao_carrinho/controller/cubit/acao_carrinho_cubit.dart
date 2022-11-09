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

  void removerComandos(
      {required List<IconData> listaComandos, required int index}) {
    if (listaComandos.isNotEmpty) {
      listaComandos.removeAt(index - 1);
      emit(AcaoCarrinhoApagarUltimo(icones: listaComandos));
      emit(AcaoCarrinhoInitial(icones: listaComandos));
    }
    if (listaComandos.isEmpty) {
      emit(const AcaoCarrinhoVazio());
      emit(const AcaoCarrinhoInitial(icones: []));
    } else {}
  }

  void enviarComands({required List<IconData> listaComandos}) async {
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

    _acaoCarrinhoService
        .enviarComandos(
          listaComandos: listaComandosString.reversed.toList(),
        )
        .catchError((error) => emit(const AcaoCarrinhobloqueada()));
  }

  void limparTodosComandos() {
    emit(
      const AcaoCarrinhoVazio(
        icones: [],
      ),
    );
  }

  void limparComando({required List<IconData> listaComandos}) {
    if (listaComandos.isNotEmpty) {
      listaComandos.removeLast();
      emit(AcaoCarrinhoApagarUltimo(icones: listaComandos));
      emit(AcaoCarrinhoInitial(icones: listaComandos));
    }
    if (listaComandos.isEmpty) {
      emit(const AcaoCarrinhoVazio());
      emit(const AcaoCarrinhoInitial(icones: []));
    } else {}
  }
}
