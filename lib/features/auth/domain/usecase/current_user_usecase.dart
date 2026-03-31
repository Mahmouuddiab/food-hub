import 'package:food_hub/features/auth/domain/entity/user_entity.dart';
import 'package:food_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CurrentUserUseCase {
  final AuthRepository repository;
  CurrentUserUseCase(this.repository);
  UserEntity? call()=> repository.getCurrentUser();
}