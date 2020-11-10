import 'package:flutter/material.dart';
import 'package:systemAPP/src/pages/home_page.dart';
import 'package:systemAPP/src/routes/routes.dart';
import 'package:systemAPP/src/share_prefs/preferencias_usuario.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily:'Roboto'),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'musicPage',
      routes: getAppRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('ruta llamada ${settings.name}');
        //Navigator.pop(context);
        return MaterialPageRoute(builder: (BuildContext context) => HomePage());
      },
    );
  }
}