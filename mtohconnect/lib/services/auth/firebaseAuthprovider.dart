
import 'package:firebase_core/firebase_core.dart';
import 'package:mtohconnect/firebase_options.dart';
import 'package:mtohconnect/services/auth/Authprovider.dart';
import 'package:mtohconnect/services/auth/auth_exceptions.dart';
import 'package:mtohconnect/services/auth/auth_exceptions.dart';

import 'package:mtohconnect/services/auth/auth_user.dart' ;
import 'package:firebase_auth/firebase_auth.dart'show FirebaseAuth,FirebaseAuthException;
class firebaseAuthProvider implements Authprovider{
  @override
  Future<AuthUser> CreateUser({required String email, required String password})
  async {
  
 try{ 
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
   final user = currentUser;
   if(user!=null){
    return user;
   }else{
    throw UsernotLoggedInException();
   }
  } on FirebaseAuthException catch(e){
    
                if(e.code=='email-already-in-use'){
                  throw EmailaleAdyinuse();

                }
                else if(e.code==' weak-password'){
              
                 throw WeakpPassword();
                } else if(e.code=='invalid-email'){
             throw InvalidEmailAddresss();
                }
                else{
             throw GenericException();
                }
               

  }catch (_){
throw GenericException();
  }
  }

  @override
  Future<AuthUser> Login({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user=currentUser;
      if(user!=null){
        return user;
      }else{
        throw UsernotLoggedInException();
      }
    }on FirebaseAuthException catch(e){
       if(e.code=='user-not-found'){
                       throw UsernotFound();       
                 }else if(e.code=='wrong-password'){
               throw WrongPassword();
                 }else {
                 throw GenericException();

                 }

    }catch(_){
       throw GenericException();
    }
    
  
  }

  @override
  Future<void> Logout() async{
   final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      await FirebaseAuth.instance.signOut();
    }
    else{
      throw UsernotLoggedInException();
    }
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser{
    final user=FirebaseAuth.instance.currentUser;
    if(user != null){
   return AuthUser.fromFirebaseauth(user);
    }else{
      return null;
    }
  }

  @override
  Future<void> sendEmailVerification() {
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      return user.sendEmailVerification();
    }
    else{
      throw UsernotLoggedInException();
    }
  }
  
  @override
  Future<void> Initialize()async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  
  }


}