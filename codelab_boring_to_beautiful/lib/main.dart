// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'src/shared/app.dart';

Future setDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(const Size(400, 400));
  // TODO: this doesn't actually work the way it should.
  // Yes it will resize the window but not until after it has already been drawn
  // by the C++ code in your platform folder e.g. 'linux' has drawn it and thus
  // you get a obvious visible resizing of the window.
  await DesktopWindow.setWindowSize(const Size(1300, 900));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isDesktop) {
    setDesktopWindow();
  }

  runApp(const MyApp());
}
