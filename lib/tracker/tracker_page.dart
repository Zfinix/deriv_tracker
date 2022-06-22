// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:deriv_repository/deriv_repository.dart';
import 'package:deriv_tracker/tracker/tracker.dart';
import 'package:deriv_tracker/tracker/tracker_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TickerPage extends StatelessWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DerivTrackerCubit(
        context.read<DerivRepository>(),
      )..listen(),
      child: const TickerView(),
    );
  }
}

class TickerView extends StatelessWidget {
  const TickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Deriv Price Tracker',
          style: GoogleFonts.sora(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: DerivTrackerUI(key: Key('_DerivTrackerUI_')),
    );
  }
}
