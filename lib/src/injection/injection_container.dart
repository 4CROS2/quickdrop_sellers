import 'package:get_it/get_it.dart';
import 'package:quickdrop_sellers/src/data/datasource/auth_datasource.dart';
import 'package:quickdrop_sellers/src/data/repository/auth_repository_impl.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';
import 'package:quickdrop_sellers/src/domain/usecase/app_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/login_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/signup_usecase.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/cubit/login_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/cubit/home_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page.dart/cubit/orders_page_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //datasource
  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(),
  );

  //repository
  sl.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(
      datasource: sl<AuthDatasource>(),
    ),
  );

  //usecase
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => AppUsecase(
      repository: sl<AuthRepository>(),
    ),
  );
  sl.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(
      repository: sl<AuthRepository>(),
    ),
  );
  // cubit
  sl.registerLazySingleton<AppCubit>(
    () => AppCubit(usecase: sl<AppUsecase>()),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      usecase: sl<LoginUsecase>(),
    ),
  );
  sl.registerFactory<SignupCubit>(
    () => SignupCubit(usecase: sl<SignupUsecase>()),
  );
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
  sl.registerFactory<OrdersCubit>(
    () => OrdersCubit(),
  );
}
