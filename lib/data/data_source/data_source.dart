import 'package:clean_architecture/data/network/app_api.dart';
import 'package:clean_architecture/data/request/request.dart';

import '../response/response.dart';


abstract class RemoteDataSource{
 Future<AuthenticationResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource{
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest)async {
   return await _appServiceClient.login(
     loginRequest.email, loginRequest.password, loginRequest.imei, loginRequest.deviceType
   );
  }

}