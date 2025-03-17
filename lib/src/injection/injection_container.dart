part of 'injection_barrel.dart';

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
  sl.registerLazySingleton<LocationDatasourceImpl>(
    () => LocationDatasourceImpl(),
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
  sl.registerLazySingleton<LocationRepository>(
    () => ILocationRepository(
      datasource: sl<LocationDatasourceImpl>(),
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
  sl.registerLazySingleton<LocationUsecase>(
    () => LocationUsecase(
      repository: sl<LocationRepository>(),
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
  sl.registerFactory<LocationCubit>(
    () => LocationCubit(
      usecase: sl<LocationUsecase>(),
    ),
  );
}
