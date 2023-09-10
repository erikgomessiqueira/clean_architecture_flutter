import 'package:flutter_modular/flutter_modular.dart';
import 'search_store.dart';

import 'search_page.dart';
 
class SearchModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(SearchStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child:(context) => const SearchPage());
  }
}