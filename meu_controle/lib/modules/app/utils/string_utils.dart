import 'package:uuid/uuid.dart';

class StringUtils {
  static String generateUUID() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  bool isEmptyOrNull(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
