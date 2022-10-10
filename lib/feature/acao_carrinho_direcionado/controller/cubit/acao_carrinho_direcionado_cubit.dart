import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_car/feature/acao_carrinho_direcionado/model/service/acao_carrinho_direcionado_service.dart';

part 'acao_carrinho_direcionado_state.dart';

class AcaoCarrinhoDirecionadoCubit extends Cubit<AcaoCarrinhoDirecionadoState> {
  AcaoCarrinhoDirecionadoCubit(
      AcaoCarrinhoDirecionadoService acaoCarrinhoService)
      : _acaoCarrinhoService = acaoCarrinhoService,
        super(
          const AcaoCarrinhoDirecionadoInitial(
            linha: 'a',
            coluna: '1',
          ),
        );

  final AcaoCarrinhoDirecionadoService _acaoCarrinhoService;

  void enviarComandosDirecionados({
    required String linha,
    required String coluna,
  }) {
    _acaoCarrinhoService.enviarComandoDirecionado(comando: '$coluna $linha');
  }

  void alterarLinha({required String linha}) {
    emit(
      AcaoCarrinhoDirecionalMudancaState(
        coluna: state.coluna,
        linha: linha,
      ),
    );
  }

  int converterLetraEmInteiro({
    required String linha,
  }) {
    switch (linha) {
      case 'a':
        return 1;
      case 'b':
        return 2;
      case 'c':
        return 3;
      case 'd':
        return 4;
      case 'e':
        return 5;
      case 'f':
        return 6;
      default:
        return 7;
    }
  }

  void alterarColuna({required String coluna}) {
    emit(
      AcaoCarrinhoDirecionalMudancaState(
        coluna: coluna,
        linha: state.linha,
      ),
    );
  }
}
