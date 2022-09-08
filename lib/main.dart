import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/views/caravan_view.dart';
import 'package:caravaneering/views/shop/shop_view.dart';
import 'package:caravaneering/views/skills/skill_view.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

void main() async {
  // Fixes an issue where the bindings don't initiate successfully before running app
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft]);
  // Loads the global config file
  await GlobalConfiguration().loadFromAsset("app_settings");

  runApp(
      ChangeNotifierProvider(
        create: (context) => SaveModel(),
        child: const MyApp()
      )
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
      initialRoute: '/skills',
      routes: {
        '/caravan': (context) => const CaravanView(title: 'Flutter Demo Home Page'),
        '/shop': (context) => const ShopView(),
        '/skills': (context) => const SkillsView(),
      },
    );
  }
}


