import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home directory/screens/home_screen.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/home_screen',
  routes: <RouteBase>[
    GoRoute(
      path: '/home_screen',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
);
class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(error?.toString() ?? 'Unknown error occurred')),
    );
  }
}

