import 'package:get_it/get_it.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/cubit/login_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AppCubit>(
    () => AppCubit(),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );
}
