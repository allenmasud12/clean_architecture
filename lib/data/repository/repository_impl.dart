import 'package:clean_architecture/app/extension.dart';
import 'package:clean_architecture/data/data_source/data_source.dart';
import 'package:clean_architecture/data/mapper/mapper.dart';
import 'package:clean_architecture/data/network/failure.dart';
import 'package:clean_architecture/data/network/network_info.dart';
import 'package:clean_architecture/data/request/request.dart';
import 'package:clean_architecture/domain/model.dart';
import 'package:clean_architecture/domain/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository{
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){
      //its safe to call API
      final response = await _remoteDataSource.login(loginRequest);
      if(response.status == 0){
      return Right(response.toDomain());
      }else{
      return Left(Failure(409, response.message ?? "error!"));
      }
    }else{
      //connection error
      return Left(Failure(501, "Please check your internet Connection."));
    }
  }

}