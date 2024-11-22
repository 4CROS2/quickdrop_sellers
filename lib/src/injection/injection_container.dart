import 'package:get_it/get_it.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<AppCubit>(
    () => AppCubit(),
  );
}
