class Routes {
  static const String intial = '/';
  static const String signin = '/signin';
  static const String home = '/home';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';
  static const String explore = '/explore';
  static const String profile = '/profile';
  static const String conversation = '/conversation';
}

// class AppRouter {
//   static Route<dynamic>? onGenerateRoute(
//       RouteSettings settings, FirebaseAuth firebaseAuth) {
//     final args = settings.arguments;
//     switch (settings.name) {
//       //  Routes.explore: (_) => const ExploreScreen(),
//       case Routes.explore:
//         print("using onGenerateRoute");
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => const ExploreScreen(),
//           settings: settings,
//           fullscreenDialog: true,
//         );
//       case Routes.conversation:
//         print("using onGenerateRoute");
//         final mapArgs = args as Map<String, dynamic>;
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => ConverstationScreen(groupId: mapArgs['groupid']),
//           settings: settings,
//           fullscreenDialog: true,
//         );
// case Routes.editJobPage:
//   return MaterialPageRoute<dynamic>(
//     builder: (_) => EditJobPage(job: args as Job?),
//     settings: settings,
//     fullscreenDialog: true,
//   );
// case Routes.entryPage:
//   final mapArgs = args as Map<String, dynamic>;
//   final job = mapArgs['job'] as Job;
//   final entry = mapArgs['entry'] as Entry?;
//   return MaterialPageRoute<dynamic>(
//     builder: (_) => EntryPage(job: job, entry: entry),
//     settings: settings,
//     fullscreenDialog: true,
//   );
//       default:
//         // TODO: Throw
//         return null;
//     }
//   }
// }
