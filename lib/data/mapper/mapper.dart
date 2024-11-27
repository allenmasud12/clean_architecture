

import 'package:clean_architecture/app/extension.dart';

import '../../domain/model/model.dart';
import '../response/response.dart';

/// to convert response into a non nullable object (model)

const EMPTY = "";
const ZERO = 0;

extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(this?.id?.orEmpty() ?? EMPTY, this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotification?.orZero() ?? ZERO);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(this?.email.orEmpty() ?? EMPTY,
        this?.phone?.orEmpty() ?? EMPTY, this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain(){
    return Authentication(this?.user?.toDomain(), this?.contact?.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? EMPTY;
  }
}