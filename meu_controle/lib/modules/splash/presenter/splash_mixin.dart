import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meu_controle/firebase_options.dart';

mixin SplashMixin<T extends StatefulWidget> on State<T> {
  ///Minimum show duration from splash screen
  Duration get minDuration;

  ///Callback called after minimun duration and all futures loaded
  void onFinishLoading(List responses);
  //List<Future> get futures;

  var futures = <Future>[
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.wait(futures + [Future.delayed(minDuration)])
          .then((list) => onFinishLoading(list.sublist(0, list.length - 1)))
          .catchError((ex) => debugPrint('[Splash Futures] $ex'));
    });
  }
}
