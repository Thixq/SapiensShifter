import 'package:firebase_auth_module/firebase_auth_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_auth_manager_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<UserCredential>(),
])
void main() {
  late FirebaseAuthManagar authManager;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    authManager = FirebaseAuthManagar.instanceFor(mockFirebaseAuth);
  });

  group('FirebaseAuthManagar Tests', () {
    test('registerInWithEmailAndPassword should return true on success',
        () async {
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => MockUserCredential());

      final result = await authManager.registerInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result, true);
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
    });

    test('signInWithEmailAndPassword should return true on success', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async => MockUserCredential());

      final result = await authManager.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result, true);
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
    });

    test('signOut should return true on success', () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async => Future.value());

      final result = await authManager.signOut();

      expect(result, true);
      verify(mockFirebaseAuth.signOut()).called(1);
    });
  });
}
