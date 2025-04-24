import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sovawallet/blocs/app_data_bloc.dart';
import 'package:sovawallet/blocs/coininfo_bloc.dart';
import 'package:sovawallet/blocs/debug_bloc.dart';
import 'package:sovawallet/blocs/events/coininfo_events.dart';
import 'package:sovawallet/blocs/wallet_bloc.dart';
import 'package:sovawallet/dependency_injection.dart';
import 'package:sovawallet/l10n/app_localizations.dart';
import 'package:sovawallet/path_app.dart';
import 'package:sovawallet/ui/notifer/app_settings_notifer.dart';
import 'package:sovawallet/ui/pages/main/main_page.dart';
import 'package:sovawallet/ui/theme/color_schemes.g.dart';
import 'package:window_manager/window_manager.dart';

import 'blocs/events/app_data_events.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator(await PathAppUtil.getAppPath());
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1000, 800),
      center: true,
      minimumSize: Size(1000, 800),
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(SovaWallet());
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class SovaWallet extends StatelessWidget {
  SovaWallet({super.key});

  final AppSettings _appSettings = locator<AppSettings>();

  Future testWindowFunctions() async {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ListenableBuilder(
        listenable: _appSettings,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
            darkTheme:
                ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
            themeMode:
                _appSettings.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(_appSettings.selectLanguage),
            home: MultiBlocProvider(
              providers: [
                BlocProvider<DebugBloc>(
                    create: (context) => locator<DebugBloc>()),

                BlocProvider<CoinInfoBloc>(create: (context) {
                  var bloc = locator<CoinInfoBloc>();
                  bloc.add(InitBloc());
                  return bloc;
                }),
                BlocProvider<WalletBloc>(
                  create: (context) => locator<WalletBloc>(),
                ),
                BlocProvider<AppDataBloc>(create: (context) {
                  final appDataBloc = locator<AppDataBloc>();
                  appDataBloc.add(InitialConnect());
                  return appDataBloc;
                }),
              ],
              child: const MainPage(),
            ),
          );
        });
  }
}
