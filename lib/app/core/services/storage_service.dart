import 'package:hive_flutter/hive_flutter.dart';

import '../model/region_model.dart';
import '../model/user_model.dart';

class StoragesService {
  Box<User> userBox = Hive.box<User>("userBox");
  Box<Region> regionBox = Hive.box<Region> ("regionBox");
//insert user
  Future<void> setUser(User user) async {
    await userBox.put("appUser", user);
  }

//delete user
  Future<void> deleteUser() async {
    await userBox.delete("appUser");
  }

//select user
  User? getUser() {
    User? user = userBox.get("appUser");
    return user;
  }
// List<Region>? getRegion()  {
//    Region? listRegion=regionBox.get("appRegion");
//   // List<Region>? listRegion=regionBox.
//     return listRegion;
//   }
 List<Region> getRegions() {
    return regionBox.values.toList();
  }

   Future<void> setRegion(List<Region>? regionList) async {
    await regionBox.addAll(regionList!);
  }


    Future<void> deleteRegion() async {
    await regionBox.delete("appRegion");
  }

//init database
  static Future<void> openStorage() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
     Hive.registerAdapter(RegionAdapter());
    await Hive.openBox<User>("userBox");
    await Hive.openBox<Region>("regionBox");
    // await StoragesService().deleteUser();
    //     await StoragesService().deleteRegion();
  }
}
