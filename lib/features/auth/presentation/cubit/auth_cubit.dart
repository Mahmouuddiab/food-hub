import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/features/auth/domain/usecase/current_user_usecase.dart';
import 'package:food_hub/features/auth/domain/usecase/login_usecase.dart';
import 'package:food_hub/features/auth/domain/usecase/logout_usecase.dart';
import 'package:food_hub/features/auth/domain/usecase/register_usecase.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final CurrentUserUseCase currentUserUseCase;
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.currentUserUseCase
  }) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase(email,password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase(name,email,password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await logoutUseCase();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void loadCurrentUser() {
    final user = currentUserUseCase();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthInitial());
    }
  }


}
