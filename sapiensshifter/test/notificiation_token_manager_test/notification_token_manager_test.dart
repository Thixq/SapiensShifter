import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sapiensshifter/core/init/app_config/product_configure_items.dart';
// Projenizdeki doğru import yollarını kullandığınızdan emin olun
import 'package:sapiensshifter/core/notification/notification_token_manager/notification_token_manager.dart';
import 'package:sapiensshifter/product/models/notification_device_model.dart/notification_device_model.dart';

// Bu sınıfların mock'lanması gerektiğini varsayıyorum.
// Gerekmiyorsa GenerateUuidDeviceId'ı kaldırabilirsiniz.
@GenerateNiceMocks([
  MockSpec<INetworkManager>(),
  MockSpec<ILocalCacheManager>(),
  MockSpec<ILocalCacheOperation>(),
  MockSpec<INetworkOperation>(),
])
import 'notification_token_manager_test.mocks.dart';

void main() {
  late final NotificationTokenManager notificationTokenManager;
  late final MockINetworkManager mockNetwork;

  late final MockINetworkOperation mockNetworkOperation;

  setUp(() {
    mockNetwork = MockINetworkManager();
    mockNetworkOperation = MockINetworkOperation();

    when(mockNetwork.networkOperation).thenReturn(mockNetworkOperation);

    notificationTokenManager = NotificationTokenManager(
      networkManager: mockNetwork,
      profile: ProductConfigureItems.profile,
    );
  });

  group('deviceCheck', () {
    test(
      'when device is found, should return true',
      () async {
        when(
          mockNetworkOperation.getItem<NotificationDeviceModel>(
            path: anyNamed('path'),
            model: NotificationDeviceModel(),
          ),
        ).thenAnswer((_) async => NotificationDeviceModel());

        final result = await notificationTokenManager.deviceCheck();

        expect(result, isTrue);

        verifyNever(
          mockNetworkOperation.addItem<NotificationDeviceModel>(
            path: anyNamed('path'),
            item: NotificationDeviceModel(),
          ),
        );
      },
    );

    test(
      'when device is NOT found, should create a new device and return false',
      () async {
        when(
          mockNetworkOperation.getItem<NotificationDeviceModel>(
            path: anyNamed('path'),
            model: NotificationDeviceModel(),
          ),
        ).thenThrow(Exception('Device not found!'));

        when(
          mockNetworkOperation.addItem<NotificationDeviceModel>(
            path: anyNamed('path'),
            item: anyNamed('item'),
          ),
        ).thenAnswer(
          (realInvocation) async => true,
        );
        final result = await notificationTokenManager.deviceCheck();

        expect(result, isFalse);
      },
    );
  });
}
