import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'regiser_state.dart';

class RegiserCubit extends Cubit<RegiserState> {
  RegiserCubit() : super(RegiserInitial());
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String Confirmpassword,
    required String gender,
    required String address,
    required bool isAdmin,
  }) async {
    emit(RegiserLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "mail": email,
        "name": name,
        "phone": phone,
        "address": address,
        "password": password,
        "confirmpassword": Confirmpassword,
        "gendre": gender,
        "isAdmin": isAdmin,
      });
      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        user.emailVerified ? emit(RegiserSuccess()): emit(RegiserFailure("email not verified"));
      }
      emit(RegiserSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegiserFailure("'The password provided is too weak.'"));
      } else if (e.code == 'email-already-in-use') {
        emit(RegiserFailure("email already in use"));
      }
    } catch (e) {
      emit(RegiserFailure("there was an Error please try again ....."));
    }
  }
}
