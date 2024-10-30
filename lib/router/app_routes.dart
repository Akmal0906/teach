import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:teach/features/home/presentation/pages/add_task/add_task_page.dart";

import "../core/local_source/local_source.dart";
import "../features/auth/presentation/bloc/auth_bloc.dart";
import "../features/auth/presentation/pages/auth_page.dart";
import "../features/home/presentation/bloc/home_bloc/home_page_bloc.dart";
import "../features/home/presentation/pages/home_page.dart";
import "../features/main/presentation/bloc/main_bloc.dart";
import "../features/main/presentation/pages/main_page.dart";
import "../features/other/presentation/pages/splash/splash_page.dart";
import "../features/profile/presentation/bloc/profile_bloc.dart";
import "../features/profile/presentation/pages/profile_page.dart";
import "../injector_container.dart";


part "name_routes.dart";

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();


final LocalSource localSource = sl<LocalSource>();


final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.initial,
  routes: <RouteBase>[
    GoRoute(
      path: Routes.initial,
      name: Routes.initial,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const SplashPage(),
    ),
    // GoRoute(
    //   path: Routes.noInternet,
    //   name: Routes.noInternet,
    //   parentNavigatorKey: rootNavigatorKey,
    //   builder: (_, __) => const InternetConnectionPage(),
    // ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      builder: (
          _,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
          ) =>
          BlocProvider<MainBloc>(
            key: state.pageKey,
            create: (_) => sl<MainBloc>(),
            child: MainPage(
              key: state.pageKey,
              navigationShell: navigationShell,
            ),
          ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          initialLocation: Routes.explore,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.explore,
              name: Routes.explore,
              builder: (_, __) =>
                  BlocProvider<HomePageBloc>(
                    create: (_) => sl<HomePageBloc>()
                    // ..add(HomePageLessonsEvent())
                    , child:
                  const HomePage(),
                  ),
            ),
          ],
        ),

        StatefulShellBranch(
          initialLocation: Routes.profile,
          routes: <RouteBase>[
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (_, __) => BlocProvider<ProfileBloc>(
                  create: (_)=>sl<ProfileBloc>(),
                  child: const ProfilePage()),
            ),
          ],
        ),
      ],
    ),

    /// home features
    GoRoute(
      path: Routes.addTask,
      name: Routes.addTask,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => const AddTaskPage(),
    ),


    /// Auth
    GoRoute(
      path: Routes.auth,
      name: Routes.auth,
      parentNavigatorKey: rootNavigatorKey,
      builder: (_, __) => BlocProvider<AuthBloc>(
        create: (_) => sl<AuthBloc>(),
        child: const AuthPage(),
      ),
    ),


  ],
);
