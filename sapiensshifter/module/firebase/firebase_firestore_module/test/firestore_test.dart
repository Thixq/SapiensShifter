// firebase_firestore_operation_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'localization_config/l10n_prodiver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:core/core.dart';
import 'package:firebase_firestore_module/src/exception/module_firestore_exception.dart';

// @GenerateNiceMocks anotasyonu ile Firestore ve ilgili sınıfların mock nesnelerini oluşturuyoruz.
@GenerateNiceMocks(
  [
    MockSpec<FirebaseFirestore>(),
    MockSpec<CollectionReference<Map<String, dynamic>>>(),
    MockSpec<DocumentReference<Map<String, dynamic>>>(),
    MockSpec<WriteBatch>(),
    MockSpec<QuerySnapshot<Map<String, dynamic>>>(),
    MockSpec<QueryDocumentSnapshot<Map<String, dynamic>>>(),
    MockSpec<DocumentSnapshot<Map<String, dynamic>>>(),
    MockSpec<DocumentReference<TestModel>>(as: #TestModelDocRef),
    MockSpec<DocumentSnapshot<TestModel>>(as: #TestModelDocSnapshot),
  ],
)
import 'firestore_test.mocks.dart';

// Testlerde kullanılacak basit model
class TestModel implements IBaseModel<TestModel> {
  final String id;
  final String name;

  TestModel({required this.id, required this.name});

  factory TestModel.empty() => TestModel(id: '', name: '');

  @override
  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  @override
  TestModel fromJson(Map<String, dynamic> json) =>
      TestModel(id: json['id'] as String, name: json['name'] as String);
}

void main() {
  late MockFirebaseFirestore mockFirestore;
  late FirebaseFirestoreOperation firestoreOperation;

  setUp(() {
    LocalizationProvider.setInstance(MockLocalizationProvider());
    mockFirestore = MockFirebaseFirestore();
    firestoreOperation = FirebaseFirestoreOperation(firestore: mockFirestore);
  });

  group('addItem', () {
    test('yeni doküman eklenirken (docId yoksa) add metodu çağrılır', () async {
      // Hazırlık: path "testCollection" olduğundan docId bulunmaz.
      final testModel = TestModel(id: '1', name: 'Test');
      const path = 'testCollection';

      // Generics parametreleri belirtilmeden mock nesnesi oluşturuluyor.
      final mockCollection = MockCollectionReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.add(testModel.toJson()))
          .thenAnswer((_) async => MockDocumentReference());

      // Çalıştırma
      final result = await firestoreOperation.addItem<TestModel>(
          path: path, item: testModel);

      // Doğrulama
      expect(result, isTrue);
      verify(mockCollection.add(testModel.toJson())).called(1);
    });

    test('docId sağlanırsa set metodu ile güncelleme yapılır', () async {
      // Hazırlık: path "testCollection/testDoc" olduğundan docId mevcut.
      final testModel = TestModel(id: '1', name: 'Test');
      const path = 'testCollection/testDoc';

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.set(testModel.toJson(), SetOptions(merge: true)))
          .thenAnswer((_) async => Future.value());

      // Çalıştırma
      final result = await firestoreOperation.addItem<TestModel>(
          path: path, item: testModel);

      // Doğrulama
      expect(result, isTrue);
      verify(
        mockDocRef.set(
          testModel.toJson(),
          argThat(isA<SetOptions>().having((opt) => opt.merge, 'merge', true)),
        ),
      ).called(1);
    });
  });

  group('addAllItem', () {
    test('path doküman içeriyorsa exception fırlatır', () async {
      // Doküman içeren path ile çağrılırsa hata beklenir.
      const path = 'testCollection/testDoc';
      final testModels = [TestModel(id: '1', name: 'Test')];

      expect(
        () async => await firestoreOperation.addAllItem<TestModel>(
            path: path, items: testModels),
        throwsA(isA<ModuleFirestoreException>()),
      );
    });

    test('batch operasyonu ile tüm elemanlar eklenir', () async {
      // Hazırlık: sadece koleksiyon içeren path
      const path = 'testCollection';
      final testModels = [
        TestModel(id: '1', name: 'Test1'),
        TestModel(id: '2', name: 'Test2'),
      ];

      final mockCollection = MockCollectionReference();
      final mockBatch = MockWriteBatch();

      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockFirestore.batch()).thenReturn(mockBatch);

      // Batch içindeki set işlemleri ve commit çağrısı simüle ediliyor.
      when(mockBatch.set(any, any)).thenReturn(null);
      when(mockBatch.commit()).thenAnswer((_) async => Future.value());

      // Çalıştırma
      final result = await firestoreOperation.addAllItem<TestModel>(
          path: path, items: testModels);

      // Doğrulama
      expect(result, isTrue);
      // Her bir item için batch.set çağrısı yapılmalı
      verify(mockBatch.set(any, any)).called(testModels.length);
      verify(mockBatch.commit()).called(1);
    });
  });

  group('deleteItem', () {
    test('key sağlanırsa dokümandaki alan silinir', () async {
      // Hazırlık: path "testCollection/testDoc", key mevcut.
      const path = 'testCollection/testDoc';
      const key = 'fieldToDelete';

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.update({key: FieldValue.delete()}))
          .thenAnswer((_) async => Future.value());

      // Çalıştırma
      final result = await firestoreOperation.deleteItem(path: path, key: key);

      // Doğrulama
      expect(result, isTrue);
      verify(mockDocRef.update({key: FieldValue.delete()})).called(1);
    });

    test('key yoksa tüm doküman silinir', () async {
      // Hazırlık: path "testCollection/testDoc", key null
      const path = 'testCollection/testDoc';

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.delete()).thenAnswer((_) async => Future.value());

      // Çalıştırma
      final result = await firestoreOperation.deleteItem(path: path);

      // Doğrulama
      expect(result, isTrue);
      verify(mockDocRef.delete()).called(1);
    });

    test('doküman yoksa koleksiyondaki tüm dokümanlar batch ile silinir',
        () async {
      // Hazırlık: path "testCollection" olduğundan tüm koleksiyon hedeflenir.
      const path = 'testCollection';

      final mockCollection = MockCollectionReference();
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockBatch = MockWriteBatch();
      // Koleksiyonda 1 adet doküman simüle ediliyor.
      final mockQueryDoc = MockQueryDocumentSnapshot();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc]);
      when(mockQueryDoc.reference).thenReturn(MockDocumentReference());
      when(mockFirestore.batch()).thenReturn(mockBatch);
      when(mockBatch.delete(any)).thenReturn(null);
      when(mockBatch.commit()).thenAnswer((_) async => Future.value());

      // Çalıştırma
      final result = await firestoreOperation.deleteItem(path: path);

      // Doğrulama
      expect(result, isTrue);
      verify(mockBatch.delete(any)).called(1);
      verify(mockBatch.commit()).called(1);
    });
  });

  group('getItem', () {
    test('doküman var ise model olarak döner', () async {
      // Hazırlık: path "testCollection/testDoc"
      const path = 'testCollection/testDoc';
      final testData = TestModel(id: '1', name: 'name');
      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      final testModelDocRef = TestModelDocRef();
      final testModelDocSnapshot = TestModelDocSnapshot();

      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);

      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.withConverter<TestModel>(
        fromFirestore: anyNamed('fromFirestore'),
        toFirestore: anyNamed('toFirestore'),
      )).thenReturn(testModelDocRef);
      when(testModelDocRef.get()).thenAnswer((_) async => testModelDocSnapshot);
      when(testModelDocSnapshot.exists).thenReturn(true);
      when(testModelDocSnapshot.data()).thenReturn(testData);

      // Çalıştırma
      final result = await firestoreOperation.getItem<TestModel>(
          path: path, model: TestModel.empty());

      // Doğrulama
      expect(result, isA<TestModel>());
      expect(result.id, equals('1'));
      expect(result.name, equals('name'));
    });

    test('docId olmadan çağrılırsa exception fırlatır', () async {
      // Hazırlık: path "testCollection" doküman id içermiyor.
      const path = 'testCollection';

      // Çalıştırma & Doğrulama
      expect(
          () async => await firestoreOperation.getItem<TestModel>(
              path: path, model: TestModel.empty()),
          throwsA(isA<ModuleFirestoreException>()));
    });
  });

  group('getItemsQuery', () {
    test('koleksiyondan model listesi döner', () async {
      // Hazırlık: path "testCollection"
      const path = 'testCollection';
      final testData1 = {'id': '1', 'name': 'Test1'};
      final testData2 = {'id': '2', 'name': 'Test2'};

      final mockCollection = MockCollectionReference();
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockQueryDoc1 = MockQueryDocumentSnapshot();
      final mockQueryDoc2 = MockQueryDocumentSnapshot();

      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc1, mockQueryDoc2]);
      when(mockQueryDoc1.data()).thenReturn(testData1);
      when(mockQueryDoc2.data()).thenReturn(testData2);

      // Çalıştırma
      final result = await firestoreOperation.getItemsQuery<TestModel>(
          path: path, model: TestModel.empty());

      // Doğrulama
      expect(result, isA<List<TestModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].id, equals('2'));
    });

    test('doküman id içeren path ile çağrılırsa exception fırlatır', () async {
      // Hazırlık: path "testCollection/testDoc"
      const path = 'testCollection/testDoc';

      expect(
          () async => await firestoreOperation.getItemsQuery<TestModel>(
              path: path, model: TestModel.empty()),
          throwsA(isA<ModuleFirestoreException>()));
    });
  });

  group('replaceItem', () {
    test('geçerli docId ve key ile doküman değiştirilir', () async {
      // Hazırlık: path "testCollection/testDoc", ayrıca key parametresi gerekli.
      const path = 'testCollection/testDoc';
      const key = 'testDocKey';
      final testModel = TestModel(id: '1', name: 'Replaced');
      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();

      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc(key)).thenReturn(mockDocRef);
      when(mockDocRef.set(testModel.toJson(), SetOptions(merge: false)))
          .thenAnswer((_) async => Future.value());

      // Çalıştırma
      final result = await firestoreOperation.replaceItem<TestModel>(
          path: path, item: testModel, key: key);

      // Doğrulama
      expect(result, isTrue);
      verify(mockDocRef.set(
        testModel.toJson(),
        argThat(isA<SetOptions>().having((opt) => opt.merge, 'merge', false)),
      )).called(1);
    });

    test('docId veya key eksikse exception fırlatır', () async {
      // Hazırlık: path "testCollection" doküman id içermiyor.
      const path = 'testCollection';
      final testModel = TestModel(id: '1', name: 'Replaced');

      expect(
        () async => await firestoreOperation.replaceItem<TestModel>(
            path: path, item: testModel, key: 'someKey'),
        throwsA(isA<ModuleFirestoreException>()),
      );
    });
  });

  group('update', () {
    test('verilen değerlerle doküman güncellenir', () async {
      // Hazırlık: path "testCollection/testDoc"
      const path = 'testCollection/testDoc';
      final updateData = {'name': 'Updated'};

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.update(updateData))
          .thenAnswer((_) async => Future.value());

      // Çalıştırma
      final result =
          await firestoreOperation.update(path: path, value: updateData);

      // Doğrulama
      expect(result, isTrue);
      verify(mockDocRef.update(updateData)).called(1);
    });

    test('docId içermeyen path ile çağrılırsa exception fırlatır', () async {
      // Hazırlık: path "testCollection" doküman id yok.
      const path = 'testCollection';
      final updateData = {'name': 'Updated'};

      expect(
          () async =>
              await firestoreOperation.update(path: path, value: updateData),
          throwsA(isA<ModuleFirestoreException>()));
    });
  });

  group('get stream', () {
    test('doküman streami doğru model ile döner', () async {
      const path = 'testCollection/testDoc';
      final testData = {'id': '1', 'name': 'Test'};

      final mockDocRef = MockDocumentReference();
      final mockDocSnapshot = MockDocumentSnapshot();

      when(mockFirestore.doc(path)).thenReturn(mockDocRef);
      when(mockDocRef.snapshots())
          .thenAnswer((_) => Stream.value(mockDocSnapshot));
      when(mockDocSnapshot.data()).thenReturn(testData);

      final stream = firestoreOperation.streamDocument<TestModel>(
          docPath: path, model: TestModel.empty());
      final result = await stream.first;

      expect(result, isA<TestModel>());
      expect(result.id, equals('1'));
      expect(result.name, equals('Test'));
    });

    test('koleksiyon stream i doğru model listesi ile döner', () async {
      const path = 'testCollection';
      final testData1 = {'id': '1', 'name': 'Test1'};
      final testData2 = {'id': '2', 'name': 'Test2'};

      final mockCollection = MockCollectionReference();
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockQueryDoc1 = MockQueryDocumentSnapshot();
      final mockQueryDoc2 = MockQueryDocumentSnapshot();

      when(mockFirestore.collection(path)).thenReturn(mockCollection);
      when(mockCollection.snapshots())
          .thenAnswer((_) => Stream.value(mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc1, mockQueryDoc2]);
      when(mockQueryDoc1.data()).thenReturn(testData1);
      when(mockQueryDoc2.data()).thenReturn(testData2);

      final stream = firestoreOperation.streamCollection<TestModel>(
          collectionPath: path, model: TestModel.empty());
      final result = await stream.first;

      expect(result, isA<List<TestModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].name, equals('Test2'));
    });
  });
}
