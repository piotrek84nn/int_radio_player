import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:piotrek84nn_int_radio_player/bloc/player_bloc.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/colors.dart';
import 'package:piotrek84nn_int_radio_player/presentation/constants/constant.dart';
import 'package:piotrek84nn_int_radio_player/presentation/screens/player_page.dart';
import 'package:piotrek84nn_int_radio_player/utils/di/i_locator.dart';
import 'package:piotrek84nn_int_radio_player/utils/di/locator_imp.dart';

ILocator _locator = LocatorImp.newInstance();

Future<void> main() async {
  _locator.initialize();
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Fimber.plantTree(DebugTree());

  await _initBackgroundAgent();
  runApp(
    const MyApp(),
  );
}

Future<void> _initBackgroundAgent() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'pl.piotrek84nn.radio_player.channel.audio',
    androidNotificationChannelName: 'Radio Player',
    androidNotificationOngoing: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: mainWidgetName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: mainColor,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => _locator.get<PlayerBloc>(),
        child: const PlayerPage(),
      ),
    );
  }
}
