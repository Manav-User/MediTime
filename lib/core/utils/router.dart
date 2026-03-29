import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash_screen.dart';
import '../../presentation/screens/welcome_screen.dart';
import '../../presentation/screens/home_dashboard.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/register_screen.dart';
import '../../presentation/screens/add_medicine_screen.dart';
import '../../presentation/screens/add_profile_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final user = FirebaseAuth.instance.currentUser;
    final isAuthenticated = user != null;
    final location = state.uri.toString();

    // Allow splash, welcome, login, register without auth
    final publicRoutes = ['/', '/welcome', '/login', '/register'];
    final isPublic = publicRoutes.contains(location);

    if (!isAuthenticated && !isPublic) {
      return '/welcome';
    }
    if (isAuthenticated && (location == '/login' || location == '/register' || location == '/welcome')) {
      return '/home';
    }
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeDashboard(),
    ),
    GoRoute(
      path: '/add-medicine',
      builder: (context, state) {
        final profileId = state.uri.queryParameters['profileId'] ?? '';
        return AddMedicineScreen(profileId: profileId);
      },
    ),
    GoRoute(
      path: '/add-profile',
      builder: (context, state) => const AddProfileScreen(),
    ),
  ],
);
