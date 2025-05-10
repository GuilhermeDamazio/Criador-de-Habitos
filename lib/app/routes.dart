import 'package:flutter/material.dart';
import '../features/welcome/presentation/welcome_screen.dart';
import '../features/welcome/auth/presentation/signup_screen.dart';
import '../features/habit/presentation/habit_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/settings/presentation/settings_screen.dart';


class Routes {
  static const welcome = '/';
  static const signup = '/signup';
  static const habit = '/habit';
  static const profile = '/profile';
  static const settings = '/settings';


  static final routes = <String, WidgetBuilder>{
    welcome: (_) => const WelcomeScreen(),
    signup: (_) => const SignupScreen(),
    habit: (_) => const HabitScreen(),
    profile: (_) => const ProfileScreen(),
    settings: (_) => const SettingsScreen(),

  };
}
