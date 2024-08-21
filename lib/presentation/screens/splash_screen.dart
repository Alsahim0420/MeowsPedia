import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meows_pedia/presentation/providers/cat_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final catProvider = Provider.of<CatProvider>(context, listen: false);
      catProvider.fetchCats();
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/image_logo.png'),
            const Text(
              'Welcome to MeowsPedia',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
