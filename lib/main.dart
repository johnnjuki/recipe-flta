import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:recipes/mock_service/mock_service.dart';

import 'data/repository.dart';
import 'data/sqlite/sqlite_repository.dart';
import 'data/drift/drift_repository.dart';
import 'network/recipe_service.dart';
import 'network/service_interface.dart';
import 'ui/main_screen.dart';

Future<void> main() async {
  _setUpLogging();
  WidgetsFlutterBinding.ensureInitialized();
  final repository = SqliteRepository();
  await repository.init();
  runApp(MyApp(repository: repository));
}

void _setUpLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.repository}) : super(key: key);
  final Repository repository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Repository>(
          lazy: false,
          create: (context) => repository,
          dispose: (context, Repository repository) => repository.close(),
        ),
        Provider<ServiceInterface>(
          lazy: false,
          create: (context) => MockService()..create(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recipes',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
