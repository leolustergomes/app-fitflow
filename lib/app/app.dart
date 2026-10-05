import 'package:flutter/material.dart';

import '../core/utils/weight_unit.dart';
import '../data/mock_data.dart';
import '../models/user_profile.dart';
import '../models/workout.dart';
import '../models/workout_session.dart';
import '../screens/home/home_screen.dart';
import '../screens/workouts/workouts_screen.dart';
import '../screens/progress/progress_screen.dart';
import '../screens/profile/profile_screen.dart';
import 'theme.dart';

class FitFlowApp extends StatefulWidget {
  const FitFlowApp({super.key});

  @override
  State<FitFlowApp> createState() => _FitFlowAppState();
}

class _FitFlowAppState extends State<FitFlowApp> {
  ThemeMode themeMode = ThemeMode.dark;

  void setLightMode(bool enabled) {
    setState(() => themeMode = enabled ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitFlow',
      theme: buildFitFlowTheme(Brightness.light),
      darkTheme: buildFitFlowTheme(Brightness.dark),
      themeMode: themeMode,
      home: MainNavigation(
        themeMode: themeMode,
        onLightModeChanged: setLightMode,
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onLightModeChanged;

  const MainNavigation({
    super.key,
    required this.themeMode,
    required this.onLightModeChanged,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;
  late List<Workout> workouts;
  late UserProfile profile;
  WeightUnit weightUnit = WeightUnit.kg;
  bool notificationsEnabled = true;
  int completedWorkoutCount = 12;
  int totalWorkoutSeconds = 4 * 3600 + 32 * 60;
  late List<WorkoutSession> sessions;

  @override
  void initState() {
    super.initState();
    workouts = List<Workout>.from(MockData.workouts);
    profile = const UserProfile(
      name: 'Leonardo',
      goal: TrainingGoal.hipertrofiaForca,
      level: TrainingLevel.intermediario,
    );
    sessions = [
      WorkoutSession(
        workout: MockData.workouts[1],
        completedAt: DateTime(2026, 8, 26),
        durationSeconds: 48 * 60,
      ),
      WorkoutSession(
        workout: MockData.workouts[0],
        completedAt: DateTime(2026, 8, 24),
        durationSeconds: 51 * 60,
      ),
      WorkoutSession(
        workout: MockData.workouts[2],
        completedAt: DateTime(2026, 8, 22),
        durationSeconds: 55 * 60,
      ),
    ];
  }

  void addWorkout(Workout workout) {
    setState(() => workouts.add(workout));
  }

  void recordWorkout(WorkoutSession session) {
    setState(() {
      completedWorkoutCount++;
      totalWorkoutSeconds += session.durationSeconds;
      sessions.insert(0, session);
    });
  }

  void updateProfile(UserProfile value) {
    setState(() => profile = value);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        workouts: workouts,
        sessions: sessions,
        completedWorkoutCount: completedWorkoutCount,
        totalWorkoutSeconds: totalWorkoutSeconds,
        weightUnit: weightUnit,
        onWorkoutCompleted: recordWorkout,
      ),
      WorkoutsScreen(
        workouts: workouts,
        weightUnit: weightUnit,
        onWorkoutCreated: addWorkout,
        onWorkoutCompleted: recordWorkout,
      ),
      ProgressScreen(
        sessions: sessions,
        weightUnit: weightUnit,
      ),
      ProfileScreen(
        profile: profile,
        weightUnit: weightUnit,
        notificationsEnabled: notificationsEnabled,
        isLightMode: widget.themeMode == ThemeMode.light,
        onProfileChanged: updateProfile,
        onWeightUnitChanged: (value) => setState(() => weightUnit = value),
        onNotificationsChanged: (value) => setState(() => notificationsEnabled = value),
        onLightModeChanged: widget.onLightModeChanged,
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => setState(() => currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Treinos',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Evolução',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
