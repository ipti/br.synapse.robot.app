part of 'acao_carrinho_cubit.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class AcaoCarrinhoState extends Equatable {
  const AcaoCarrinhoState({
    required this.icones,
  });
  final List<IconData> icones;
  @override
  List<Object> get props => [icones];

  @override
  bool get stringify => true;
}

class AcaoCarrinhoInitial extends AcaoCarrinhoState {
  const AcaoCarrinhoInitial({required super.icones});
}

class AcaoCarrinhoAcaoAdicionada extends AcaoCarrinhoState {
  const AcaoCarrinhoAcaoAdicionada({required super.icones});
}

class AcaoCarrinhobloqueada extends AcaoCarrinhoState {
  const AcaoCarrinhobloqueada({super.icones = const []});
}

class AcaoCarrinhoApagarUltimo extends AcaoCarrinhoState {
  const AcaoCarrinhoApagarUltimo({required super.icones});
  @override
  List<Object> get props => [icones];

  @override
  bool get stringify => true;
}

class AcaoCarrinhoApagar extends AcaoCarrinhoState {
  const AcaoCarrinhoApagar({required super.icones});
  @override
  List<Object> get props => [icones];

  @override
  bool get stringify => true;
}

class AcaoCarrinhoVazio extends AcaoCarrinhoState {
  const AcaoCarrinhoVazio({super.icones = const []});
  @override
  List<Object> get props => [icones];

  @override
  bool get stringify => true;
}
