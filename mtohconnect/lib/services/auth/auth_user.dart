import 'package:firebase_auth/firebase_auth.dart' show User;

import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailverified;
  const AuthUser(this.isEmailverified);

  factory AuthUser.fromFirebaseauth(User user) => AuthUser(user.emailVerified);
  
}