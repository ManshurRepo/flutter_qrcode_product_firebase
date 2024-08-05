import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(AuthStateLogout()) {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     on<AuthEventLogin>((event, emit) async {
//       //fungsi untuk login
//       try {
//         emit(AuthStateLoading());
//         await auth.signInWithEmailAndPassword(
//             email: event.email, password: event.password);
//         emit(AuthStateLogin());
//       } on FirebaseAuthException catch (e) {
//         emit(AuthStateError(e.message.toString()));
//       } catch (e) {
//         emit(AuthStateError(e.toString()));
//       }
//     });

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    FirebaseAuth auth = FirebaseAuth.instance;

    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        final User? user = userCredential.user;

        if (user != null) {
          String? idToken = await user.getIdToken();
          print(idToken);
          if (idToken != null) {
            emit(AuthStateLogin(idToken));
          } else {
            emit(AuthStateError("Failed to get ID token."));
          }
        } else {
          emit(AuthStateError("User not found."));
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      await auth.signOut();
      emit(AuthStateLogout());
    });

    // on<AuthEventLogout>((event, emit) async {
    //   //fungsi untuk login
    //   try {
    //     emit(AuthStateLoading());
    //     await auth.signOut();
    //     emit(AuthStateLogout());
    //   } on FirebaseAuthException catch (e) {
    //     emit(AuthStateError(e.message.toString()));
    //   } catch (e) {
    //     emit(AuthStateError(e.toString()));
    //   }
    // });
  }
}
