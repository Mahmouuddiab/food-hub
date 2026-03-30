// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i408.DioHelper>(() => _i408.DioHelper());
    gh.factory<_i520.HomeRemoteDs>(() => _i740.HomeRemoteDsImpl());
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
    gh.factory<_i9.HomeCubit>(
      () => _i9.HomeCubit(
        gh<_i390.GetCategoryUseCase>(),
        gh<_i268.GetRecipeUseCase>(),
        gh<_i386.GetMealsUseCase>(),
      ),
    );
    return this;
  }
}
