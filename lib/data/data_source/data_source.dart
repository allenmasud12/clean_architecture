import 'package:clean_architecture/data/network/app_api.dart';
import 'package:clean_architecture/data/request/request.dart';

import '../response/response.dart';


abstract class RemoteDataSource{
 Future<AuthenticationResponse> login(LoginRequest loginRequest);
 Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourceImplementer implements RemoteDataSource{
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }


  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest)async {
   return await _appServiceClient.login(
     loginRequest.email, loginRequest.password, loginRequest.imei, loginRequest.deviceType
   );
  }

}