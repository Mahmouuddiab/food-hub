import 'package:food_hub/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:food_hub/features/auth/domain/entity/user_entity.dart';
import 'package:food_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);
  @override
  UserEntity? getCurrentUser() {
    final result =  remote.getCurrentUser();
    return result ;
  }

  @override
  Future<UserEntity> login(String email, String password) async{
    final result = await remote.login(email, password);
    return result ;
  }

  @override
  Future<void> logout() async{
    final result = await remote.logout();
    return result;
  }

  @override
  Future<UserEntity> register(String name, String email, String password) async{
    final result = await remote.register(name, email, password);
    return result ;
  }

}