import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_storage_module/src/firebase_storage_operation.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseStorage>(),
  MockSpec<Reference>(),
  MockSpec<SettableMetadata>(),
  MockSpec<FullMetadata>(),
  MockSpec<ListResult>(),
  MockSpec<TaskSnapshot>(),
  MockSpec<UploadTask>(),
])
import 'firebase_storage_module_test.mocks.dart';

void main() {
  late final MockFirebaseStorage mockStorage;
  late final FirebaseStorageOperation mockInstance;
  late final MockReference mockRef;
  late final MockUploadTask mockUploadTask;
  late final MockListResult mockListResult;
  late final MockFullMetadata mockFullMetadata;

  setUpAll(() {
    mockStorage = MockFirebaseStorage();
    mockRef = MockReference();
    mockUploadTask = MockUploadTask();

    mockFullMetadata = MockFullMetadata();
    mockListResult = MockListResult();
    mockInstance = FirebaseStorageOperation.instanceFor(mockStorage);
  });

  group('upload', () {
    test('upload byte file', () async {
      final byteData = Uint8List.fromList([1, 2, 3]);
      final path = 'folder/file.txt';
      final mimeType = 'text/plain';

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(path)).thenReturn(mockRef);
      when(mockRef.putData(any, any)).thenAnswer((_) => mockUploadTask);
      when(
        mockRef.getDownloadURL(),
      ).thenAnswer((_) async => 'http://download.url');

      final downloadUrl = await mockInstance.upload(
        byteFile: byteData,
        path: path,
        mimeType: mimeType,
      );
      expect(downloadUrl, 'http://download.url');
    });

    test('upload file', () async {
      final path = 'folder/file.txt';
      final mimeType = 'text/plain';
      final file = File(path);

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(path)).thenReturn(mockRef);
      when(mockRef.putFile(any, any)).thenAnswer((_) => mockUploadTask);
      when(
        mockRef.getDownloadURL(),
      ).thenAnswer((_) async => 'http://download.url');

      final downloadUrl = await mockInstance.upload(
        file: file,
        path: path,
        mimeType: mimeType,
      );
      expect(downloadUrl, 'http://download.url');
    });
  });

  group('download', () {
    test('download data', () async {
      final path = "http://download.url";
      final file = Uint8List.fromList([1, 2, 3]);

      final mockRef = MockReference();

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(path)).thenReturn(mockRef);
      when(mockRef.getData()).thenAnswer((realInvocation) async => file);

      final result = await mockInstance.download(path: path);

      expect(result, file);
    });
  });

  group('file operations', () {
    test('delete item', () async {
      const path = 'delete/this/file.jpg';

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(path)).thenReturn(mockRef);
      when(mockRef.delete()).thenAnswer((_) async => Future.value());

      await mockInstance.deleteFile(path);

      verify(mockRef.delete()).called(1);
    });

    test('retrieving the file\'s metadata', () async {
      const path = 'folder/bla.png';
      final now = DateTime.now();

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(path)).thenReturn(mockRef);
      when(mockRef.getMetadata()).thenAnswer((_) async {
        when(mockFullMetadata.size).thenReturn(1234);
        when(mockFullMetadata.contentType).thenReturn('text/plain');
        when(mockFullMetadata.timeCreated).thenReturn(now);
        when(mockFullMetadata.updated).thenReturn(now);
        return mockFullMetadata;
      });
      final result = await mockInstance.getMetadata(path);

      expect(result.path, path);
      expect(result.size, 1234);
      expect(result.mimeType, 'text/plain');
      expect(result.createdAt, now);
      expect(result.updatedAt, now);
    });

    test('Retrieve all files and subfiles in a specified directory', () async {
      const path = '/folder/';

      final mockItem1 = MockReference();
      final mockItem2 = MockReference();
      final mockPrefix1 = MockReference();

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(path)).thenReturn(mockRef);
      when(mockRef.listAll()).thenAnswer((_) async => mockListResult);

      when(mockListResult.items).thenReturn([mockItem1, mockItem2]);
      when(mockListResult.prefixes).thenReturn([mockPrefix1]);

      when(mockItem1.fullPath).thenReturn('folder/bla.png');
      when(mockItem2.fullPath).thenReturn('folder/blabla.png');
      when(mockPrefix1.fullPath).thenReturn('folder/subfolder/');

      final files = await mockInstance.listFiles(path: path, recursive: false);
      expect(files, ['folder/bla.png', 'folder/blabla.png']);

      // recursive = true
      final filesRecursive = await mockInstance.listFiles(
        path: path,
        recursive: true,
      );
      expect(filesRecursive, [
        'folder/bla.png',
        'folder/blabla.png',
        'folder/subfolder/',
      ]);
    });

    test('file transfer', () async {
      const oldPath = 'old/text.txt';
      const newPath = 'new/text.txt';

      final oldRef = MockReference();
      final newRef = MockReference();
      final data = Uint8List.fromList([1, 2, 3]);
      final metadata = MockFullMetadata();
      final mockUpload = MockUploadTask();

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(oldPath)).thenReturn(oldRef);
      when(mockRef.child(newPath)).thenReturn(newRef);

      when(oldRef.getData()).thenAnswer((_) async => data);
      when(oldRef.getMetadata()).thenAnswer((_) async => metadata);
      when(metadata.contentType).thenReturn('text/plain');

      when(newRef.putData(any, any)).thenAnswer((_) => mockUpload);
      when(oldRef.delete()).thenAnswer((_) async {});
      when(
        newRef.getDownloadURL(),
      ).thenAnswer((_) async => 'https://newpath.com/file.txt');

      await mockInstance.moveFile(oldPath: oldPath, newPath: newPath);

      verify(oldRef.getData()).called(1);
      verify(oldRef.getMetadata()).called(1);
      verify(newRef.putData(any, any)).called(1);
      verify(oldRef.delete()).called(1);
    });

    test('file copy', () async {
      const scourePath = 'scoure/text.txt';
      const destinationPath = 'destination/text.txt';

      final scoureRef = MockReference();
      final destinationRef = MockReference();
      final scoureData = Uint8List.fromList([1, 2, 3]);
      final scoureMetadata = MockFullMetadata();
      final destinationUpload = MockUploadTask();

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(scourePath)).thenReturn(scoureRef);
      when(mockRef.child(destinationPath)).thenReturn(destinationRef);

      when(scoureRef.getData()).thenAnswer((_) async => scoureData);
      when(scoureRef.getMetadata()).thenAnswer((_) async => scoureMetadata);
      when(scoureMetadata.contentType).thenReturn('text/plain');
      when(
        destinationRef.putData(any, any),
      ).thenAnswer((_) => destinationUpload);

      await mockInstance.copyFile(
        sourcePath: scourePath,
        destinationPath: destinationPath,
      );

      verify(scoureRef.getData()).called(1);
      verify(scoureRef.getMetadata()).called(1);
      verify(destinationRef.putData(any, any)).called(1);
    });

    test('should delete all files and subfolders under given path', () async {
      const path = 'folder/';
      final fileRef1 = MockReference();
      final fileRef2 = MockReference();
      final subfolderRef = MockReference();
      final mockItem1 = MockReference();
      final mockItem2 = MockReference();
      final mockPrefix = MockReference();

      when(mockStorage.ref()).thenReturn(mockRef);
      when(mockRef.child(path)).thenReturn(mockRef);

      final mockListResult = MockListResult();
      when(mockRef.listAll()).thenAnswer((_) async => mockListResult);
      when(mockListResult.items).thenReturn([mockItem1, mockItem2]);
      when(mockListResult.prefixes).thenReturn([mockPrefix]);

      when(mockItem1.fullPath).thenReturn('folder/file1.txt');
      when(mockItem2.fullPath).thenReturn('folder/file2.txt');
      when(mockPrefix.fullPath).thenReturn('folder/subfolder/');

      when(mockRef.child('folder/file1.txt')).thenReturn(fileRef1);
      when(mockRef.child('folder/file2.txt')).thenReturn(fileRef2);
      when(mockRef.child('folder/subfolder/')).thenReturn(subfolderRef);

      when(fileRef1.delete()).thenAnswer((_) async {});
      when(fileRef2.delete()).thenAnswer((_) async {});
      when(subfolderRef.delete()).thenAnswer((_) async {});

      await mockInstance.clear(path: path);

      verify(fileRef1.delete()).called(1);
      verify(fileRef2.delete()).called(1);
      verify(subfolderRef.delete()).called(1);
    });
  });
}
