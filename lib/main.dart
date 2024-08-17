import 'package:flutter/material.dart';
import 'package:meows_pedia/presentation/presentation.dart';
import 'package:provider/provider.dart';
import 'package:meows_pedia/data/repositories/cat_repository_impl.dart';
import 'package:meows_pedia/data/datasources/cat_remote_data_source_impl.dart';
import 'package:meows_pedia/domain/repositories/cat_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CatRepository>(
          create: (_) => CatRepositoryImpl(
            remoteDataSource: CatRemoteDataSourceImpl(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CatProvider(
            repository: context.read<CatRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Meows Pedia',
        theme: ThemeData(
          colorSchemeSeed: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const CatListPage(),
          '/detail': (context) => const DetailCatScreen(),
        },
      ),
    );
  }
}
