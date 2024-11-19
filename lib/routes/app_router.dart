import 'package:go_router/go_router.dart';
import 'package:nutrifit/Screens/splash_screen.dart';
import '../Screens/home_screen.dart';


class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/homescreen',
        builder: (context, state) => HomeScreen()
      ),
    ],
  );
}
