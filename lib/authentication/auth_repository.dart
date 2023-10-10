import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stanford/utils/firebase_providers.dart';
import 'package:stanford/utils/type_defs.dart';
import '../utils/constants.dart';
import '../models/citizen.dart';
import 'name_engine/name_engine.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authThingy = ref.watch(authRepositoryProvider);
  return authThingy.authStateChange;
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  AuthRepository(
      {required FirebaseFirestore firestore, required FirebaseAuth auth})
      : _auth = auth,
        _firestore = firestore;

  CollectionReference get _citizens =>
      _firestore.collection(FirestoreConstants.citizenCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEitherFailureOr<Citizen> signUpOrLogIn(
      String email, String password, bool isNewUser) async {
    try {
      Citizen citizen;
      if (isNewUser) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        citizen = Citizen(
          alias: await NameEngine.createUserName,
          markedArticleIds: [],
          catchPhrase: "catchPhrase",
          uid: credential.user!.uid,
        );
        await _citizens.doc(citizen.uid).set(citizen.toMap());
        return right(citizen);
      } else {
        UserCredential credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return right(await getUserData(credential.user!.uid).first);
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Citizen> getCitizen(String uid) async {
    var doofus = await _citizens.doc(uid).snapshots().first;

    return Citizen.fromMap(doofus.data() as Map<String, dynamic>);
  }

  Stream<Citizen> getUserData(String uid) {
    return _citizens
        .doc(uid)
        .snapshots()
        .map((event) => Citizen.fromMap(event.data() as Map<String, dynamic>));
  }
}
