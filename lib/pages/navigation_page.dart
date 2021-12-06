import 'package:cowis/pages/authentication_page.dart';
import 'package:cowis/pages/organisation_list_page.dart';
import 'package:cowis/providers/auth_service_providers.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  late AuthServiceProvider _authServiceProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthServiceProvider>.value(
      value: AuthServiceProvider.instance,
      child: Builder(builder: (_context) {
        _authServiceProvider = Provider.of<AuthServiceProvider>(_context);
        return _authServiceProvider.authStatus == AuthStatus.Authenticating
            ? ModalProgressHUD(
                child: AuthPage(),
                inAsyncCall: true,
                progressIndicator: CircularProgressIndicator(),
              )
            : _authServiceProvider.authStatus == AuthStatus.Authenticated
                ? OrganisationListPage()
                : AuthPage();
      }),
    );
  }
}
