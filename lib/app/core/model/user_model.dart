
import 'package:hive/hive.dart';

part 'user_model.g.dart';
@HiveType(typeId: 0)
class User {
   @HiveField(0)
    int id;
     @HiveField(1)
    String fullName;
     @HiveField(2)
    int regionId;
     @HiveField(3)
    int streetId;
     @HiveField(4)
    String deviceId;
  @HiveField(5)
    String gender; 
      @HiveField(6)
    String email; 

    User({
        required this.id,
        required this.fullName,
        required this.gender,
        required this.regionId,
        required this.streetId,
        required this.deviceId,
        required this.email,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["fullName"],
         email: json["email"],
        gender: json["gender"],
        regionId: json["regionId"],
        streetId: json["streetId"],
        deviceId: json["deviceId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "email":email,
        "gender": gender,
        "regionId": regionId,
        "streetId": streetId,
        "deviceId": deviceId,
    };
}
