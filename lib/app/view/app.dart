// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:deriv_repository/deriv_repository.dart';
import 'package:deriv_tracker/l10n/l10n.dart';
import 'package:deriv_tracker/tracker/tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required DerivRepository derivRepository,
  }) : _derivRepository = derivRepository;

  final DerivRepository _derivRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _derivRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const TickerPage(),
      ),
    );
  }
}
