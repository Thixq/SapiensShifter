// firebase_firestore_operation_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'localization_config/l10n_prodiver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_firestore_module/firebase_firestore_module.dart';
import 'package:core/core.dart';
import 'package:firebase_firestore_module/src/exception/module_firestore_exception.dart';

// Generate mock objects for Firestore and related classes using @GenerateNiceMocks
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

// Simple model for tests
class TestModel extends IBaseModel<TestModel> {
  final String name;

  const TestModel({required super.id, required this.name});

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
    test('calls add method when adding new document (without docId)', () async {
      final testModel = TestModel(id: '1', name: 'Test');
      const path = 'testCollection';

      final mockCollection = MockCollectionReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.add(testModel.toJson()))
          .thenAnswer((_) async => MockDocumentReference());

      final result = await firestoreOperation.addItem<TestModel>(
          path: path, item: testModel);

      expect(result, isTrue);
      verify(mockCollection.add(testModel.toJson())).called(1);
    });

    test('updates with set method when docId is provided', () async {
      final testModel = TestModel(id: '1', name: 'Test');
      const path = 'testCollection/testDoc';

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.set(testModel.toJson(), SetOptions(merge: true)))
          .thenAnswer((_) async => Future.value());

      final result = await firestoreOperation.addItem<TestModel>(
          path: path, item: testModel);

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
    test('throws exception if path contains document reference', () async {
      const path = 'testCollection/testDoc';
      final testModels = [TestModel(id: '1', name: 'Test')];

      expect(
        () async => await firestoreOperation.addAllItem<TestModel>(
            path: path, items: testModels),
        throwsA(isA<ModuleFirestoreException>()),
      );
    });

    test('adds all items using batch operation', () async {
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
      when(mockBatch.set(any, any)).thenReturn(null);
      when(mockBatch.commit()).thenAnswer((_) async => Future.value());

      final result = await firestoreOperation.addAllItem<TestModel>(
          path: path, items: testModels);

      expect(result, isTrue);
      verify(mockBatch.set(any, any)).called(testModels.length);
      verify(mockBatch.commit()).called(1);
    });
  });

  group('deleteItem', () {
    test('deletes field from document when key is provided', () async {
      const path = 'testCollection/testDoc';
      const key = 'fieldToDelete';

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.update({key: FieldValue.delete()}))
          .thenAnswer((_) async => Future.value());

      final result = await firestoreOperation.deleteItem(path: path, key: key);

      expect(result, isTrue);
      verify(mockDocRef.update({key: FieldValue.delete()})).called(1);
    });

    test('deletes entire document when no key is provided', () async {
      const path = 'testCollection/testDoc';

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.delete()).thenAnswer((_) async => Future.value());

      final result = await firestoreOperation.deleteItem(path: path);

      expect(result, isTrue);
      verify(mockDocRef.delete()).called(1);
    });

    test('deletes all documents in collection using batch when no docId',
        () async {
      const path = 'testCollection';

      final mockCollection = MockCollectionReference();
      final mockQuerySnapshot = MockQuerySnapshot();
      final mockBatch = MockWriteBatch();
      final mockQueryDoc = MockQueryDocumentSnapshot();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc]);
      when(mockQueryDoc.reference).thenReturn(MockDocumentReference());
      when(mockFirestore.batch()).thenReturn(mockBatch);
      when(mockBatch.delete(any)).thenReturn(null);
      when(mockBatch.commit()).thenAnswer((_) async => Future.value());

      final result = await firestoreOperation.deleteItem(path: path);

      expect(result, isTrue);
      verify(mockBatch.delete(any)).called(1);
      verify(mockBatch.commit()).called(1);
    });
  });

  group('getItem', () {
    test('returns model if document exists', () async {
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

      final result = await firestoreOperation.getItem<TestModel>(
          path: path, model: TestModel.empty());

      expect(result, isA<TestModel>());
      expect(result.id, equals('1'));
      expect(result.name, equals('name'));
    });

    test('throws exception when called without docId', () async {
      const path = 'testCollection';

      expect(
          () async => await firestoreOperation.getItem<TestModel>(
              path: path, model: TestModel.empty()),
          throwsA(isA<ModuleFirestoreException>()));
    });
  });

  group('getItemsQuery', () {
    test('returns model list from collection', () async {
      const path = '/testCollection';
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

      final result = await firestoreOperation.getItemsQuery<TestModel>(
          path: path, model: TestModel.empty());

      expect(result, isA<List<TestModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].id, equals('2'));
    });

    test('throws exception when path contains document ID', () async {
      const path = 'testCollection/testDoc';

      expect(
          () async => await firestoreOperation.getItemsQuery<TestModel>(
              path: path, model: TestModel.empty()),
          throwsA(isA<ModuleFirestoreException>()));
    });

    test(
      'fetches data from subcollection',
      () async {
        const path = 'testCollection/testDoc/testSubCollection';
        final testData1 = {'id': '1', 'name': 'Test1'};
        final testData2 = {'id': '2', 'name': 'Test2'};

        final mockCollection = MockCollectionReference();
        final mockQuerySnapshot = MockQuerySnapshot();
        final mockQueryDoc1 = MockQueryDocumentSnapshot();
        final mockQueryDoc2 = MockQueryDocumentSnapshot();

        when(mockFirestore
                .collection('testCollection/testDoc/testSubCollection'))
            .thenReturn(mockCollection);
        when(mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);
        when(mockQuerySnapshot.docs).thenReturn([mockQueryDoc1, mockQueryDoc2]);
        when(mockQueryDoc1.data()).thenReturn(testData1);
        when(mockQueryDoc2.data()).thenReturn(testData2);

        final result = await firestoreOperation.getItemsQuery<TestModel>(
            path: path, model: TestModel.empty());

        expect(result, isA<List<TestModel>>());
        expect(result.length, equals(2));
        expect(result[0].id, equals('1'));
        expect(result[1].id, equals('2'));
      },
    );
  });

  group('replaceItem', () {
    test('replaces document with valid docId and key', () async {
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

      final result = await firestoreOperation.replaceItem<TestModel>(
          path: path, item: testModel, key: key);

      expect(result, isTrue);
      verify(mockDocRef.set(
        testModel.toJson(),
        argThat(isA<SetOptions>().having((opt) => opt.merge, 'merge', false)),
      )).called(1);
    });

    test('throws exception when missing docId or key', () async {
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
    test('updates document with provided values', () async {
      const path = 'testCollection/testDoc';
      final updateData = {'name': 'Updated'};

      final mockCollection = MockCollectionReference();
      final mockDocRef = MockDocumentReference();
      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('testDoc')).thenReturn(mockDocRef);
      when(mockDocRef.update(updateData))
          .thenAnswer((_) async => Future.value());

      final result =
          await firestoreOperation.update(path: path, value: updateData);

      expect(result, isTrue);
      verify(mockDocRef.update(updateData)).called(1);
    });

    test('throws exception when path lacks document ID', () async {
      const path = 'testCollection';
      final updateData = {'name': 'Updated'};

      expect(
          () async =>
              await firestoreOperation.update(path: path, value: updateData),
          throwsA(isA<ModuleFirestoreException>()));
    });

    test('updateAll', () async {
      const path = 'testCollection';
      final testModels = [
        TestModel(id: '1', name: 'Updated1'),
        TestModel(id: '2', name: 'Updated2')
      ];

      final mockCollection = MockCollectionReference();
      final mockDocRef1 = MockDocumentReference();
      final mockDocRef2 = MockDocumentReference();
      final mockBatch = MockWriteBatch();

      when(mockFirestore.collection('testCollection'))
          .thenReturn(mockCollection);
      when(mockCollection.doc('1')).thenReturn(mockDocRef1);
      when(mockCollection.doc('2')).thenReturn(mockDocRef2);
      when(mockDocRef1.update(testModels[0].toJson()))
          .thenAnswer((_) async => Future.value());
      when(mockDocRef2.update(testModels[1].toJson()))
          .thenAnswer((_) async => Future.value());
      when(mockFirestore.batch()).thenReturn(mockBatch);
      when(mockBatch.update(any, any)).thenReturn(null);
      when(mockBatch.commit()).thenAnswer((_) async => Future.value());

      final result =
          await firestoreOperation.updateAll(items: testModels, path: path);
      expect(result, true);
    });
    test('updateAll wrong path', () async {
      const path = 'testCollection/bla';
      final testModels = [
        TestModel(id: '1', name: 'Updated1'),
        TestModel(id: '2', name: 'Updated2')
      ];
      expect(
          () async =>
              await firestoreOperation.updateAll(items: testModels, path: path),
          throwsA(isA<ModuleFirestoreException>()));
    });
  });

  group('stream operations', () {
    test('document stream returns correct model', () async {
      const path = 'testCollection/testDoc';
      final testData = {'id': '1', 'name': 'Test'};

      final mockDocRef = MockDocumentReference();
      final mockDocSnapshot = MockDocumentSnapshot();

      when(mockFirestore.doc(path)).thenReturn(mockDocRef);
      when(mockDocRef.snapshots())
          .thenAnswer((_) => Stream.value(mockDocSnapshot));
      when(mockDocSnapshot.data()).thenReturn(testData);

      final stream = firestoreOperation.getStream<TestModel>(
          path: path, model: TestModel.empty());
      final result = await stream.first;

      expect(result, isA<TestModel>());
      expect(result.id, equals('1'));
      expect(result.name, equals('Test'));
    });

    test('collection stream returns correct model list', () async {
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

      final stream = firestoreOperation.getStreamQuery<TestModel>(
          path: path, model: TestModel.empty());
      final result = await stream.first;

      expect(result, isA<List<TestModel>>());
      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].name, equals('Test2'));
    });
  });
}
