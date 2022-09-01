import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meu_controle/modules/core/presenter/widgets/blend_mask.dart';
import 'splash_mixin.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = 'SplashPage'}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> with SplashMixin {
  @override
  final minDuration = const Duration(seconds: 5);

  @override
  void onFinishLoading(List responses) {
    Modular.to.navigate('/core/home');
  }

  @override
  List<Future> get futures => <Future>[];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF99F00), Color(0xFFDB3069)],
                stops: [0, 0.778],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 45),
                  child: const BlendMask(
                    opacity: 1.0,
                    blendMode: BlendMode.overlay,
                    child: SizedBox(
                      //child: Image.asset('assets/splash/logo.png'),
                      child: Text('Ondeficará o logo'),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
