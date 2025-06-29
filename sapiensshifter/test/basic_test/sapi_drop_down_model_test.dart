import 'package:flutter_test/flutter_test.dart';
import 'package:sapiensshifter/product/component/sapi_custom_drop_down/model/sapi_drop_down_model.dart';

void main() {
  test(
    'equitable',
    () {
      const query = SapiDropDownModel(displayName: 'elma', value: 'elmaId');

      final itemList = <SapiDropDownModel<String>>[
        const SapiDropDownModel(displayName: 'elma', value: 'elmaId'),
        const SapiDropDownModel(displayName: 'aurmut', value: 'armutId'),
      ];

      final queryItems = itemList.any(
        (element) => element == query,
      );

      expect(queryItems, true);
    },
  );
}
