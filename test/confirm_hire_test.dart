import 'package:flutter_test/flutter_test.dart';
import 'package:jobfuse/logic/models/register_model.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

Future<void> main() async {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late RegisterModel registerModel;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    registerModel = RegisterModel(
      'image_url',
      'about',
      email: 'test@test.com',
      password: 'password',
      fname: 'Test',
      lname: 'User',
      nrcc: '123456',
      number: 123456789,
      userName: 'testuser',
    );

    registerModel.storeUserDetails = mockFirebaseFirestore;
    registerModel.createWallet = mockFirebaseFirestore;
  });

  test('registerUser() should create user, store user details and create wallet', () async {
    // Stub Firebase Auth methods
    when(mockFirebaseAuth.createUserWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) => Future.value(UserCredential.fromUser(User(uid: '123')))));
    when(mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) => Future.value(UserCredential.fromUser(User(uid: '123')))));

    // Call registerUser method
    await registerModel.registerUser();

    // Verify that createUserWithEmailAndPassword and signInWithEmailAndPassword were called
    verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: 'test@test.com', password: 'password'));
    verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'test@test.com', password: 'password'));

    // Verify that storeUserDetails and createWallet were called
    verify(mockFirebaseFirestore.collection('users').add({
    'First_name': 'Test',
    'Last_name': 'User',
    'NRC_NUMBER': '123456',
    'Phone_Number': 123456789,
    'UserName': 'testuser',
    'Userid': '123',
    'imageUrl': 'image_url',
    'about': 'about',
    'email': 'test@test.com',
    }));
    verify(mockFirebaseFirestore.collection('wallet').add({
    'Userid': '123',
    'balance': 0,
    }));
  })
}
