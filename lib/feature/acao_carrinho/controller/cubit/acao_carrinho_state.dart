part of 'acao_carrinho_cubit.dart';

abstract class AcaoCarrinhoState extends Equatable {
  const AcaoCarrinhoState({
    required this.icones,
  });
  final List<IconData> icones;
  @override
  List<Object> get props => [
        icones,
      ];
}

class AcaoCarrinhoInitial extends AcaoCarrinhoState {
  const AcaoCarrinhoInitial({required super.icones});
}
class AcaoCarrinhoAcaoAdicionada extends AcaoCarrinhoState {
  const AcaoCarrinhoAcaoAdicionada({required super.icones});
}
