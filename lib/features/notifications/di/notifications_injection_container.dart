import 'package:poi/di/injection_container.dart';
import 'package:poi/features/notifications/core/notification_click_controller.dart';
import 'package:poi/features/notifications/core/push_notification_controller.dart';
import 'package:poi/features/notifications/data/repo/notifications_repo_impl.dart';
import 'package:poi/features/notifications/data/resources/notifications_remote_data_source.dart';
import 'package:poi/features/notifications/domain/repo/notifications_repo.dart';
import 'package:poi/features/notifications/domain/use_cases/send_fcm_token_use_case.dart';

Future<void> initNotificationsInjectionContainer() async {
  sl.registerLazySingleton<NotificationsRepo>(
    () => NotificationsRepoImpl(sl()),
  );

  sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<SendFcmTokenUseCase>(
    () => SendFcmTokenUseCase(sl()),
  );
  sl.registerLazySingleton<PushNotificationController>(
    () => PushNotificationController(),
  );
  sl.registerLazySingleton<NotificationClickController>(
    () => NotificationClickController(),
  );
}
