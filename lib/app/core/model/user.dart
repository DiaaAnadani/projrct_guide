// class User {
//   Account? account;

//   User({this.account});

//   User.fromJson(Map<String, dynamic> json) {
//     account =
//         json['account'] != null ? Account.fromJson(json['account']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  <String, dynamic>{};
//     if (account != null) {
//       data['account'] = account!.toJson();
//     }
//     return data;
//   }
// }

// class Account {
//   String? email;
//   String? userName;
//   String? devicedId;
//   String? userType;
//   String? updatedAt;
//   String? createdAt;
//   String? id;
//   String? token;

//   Account(
//       {this.email,
//       this.userName,
//       this.devicedId,
//       this.userType,
//       this.updatedAt,
//       this.createdAt,
//       this.id,
//       this.token});

//   Account.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     userName = json['userName'];
//     devicedId = json['devicedId'];
//     userType = json['userType'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//     token = json['token'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = email;
//     data['userName'] = userName;
//     data['devicedId'] = devicedId;
//     data['userType'] = userType;
//     data['updated_at'] = updatedAt;
//     data['created_at'] = createdAt;
//     data['id'] = id;
//     data['token'] =token;
//     return data;
//   }
// }