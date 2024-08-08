import 'package:mtohconnect/services/auth/auth_user.dart';


abstract class Authprovider{

AuthUser? get currentUser;

Future<AuthUser> Login({
  required String email,
  required String password,
}
);


Future<AuthUser> CreateUser({
  required String email,
  required String password,
}
);

Future<void> Logout();
Future<void> sendEmailVerification();



  

}