import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:test_app/features/authentication/controllers/authentication_controller.dart';
import 'package:test_app/features/authentication/controllers/user_database_controller.dart';
import 'package:test_app/features/map/controllers/map_controller.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (ctx) => MapController()),
  ChangeNotifierProvider(
      create: (ctx) =>
          AuthenticationController(firebaseAuth: FirebaseAuth.instance)),
  ChangeNotifierProvider(create: (ctx) => UserDatabaseController()),
];
