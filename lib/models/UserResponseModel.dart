class UserLoginResponseModel {
  int? id;
  String? name;
  String? email;
  String? profilePictureUrl;
  bool? emailVerified;
  String? accessToken;
  String? lastRequestDateTime;
  String? currentOrgName;
  int? currentOrgId;
  String? currentOrgType;
  String? loginType;
  bool? forcePasswordReset;
  String? resetPasswordToken;
  String? lastLogin;

  UserLoginResponseModel(
      {this.id,
      this.name,
      this.email,
      this.profilePictureUrl,
      this.emailVerified,
      this.accessToken,
      this.lastRequestDateTime,
      this.currentOrgName,
      this.currentOrgId,
      this.currentOrgType,
      this.loginType,
      this.forcePasswordReset,
      this.resetPasswordToken,
      this.lastLogin});

  UserLoginResponseModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profilePictureUrl = json['profilePictureUrl'];
    accessToken = json['accessToken'];
    lastRequestDateTime = json['lastRequestDateTime'];
    currentOrgName = json['currentOrgName'];
    if (json['currentOrgId'] != null) {
      currentOrgId = json['currentOrgId'].toInt();
    }
    currentOrgType = json['currentOrgType'];
    loginType = json['loginType'];
    forcePasswordReset = json['forcePasswordReset'];
    resetPasswordToken = json['resetPasswordToken'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name ?? '';
    data['email'] = email;
    data['profilePictureUrl'] = profilePictureUrl;
    data['emailVerified'] = emailVerified;
    data['accessToken'] = accessToken;
    data['lastRequestDateTime'] = lastRequestDateTime;
    data['currentOrgName'] = currentOrgName;
    data['currentOrgId'] = currentOrgId;
    data['currentOrgType'] = currentOrgType;
    data['loginType'] = loginType;
    data['forcePasswordReset'] = forcePasswordReset;
    data['resetPasswordToken'] = resetPasswordToken;
    data['lastLogin'] = lastLogin;
    return data;
  }
}
