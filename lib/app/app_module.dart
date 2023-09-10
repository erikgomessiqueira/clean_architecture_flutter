import 'package:flutter_modular/flutter_modular.dart';

import 'modules/search/search_module.dart';

class AppModule extends Module {

  @override
  void routes(RouteManager r) {
    r.module('/', module: SearchModule());
  }

}