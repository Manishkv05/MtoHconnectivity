import 'package:mtohconnect/services/auth/auth_user.dart';
import 'package:mtohconnect/services/auth/Authprovider.dart';

class Authservies implements Authprovider { 
  final Authprovider provider;

  Authservies(this.provider); 



   @override
  Future<AuthUser> CreateUser({
    required String email,
     required String password})=>provider.CreateUser(email: email, password: password);

  @override
  Future<AuthUser> Login({
    required String email,
     required String password}) =>provider.Login(email: email, password: password);

  @override
  Future<void> Logout()=>provider.Logout();

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser =>provider.currentUser;

  @override
  Future<void> sendEmailVerification()=>provider.sendEmailVerification();
}
