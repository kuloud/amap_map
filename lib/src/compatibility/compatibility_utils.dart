// Copyright 2025 kuloud

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

import 'dart:io';

class CompatibilityUtils {
  static bool isSdkVersionGreaterOrEqual(int major, int minor, int patch) {
    final List<int> sdkVersion = _parseSdkVersion(Platform.version);
    final _Version current =
        _Version(sdkVersion[0], sdkVersion[1], sdkVersion[2]);
    final _Version target = _Version(major, minor, patch);
    return current.compareTo(target) >= 0;
  }

  static List<int> _parseSdkVersion(String versionString) {
    final RegExp regex = RegExp(r'(\d+)\.(\d+)\.(\d+)');
    final RegExpMatch? match = regex.firstMatch(versionString);
    return <int>[
      int.parse(match!.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!)
    ];
  }
}

class _Version implements Comparable<_Version> {
  final int major;
  final int minor;
  final int patch;

  _Version(this.major, this.minor, this.patch);

  @override
  int compareTo(_Version other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }
}
