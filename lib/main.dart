import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/views/caravan_view.dart';
import 'package:caravaneering/views/jump_minigame_view.dart';
import 'package:caravaneering/views/minigame_cave_intro_view.dart';
import 'package:caravaneering/views/overlays/minigame_list.dart';
import 'package:caravaneering/views/shop/shop_view.dart';
import 'package:caravaneering/views/title_screen.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

void main() async {
  // Fixes an issue where the bindings don't initiate successfully before running app
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  // Loads the global config file
  await GlobalConfiguration().loadFromAsset("app_settings");

  runApp(ChangeNotifierProvider(
      create: (context) => SaveModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionsBuilder(),
            TargetPlatform.iOS: CustomPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const TitleScreen(),
        '/caravan': (context) =>
            const CaravanView(title: 'Flutter Demo Home Page'),
        '/shop': (context) => const ShopView(),
        '/cave-intro': (context) => const CaveIntroView(),
        '/minigames': (context) => const MiniGameList(),
        '/minigames/jump': (context) => const JumpMiniGameView()
      },
    );
  }
}

// Create a custom page transition that does nothing. This removes the default
// page transition behaviour
class CustomPageTransitionsBuilder extends PageTransitionsBuilder {
  const CustomPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double>? secondaryAnimation,
      Widget child,
      ) {
    return child;
  }
}