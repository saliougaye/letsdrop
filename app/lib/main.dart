import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:letsdrop/blocs/auth/auth_bloc.dart';
import 'package:letsdrop/blocs/countries/countries_bloc.dart';
import 'package:letsdrop/blocs/drops/drops_bloc.dart';
import 'package:letsdrop/blocs/theme/theme_bloc.dart';
import 'package:letsdrop/constants/routes.dart';
import 'package:letsdrop/models/user.dart';
import 'package:letsdrop/services/api_service.dart';
import 'package:letsdrop/services/spotify_service.dart';
import 'package:letsdrop/ui/add_drop/add_drop.dart';
import 'package:letsdrop/ui/home/home.dart';
import 'package:letsdrop/ui/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';


void onCallbackDispatcher(ApiService apiService) {
  Workmanager().executeTask((taskName, inputData) async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const initSetttings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initSetttings);

    try {
      final drops = await apiService.getDrops();

      final todayDrops =
          drops.where((element) => element.dropDate == DateTime.now());

      if (todayDrops.isNotEmpty) {
        showNotification(flp);
      }

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();
  final spotifyService = SpotifyService();
  final sharedPreferences = await SharedPreferences.getInstance();
  
  // await Workmanager().initialize(onCallbackDispatcher,
  //     isInDebugMode: false);

  // await Workmanager().registerPeriodicTask(
  //     "lets_drop_notification_worker", "lets_drop_notification_worker_periodic",
  //     frequency: const Duration(minutes: 15),
  //     initialDelay: const Duration(seconds: 1));

  runApp(MyApp(
    apiService: apiService,
    spotifyService: spotifyService,
    sharedPreferences: sharedPreferences,
  ));
}



showNotification(FlutterLocalNotificationsPlugin flp) async {
  const android = AndroidNotificationDetails('letsdropchannel', 'lets drop',
      channelDescription: 'LetsDrop Notification',
      priority: Priority.high,
      importance: Importance.max);
  const iOS = IOSNotificationDetails();
  const platform = NotificationDetails(android: android, iOS: iOS);

  await flp.show(
    0,
    "New Drops Today",
    "See the drops of the day 🅿",
    platform,
  );
}

class MyApp extends StatelessWidget {
  final ApiService apiService;
  final SpotifyService spotifyService;
  final SharedPreferences sharedPreferences;

  const MyApp({Key? key, required this.apiService, required this.spotifyService, required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc(sharedPreferences: sharedPreferences)),
        BlocProvider(
            create: (context) =>
                DropsBloc(apiService: apiService)..add(LoadDrops())),
        BlocProvider(
            create: (context) =>
                CountriesBloc(apiService: apiService)..add(LoadCountries())),
        BlocProvider(
          create: (context) => AuthBloc(spotifyService: spotifyService)..add(AppLoaded()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState state) {
        return MaterialApp(
          title: 'LetsDrop',
          theme: state.appThemeData,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.Login,
          onGenerateRoute: (settings) {
            final args = settings.arguments;
            switch (settings.name) {
              case AppRoutes.Home:

                if (args is SpotifyUser) {
                  return MaterialPageRoute(
                    builder: (context) => Home(user: args)
                  );
                }

                break;
              default:
                return null;
            }
          },
          routes: {
            AppRoutes.Add: (context) => const AddNewDropScreen(),
            AppRoutes.Login: (context) => const Login()
          },
        );
      }),
    );
  }
}
