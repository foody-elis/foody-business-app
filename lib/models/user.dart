import 'package:foody_api_client/utils/roles.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  int id = 0;

  String jwt;
  int? restaurantId;

  @Transient()
  late Role role;
  String get dbRole => role.name;
  set dbRole(String value) => role = Role.values.byName(value);

  User({required this.jwt, this.restaurantId, String? role}) {
    dbRole = role ?? Role.CUSTOMER.name;
  }
}
