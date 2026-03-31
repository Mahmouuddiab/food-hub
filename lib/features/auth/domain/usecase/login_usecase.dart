import 'package:food_hub/features/auth/domain/entity/user_entity.dart';
import 'package:food_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  Future<UserEntity> call(String email, String password) =>
      repository.login(email, password);
}
