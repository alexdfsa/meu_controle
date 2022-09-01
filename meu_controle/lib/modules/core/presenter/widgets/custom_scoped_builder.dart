import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:meu_controle/modules/app/utils/failure.dart';

class CustomScopedBuilder<TStore extends Store<TError, TState>,
    TError extends Object, TState extends Object> extends ScopedBuilder {
  const CustomScopedBuilder(this.store, {Key? key}) : super(key: key);

  @override
  final TStore store;
/*
  build() {
    return ScopedBuilder<store, Failure, state>.transition(
      store: store,
      transition: (_, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: child,
        );
      },
      onError: (context, error) {
        debugPrint('entrou _scopedBuilder - onError');
        debugPrint(error!.errorMessage);
        return Text(error.toString());
      },
      onLoading: (context) {
        debugPrint('entrou _scopedBuilder - onLoading');
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
*/
}
