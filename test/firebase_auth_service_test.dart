import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/features/authentication/controllers/authentication_controller.dart';

void main() {
  late AuthenticationController authController;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    final mockUser = MockUser(
      uid: 'someuid',
      email: 'test@example.com',
      displayName: 'Test User',
    );

    mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);    
    authController = AuthenticationController(firebaseAuth: mockFirebaseAuth);
  });

  test('signIn calls FirebaseAuth signInWithEmailAndPassword and succeeds', () async {
    await authController.signIn(
      email: 'test@example.com',
      password: 'password',
    );

    // Проверяем, что пользователь успешно аутентифицирован
    expect(mockFirebaseAuth.currentUser, isNotNull);
    expect(mockFirebaseAuth.currentUser?.email, equals('test@example.com'));
  });
}