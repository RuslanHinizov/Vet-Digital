import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../storage/secure_storage.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/animals/screens/animal_list_screen.dart';
import '../../features/animals/screens/animal_detail_screen.dart';
import '../../features/animals/screens/animal_register_screen.dart';
import '../../features/animals/screens/rfid_scan_screen.dart';
import '../../features/map/screens/live_map_screen.dart';
import '../../features/map/screens/geofence_editor_screen.dart';
import '../../features/procedures/screens/procedure_list_screen.dart';
import '../../features/procedures/screens/create_procedure_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/inventory/screens/inventory_list_screen.dart';
import '../../features/documents/screens/document_preview_screen.dart';
import '../../features/sync/widgets/sync_status_indicator.dart';
import '../../features/map/screens/movement_history_screen.dart';
import '../../features/procedures/screens/procedure_detail_screen.dart';
import '../../features/animals/screens/animal_health_screen.dart';

/// Riverpod provider for the app router instance.
final routerProvider = Provider<GoRouter>((ref) => AppRouter.router);

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    redirect: _authRedirect,
    routes: [
      // Auth
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Shell route for bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/animals',
            name: 'animals',
            builder: (context, state) => const AnimalListScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'animal-detail',
                builder: (context, state) =>
                    AnimalDetailScreen(animalId: state.pathParameters['id']!),
                routes: [
                  GoRoute(
                    path: 'health',
                    name: 'animal-health',
                    builder: (context, state) => AnimalHealthScreen(
                      animalId: state.pathParameters['id']!,
                      animalName: state.uri.queryParameters['name'],
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'register',
                name: 'animal-register',
                builder: (context, state) => const AnimalRegisterScreen(),
              ),
              GoRoute(
                path: 'rfid-scan',
                name: 'rfid-scan',
                builder: (context, state) => const RFIDScanScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/map',
            name: 'map',
            builder: (context, state) => const LiveMapScreen(),
            routes: [
              GoRoute(
                path: 'geofence-editor',
                name: 'geofence-editor',
                builder: (context, state) => const GeofenceEditorScreen(),
              ),
              GoRoute(
                path: 'track/:animalId',
                name: 'movement-history',
                builder: (context, state) => MovementHistoryScreen(
                  animalId: state.pathParameters['animalId']!,
                  animalName: state.uri.queryParameters['name'],
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/procedures',
            name: 'procedures',
            builder: (context, state) => const ProcedureListScreen(),
            routes: [
              GoRoute(
                path: 'create',
                name: 'create-procedure',
                builder: (context, state) => const CreateProcedureScreen(),
              ),
              GoRoute(
                path: ':id',
                name: 'procedure-detail',
                builder: (context, state) => ProcedureDetailScreen(
                  procedureId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/inventory',
            name: 'inventory',
            builder: (context, state) => const InventoryListScreen(),
          ),
          GoRoute(
            path: '/sync',
            name: 'sync',
            builder: (context, state) => const SyncStatusScreen(),
          ),
          GoRoute(
            path: '/documents/:id',
            name: 'document-preview',
            builder: (context, state) => DocumentPreviewScreen(
              documentId: state.pathParameters['id']!,
              documentType: state.uri.queryParameters['type'] ?? 'procedure_act',
            ),
          ),
        ],
      ),
    ],
  );

  static Future<String?> _authRedirect(BuildContext context, GoRouterState state) async {
    final isLoggedIn = await SecureStorage.instance.isLoggedIn();
    final isOnLogin = state.matchedLocation == '/login';

    if (!isLoggedIn && !isOnLogin) return '/login';
    if (isLoggedIn && isOnLogin) return '/home';
    return null;
  }
}

/// Bottom navigation shell wrapper
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.pets_outlined), selectedIcon: Icon(Icons.pets), label: 'Животные'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Карта'),
          NavigationDestination(icon: Icon(Icons.medical_services_outlined), selectedIcon: Icon(Icons.medical_services), label: 'Процедуры'),
          NavigationDestination(icon: Icon(Icons.person_outlined), selectedIcon: Icon(Icons.person), label: 'Профиль'),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0: context.go('/home');
            case 1: context.go('/animals');
            case 2: context.go('/map');
            case 3: context.go('/procedures');
            case 4: context.go('/profile');
          }
        },
        selectedIndex: _getCurrentIndex(context),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/animals')) return 1;
    if (location.startsWith('/map')) return 2;
    if (location.startsWith('/procedures')) return 3;
    return 4;
  }
}
