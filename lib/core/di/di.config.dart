// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data%20source/auth_remote_ds.dart' as _i6;
import '../../features/auth/data/data%20source/auth_remote_ds_impl.dart'
    as _i624;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i409;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecase/current_user_usecase.dart' as _i67;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/logout_usecase.dart' as _i757;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../../features/home/data/data%20source/home_remote_ds.dart' as _i520;
import '../../features/home/data/data%20source/home_remote_ds_impl.dart'
    as _i740;
import '../../features/home/data/repository/home_repository_impl.dart' as _i9;
import '../../features/home/domain/repository/home_repository.dart' as _i541;
import '../../features/home/domain/usecase/get_category_usecase.dart' as _i390;
import '../../features/home/domain/usecase/get_meals_usecase.dart' as _i386;
import '../../features/home/domain/usecase/get_recipe_usecase.dart' as _i268;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../helper/dio_helper.dart' as _i408;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i408.DioHelper>(() => _i408.DioHelper());
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.factory<_i520.HomeRemoteDs>(() => _i740.HomeRemoteDsImpl());
    gh.lazySingleton<_i6.AuthRemoteDataSource>(
      () => _i624.AuthRemoteDsImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.factory<_i541.HomeRepository>(
      () => _i9.HomeRepositoryImpl(gh<_i520.HomeRemoteDs>()),
    );
    gh.factory<_i390.GetCategoryUseCase>(
      () => _i390.GetCategoryUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i386.GetMealsUseCase>(
      () => _i386.GetMealsUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i268.GetRecipeUseCase>(
      () => _i268.GetRecipeUseCase(gh<_i541.HomeRepository>()),
    );
    gh.factory<_i961.AuthRepository>(
      () => _i409.AuthRepositoryImpl(gh<_i6.AuthRemoteDataSource>()),
    );
    gh.factory<_i9.HomeCubit>(
      () => _i9.HomeCubit(
        gh<_i390.GetCategoryUseCase>(),
        gh<_i268.GetRecipeUseCase>(),
        gh<_i386.GetMealsUseCase>(),
      ),
    );
    gh.factory<_i67.CurrentUserUseCase>(
      () => _i67.CurrentUserUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i911.LoginUseCase>(
      () => _i911.LoginUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i757.LogoutUseCase>(
      () => _i757.LogoutUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i769.RegisterUseCase>(
      () => _i769.RegisterUseCase(gh<_i961.AuthRepository>()),
    );
    gh.factory<_i117.AuthCubit>(
      () => _i117.AuthCubit(
        loginUseCase: gh<_i911.LoginUseCase>(),
        registerUseCase: gh<_i769.RegisterUseCase>(),
        logoutUseCase: gh<_i757.LogoutUseCase>(),
        currentUserUseCase: gh<_i67.CurrentUserUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i946.RegisterModule {}
