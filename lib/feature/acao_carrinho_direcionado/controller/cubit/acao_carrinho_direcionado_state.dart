part of 'acao_carrinho_direcionado_cubit.dart';

abstract class AcaoCarrinhoDirecionadoState extends Equatable {
  const AcaoCarrinhoDirecionadoState({
    required this.coluna,
    required this.linha,
  });
  final String linha;
  final String coluna;
  @override
  List<Object> get props => [
        linha,
        coluna,
      ];
}

class AcaoCarrinhoDirecionadoInitial extends AcaoCarrinhoDirecionadoState {
  const AcaoCarrinhoDirecionadoInitial({
    required super.coluna,
    required super.linha,
  });
}

class AcaoCarrinhoDirecionalMudancaState extends AcaoCarrinhoDirecionadoState {
  const AcaoCarrinhoDirecionalMudancaState({
    required super.coluna,
    required super.linha,
  });
}
