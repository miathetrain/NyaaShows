import 'package:discord_rpc/discord_rpc.dart';
import 'package:flutter/material.dart';
import 'package:nyaashows/data/data_manager.dart';
import 'package:nyaashows/discord/discord.dart';
import 'package:nyaashows/trakt/trakt.dart';
import 'package:nyaashows/tvdb/tvdb.dart';
import 'package:nyaashows/utils/locale_fix.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'pages/scaffold.dart' as scaffold;
import 'dart:developer' as developer;

class NyaaShows {
  static Trakt trakt = Trakt();
  static DataManager dataManager = DataManager();
  static RealDebridAPI realDebrid = RealDebridAPI();
  static Discord discord = Discord();
  static TVDB tvdb = TVDB();

  static void log(String message) {
    developer.log(message);
  }
}

void main() async {
  setNumericLocaleToC();
  VideoPlayerMediaKit.ensureInitialized(
    android: true, // default: false    -    dependency: media_kit_libs_android_video
    iOS: true, // default: false    -    dependency: media_kit_libs_ios_video
    macOS: true, // default: false    -    dependency: media_kit_libs_macos_video
    windows: true, // default: false    -    dependency: media_kit_libs_windows_video
    linux: true, // default: false    -    dependency: media_kit_libs_linux
  );

  DiscordRPC.initialize();
  NyaaShows.discord.start();
  runApp(const NyaaApp());

  NyaaShows.tvdb.showIcon(350123);
}

class NyaaApp extends StatelessWidget {
  const NyaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NyaaShows',
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: const MyHomePage(title: 'NyaaShows'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => scaffold.MyHomePageState();
}

enum Menu { settings, trakt, about, realdebrid }
