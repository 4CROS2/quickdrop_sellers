import 'package:get_it/get_it.dart';
import 'package:quickdrop_sellers/src/data/datasource/auth_datasource.dart';
import 'package:quickdrop_sellers/src/data/datasource/firebase_analytics_datasource.dart';
import 'package:quickdrop_sellers/src/data/datasource/notification_service_datasource.dart';
import 'package:quickdrop_sellers/src/data/datasource/orders_datasource.dart';
import 'package:quickdrop_sellers/src/data/datasource/products_datasource.dart';
import 'package:quickdrop_sellers/src/data/datasource/schedule_datasource.dart';
import 'package:quickdrop_sellers/src/data/repository/analytics_repository_impl.dart';
import 'package:quickdrop_sellers/src/data/repository/auth_repository_impl.dart';
import 'package:quickdrop_sellers/src/data/repository/notifications_repository_impl.dart';
import 'package:quickdrop_sellers/src/data/repository/orders_repository_impl.dart';
import 'package:quickdrop_sellers/src/data/repository/products_repository_impl.dart';
import 'package:quickdrop_sellers/src/data/repository/schedule_repository_impl.dart';
import 'package:quickdrop_sellers/src/domain/repository/analytics_repository.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';
import 'package:quickdrop_sellers/src/domain/repository/notification_repository.dart';
import 'package:quickdrop_sellers/src/domain/repository/orders_respository.dart';
import 'package:quickdrop_sellers/src/domain/repository/products_repository.dart';
import 'package:quickdrop_sellers/src/domain/repository/schedule_repository.dart';
import 'package:quickdrop_sellers/src/domain/usecase/analytics_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/app_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/login_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/new_product_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/notification_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/orders_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/products_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/schedule_usecase.dart';
import 'package:quickdrop_sellers/src/domain/usecase/signup_usecase.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/cubit/login_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/cubit/signup_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/cubit/home_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/products/cubit/products_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/cubit/newproduct_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/notifications/cubit/notifications_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/cubit/schedule_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //datasource
  sl.registerLazySingleton<AuthDatasource>(
    () => AuthDatasource(),
  );
  sl.registerLazySingleton<OrdersDatasource>(
    () => OrdersDatasource(),
  );
  sl.registerLazySingleton<AnalyticsDatasource>(
    () => AnalyticsDatasource(),
  );
  sl.registerLazySingleton<ScheduleDatasource>(
    () => ScheduleDatasource(),
  );
  sl.registerLazySingleton<ProductsDatasource>(
    () => ProductsDatasource(),
  );
  sl.registerLazySingleton<NotificationServiceDatasource>(
    () => NotificationServiceDatasource(),
  );

  //repository
  sl.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(
      datasource: sl<AuthDatasource>(),
    ),
  );
  sl.registerLazySingleton<OrdersRespository>(
    () => IOrdersRepository(
      datasource: sl<OrdersDatasource>(),
    ),
  );
  sl.registerLazySingleton<AnalyticsRepository>(
    () => IAnalyticsRepository(
      datasource: sl<AnalyticsDatasource>(),
    ),
  );
  sl.registerLazySingleton<ScheduleRepository>(
    () => IScheduleRepository(
      datasource: sl<ScheduleDatasource>(),
    ),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => IProductsRepository(
      datasource: sl<ProductsDatasource>(),
    ),
  );
  sl.registerLazySingleton<NotificationsRepository>(
    () => INotificationsRepository(
      datasource: sl<NotificationServiceDatasource>(),
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
  sl.registerLazySingleton<OrdersUsecase>(
    () => OrdersUsecase(
      repository: sl<OrdersRespository>(),
    ),
  );
  sl.registerLazySingleton<AnalyticsUsecase>(
    () => AnalyticsUsecase(
      repository: sl<AnalyticsRepository>(),
    ),
  );
  sl.registerLazySingleton<ScheduleUsecase>(
    () => ScheduleUsecase(
      repository: sl<ScheduleRepository>(),
    ),
  );
  sl.registerLazySingleton<ProductsUsecase>(
    () => ProductsUsecase(
      reposity: sl<ProductRepository>(),
    ),
  );
  sl.registerLazySingleton<NewProductUsecase>(
    () => NewProductUsecase(
      repository: sl<ProductRepository>(),
    ),
  );
  sl.registerLazySingleton<NotificationUsecase>(
    () => NotificationUsecase(
      repository: sl<NotificationsRepository>(),
    ),
  );
  // cubit
  sl.registerLazySingleton<AppCubit>(
    () => AppCubit(
      usecase: sl<AppUsecase>(),
    ),
  );
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(
      usecase: sl<LoginUsecase>(),
    ),
  );
  sl.registerFactory<SignupCubit>(
    () => SignupCubit(
      usecase: sl<SignupUsecase>(),
    ),
  );
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
  sl.registerFactory<ScheduleCubit>(
    () => ScheduleCubit(
      usecase: sl<ScheduleUsecase>(),
    ),
  );
  sl.registerFactory<ProductsCubit>(
    () => ProductsCubit(
      usecase: sl<ProductsUsecase>(),
    ),
  );
  sl.registerFactory<NewProductCubit>(
    () => NewProductCubit(
      usecase: sl<NewProductUsecase>(),
    ),
  );

  sl.registerFactory<NotificationsCubit>(
    () => NotificationsCubit(
      usecase: sl<NotificationUsecase>(),
    ),
  );
}
