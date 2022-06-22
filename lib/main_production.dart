// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:deriv_repository/deriv_repository.dart';
import 'package:deriv_tracker/app/app.dart';
import 'package:deriv_tracker/bootstrap.dart';

void main() {
  bootstrap(
    () => App(derivRepository: DerivRepository()),
  );
}
