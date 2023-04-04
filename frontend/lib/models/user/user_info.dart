import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:voluntracker/models/user/user_model.dart';

import '../auth/tokens_model.dart';

class UserInfo {
  static UserModel? loggedUser;
  static Tokens? tokens;
  static LatLng? currentLatLng;
}
