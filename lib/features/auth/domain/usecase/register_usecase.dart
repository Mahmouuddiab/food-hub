import 'package:food_hub/features/auth/domain/entity/user_entity.dart';
import 'package:food_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);
  Future<UserEntity> call(String name, String email, String password) =>
      repository.register(name, email, password);
}
