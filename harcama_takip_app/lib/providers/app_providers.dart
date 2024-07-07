import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../view_model/auth_view_model/login_page_view_model.dart';
import '../view_model/auth_view_model/loginorregister_page_view_model.dart';
import '../view_model/auth_view_model/register_page_view_model.dart';
import '../view_model/expanses_page_view_model.dart';
import '../view_model/homepage_view_model.dart';
import '../view_model/person_page_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => HomepageViewModel(),),
  ChangeNotifierProvider(
    create: (context) => LoginPageViewModel(),
  ),
  ChangeNotifierProvider(create: (context) => RegisterPageViewModel()),
  ChangeNotifierProvider(
    create: (context) => LoginOrRegisterPageViewModel(),
  ),
  ChangeNotifierProvider(create: (context) => ExpansesPageViewModel()),
  ChangeNotifierProvider(create: (context) => PersonPageViewModel(),)
];