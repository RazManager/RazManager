import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'settings_model.dart';
import 'app_model.dart';
import 'app_drawer.dart';
import 'refresh_model.dart';
import 'utilities/intent.dart';
import 'public/event/public_event.model.dart';
import 'public/race/public_race.model.dart';
import 'public/heat/public_heat.model.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsModel(),
      child: ChangeNotifierProvider(
        create: (context) => AppModel(),
        child: ChangeNotifierProvider(
          create: (context) => RefreshModel(),
          child: ChangeNotifierProvider(
            create: (context) => EventModel(),
            child: ChangeNotifierProvider(
              create: (context) => RaceModel(),
              child: ChangeNotifierProvider(
                create: (context) => HeatModel(),
                child: Shortcuts(
                  shortcuts: {
                    const SingleActivator(LogicalKeyboardKey.f5): RefreshIntent(),
                    const SingleActivator(LogicalKeyboardKey.escape): CloseIntent(),
                    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS): SaveIntent(),
                    LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyD): DeleteIntent()
                  },
                  child: Consumer<SettingsModel>(
                    builder: (context, model, child) => MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      title: 'RazManager',
                      theme: ThemeData(
                        useMaterial3: true,
                        colorSchemeSeed: model.themeDataColorSchemeSeed,
                        brightness: model.themeDataBrightness,
                        scrollbarTheme: ScrollbarThemeData(thumbVisibility: WidgetStateProperty.all(true)),
                      ),
                      routerConfig: router,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
