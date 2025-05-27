import 'package:sapiensshifter/product/component/basic_list_tile/model/basic_list_tile_model.dart';
import 'package:sapiensshifter/product/utils/enums/user_role.dart';

class BasicRoleTileModel extends BasicListTileModel {
  BasicRoleTileModel({
    required this.roles,
    required super.icon,
    required super.title,
    required super.onTap,
  });
  final List<UserRole> roles;
  bool isVisibleTo(UserRole role) => roles.contains(role);
}
