// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/widgets.dart' show BuildContext, ModalRoute;

/// Works on Flutter version 3.32.0 May not work on current versions.
/// Using this solution is quite dangerous.
///
/// The reason I'm using this class is because when I want to use the
/// [ModalRoute.of] method to listen to the states on page transitions, it
/// unnecessarily reloads.
/// I discovered this solution when I searched for a solution to the problem.
///  Some developers who had the same problem as me searched for a solution,
/// but it is not officially fixed. Some issues are [#146132](https://github.com/flutter/flutter/issues/146132), [#145387](https://github.com/flutter/flutter/issues/145387) and [#145389](https://github.com/flutter/flutter/pull/145389).
/// [Solution](https://github.com/flutter/flutter/pull/145389#issuecomment-2056036841).
class MyModalRoute {
  // HACK: This method is a temporary solution.
  static ModalRoute<dynamic>? of(BuildContext context) {
    ModalRoute<dynamic>? route;
    context.visitAncestorElements((element) {
      if (element.widget.runtimeType.toString() == '_ModalScopeStatus') {
        final dynamic widget = element.widget;
        route = widget.route as ModalRoute;
        return false;
      }
      return true;
    });
    return route;
  }
}
