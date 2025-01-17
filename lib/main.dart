import 'package:hao_chatgpt/src/app_router.dart';
import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/constants.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hao_chatgpt/src/preferences_manager.dart';

import 'l10n/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appManager.init();
  runApp(const ProviderScope(child: MyApp()));

  // This callback is called every time the system brightness changes.
  // SingletonFlutterWindow window = WidgetsBinding.instance.window;
  // window.onPlatformBrightnessChanged = () {
  //   print('BrightnessChanged = '+window.platformBrightness.toString());
  // };
}

final StateProvider<ThemeMode> themeProvider =
    StateProvider((ref) => appPref.themeMode);
final StateProvider<Locale?> localeProvider =
    StateProvider((ref) => appPref.locale);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setSystemNavigationBarColor(ref.watch(themeProvider));
    return MaterialApp.router(
      title: 'HaoChat',
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).haoChat,
      locale: ref.watch(localeProvider),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Constants.enLocale,
        Constants.zhLocale,
      ],
      themeMode: ref.watch(themeProvider),
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        extensions: <ThemeExtension<dynamic>>[MyColors.light],
      ),
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        extensions: <ThemeExtension<dynamic>>[MyColors.dark],
      ),
      routerConfig: AppRouter().goRouter,
    );
  }
}
