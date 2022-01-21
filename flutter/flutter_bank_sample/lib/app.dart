import 'package:authentication_repository/authentication_repository.dart';
import 'package:bank_data_repository/bank_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bank_sample/src/features/auth/auth_flow.dart';
import 'package:flutter_bank_sample/src/features/auth/bloc/authentication_bloc.dart';
import 'package:flutter_bank_sample/src/features/dashboard/dashboard_flow.dart';
import 'package:flutter_bank_sample/src/extensions/build_context.dart';
import 'package:flutter_bank_sample/src/features/splash/view/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'src/theme/theme_model.dart';
import 'src/theme/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(create: (context) => authenticationRepository),
        RepositoryProvider<BankDataRepository>(create: (context) => BankDataRepository(
          baseUrl: 'jsonplaceholder.typicode.com',
          httpClient: Client(),
        )),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: _MyAppView(),
      ),
    );
  }
}

class _MyAppView extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(builder: (context, ThemeModel themeNotifier, child) {
        return MaterialApp(
          title: 'Flutter Bank Sample',
          theme: themeNotifier.isDark ?? context.isDarkMode() ? Themes.getDark(context) : Themes.getLight(context),
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          onGenerateRoute: (settings) {
            String name = settings.name ?? "";
            int prefixEnd = name.contains("/") ? name.indexOf("/") : name.length;
            var rootPrefix = name.substring(0, prefixEnd);
            switch (rootPrefix) {
              case SplashPage.route:
                return MaterialPageRoute(builder: (_) => const SplashPage());
              case AuthFlow.routePrefix:
                return MaterialPageRoute(builder: (_) => AuthFlow(setupPageRoute: name));
              case DashboardFlow.routePrefix:
                return MaterialPageRoute(builder: (_) => DashboardFlow(setupPageRoute: name));
              default:
                return MaterialPageRoute(builder: (_) => const SplashPage());
            }
          },
        );
      }),
    );
  }
}
