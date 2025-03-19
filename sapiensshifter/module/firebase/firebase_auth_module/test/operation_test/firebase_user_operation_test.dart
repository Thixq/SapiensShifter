// firebase_auth_user_operation_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth_module/src/firebase_auth_user_operation.dart';

// @GenerateNiceMocks anotasyonu ile FirebaseAuth ve User için mock nesneler oluşturuyoruz.
@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<User>()])
import 'firebase_user_operation_test.mocks.dart';

// FakeFirebaseAuth sınıfı, testlerde bağımlılığı enjeksiyon yoluyla kullanabilmemiz için oluşturulmuştur.
class FakeFirebaseAuth extends Fake implements FirebaseAuth {
  User? _currentUser;
  @override
  User? get currentUser => _currentUser;
  set currentUser(User? user) => _currentUser = user;
}

void main() {
  late FakeFirebaseAuth fakeFirebaseAuth;
  late MockUser mockUser;
  late FirebaseAuthUserOperation authOperation;

  setUp(() {
    fakeFirebaseAuth = FakeFirebaseAuth();
    mockUser = MockUser();
    fakeFirebaseAuth.currentUser = mockUser;
    authOperation = FirebaseAuthUserOperation(fakeFirebaseAuth);
  });

  group('FirebaseAuthUserOperation', () {
    test('user getter doğru UserModel değerlerini döner', () {
      // Mock kullanıcının alanlarını ayarla.
      when(mockUser.uid).thenReturn('user123');
      when(mockUser.photoURL).thenReturn('http://photo.url');
      when(mockUser.displayName).thenReturn('Test User');
      when(mockUser.email).thenReturn('test@example.com');

      final userModel = authOperation.user;
      expect(userModel?.id, equals('user123'));
      expect(userModel?.photoUrl, equals('http://photo.url'));
      expect(userModel?.displayName, equals('Test User'));
      expect(userModel?.email, equals('test@example.com'));
    });

    test('displayUpdate, updateDisplayName ve reload metodlarını çağırır',
        () async {
      const newName = 'New Name';

      // updateDisplayName ve reload çağrılarını stub'layalım.
      when(mockUser.updateDisplayName(newName)).thenAnswer((_) async {});
      when(mockUser.reload()).thenAnswer((_) async {});

      // reload sonrasında currentUser'ı yine aynı mock olarak ayarlıyoruz.
      fakeFirebaseAuth.currentUser = mockUser;

      final result = await authOperation.displayNameUpdate(newName);
      expect(result, isTrue);
      verify(mockUser.updateDisplayName(newName)).called(1);
      verify(mockUser.reload()).called(1);
    });

    test('passwordUpdate, updatePassword ve reload metodlarını çağırır',
        () async {
      const newPassword = 'newPassword123';

      when(mockUser.updatePassword(newPassword)).thenAnswer((_) async {});
      when(mockUser.reload()).thenAnswer((_) async {});
      fakeFirebaseAuth.currentUser = mockUser;

      final result = await authOperation.passwordUpdate(newPassword);
      expect(result, isTrue);
      verify(mockUser.updatePassword(newPassword)).called(1);
      verify(mockUser.reload()).called(1);
    });

    test('photographUpdate, updatePhotoURL ve reload metodlarını çağırır',
        () async {
      const newPhotoUrl = 'https://cataas.com/cat';

      when(mockUser.updatePhotoURL(newPhotoUrl)).thenAnswer((_) async {});
      when(mockUser.reload()).thenAnswer((_) async {});
      fakeFirebaseAuth.currentUser = mockUser;

      final result = await authOperation.photographUpdate(newPhotoUrl);
      expect(result, isTrue);
      verify(mockUser.updatePhotoURL(newPhotoUrl)).called(1);
      verify(mockUser.reload()).called(1);
    });

    test('Kullanıcı null ise metodlar exception fırlatır', () async {
      // Kullanıcı null olduğunda exception beklenmeli.
      fakeFirebaseAuth.currentUser = null;
      authOperation = FirebaseAuthUserOperation(fakeFirebaseAuth);

      expect(authOperation.displayNameUpdate('any'), throwsException);
      expect(authOperation.passwordUpdate('any'), throwsException);
      expect(authOperation.photographUpdate('any'), throwsException);
    });
  });
}
