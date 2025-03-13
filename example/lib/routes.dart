import 'package:amap_map_example/demo.dart';
import 'package:flutter/material.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String?);

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument a RegEx match if that is included
  /// in the pattern.
  ///
  /// ```dart
  /// Path(
  ///   'r'^/([\w-]+)$',
  ///   (context, matches) => Page(argument: match),
  /// )
  /// ```
  final PathWidgetBuilder builder;
}

class RouteConfig {
  static final List<Path> _paths = <Path>[
    Path(
      r'^/([\w-]+)$',
      (BuildContext context, String? match) => DemoPage(slug: match),
    ),
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (final Path path in _paths) {
      final RegExp regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name!)) {
        final RegExpMatch firstMatch =
            regExpPattern.firstMatch(settings.name!)!;
        final String? match =
            (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;

        return MaterialPageRoute<void>(
          builder: (BuildContext context) => path.builder(context, match),
          settings: settings,
        );
      }
    }
    return null;
  }
}
