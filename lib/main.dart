import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_car/core/injecao_dependencia.dart';
import 'package:teaching_car/feature/acao_carrinho/controller/cubit/acao_carrinho_cubit.dart';
import 'package:teaching_car/feature/acao_carrinho/view/acao_carrinho_page.dart';

void main() {
  runZonedGuarded(
    () async {
      await init();
      runApp(
        const MyApp(),
      );
    },
    (Object error, StackTrace stackTrace) {
      debugPrint(
        error.toString(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AcaoCarrinhoCubit>(
        create: (_) => injector<AcaoCarrinhoCubit>(),
        child: const AcaoCarrinhoPage(),
      ),
    );
  }
}
