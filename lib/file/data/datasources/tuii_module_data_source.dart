import 'package:tuiicore/core/models/job_dispatch_model.dart';
import 'package:tuiientitymodels/files/auth/data/models/user_model.dart';
import 'package:tuiientitymodels/files/calendar/data/models/lesson_booking_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/app_link_command_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/system_config_model.dart';

abstract class TuiiModuleDataSource {
  Future<NotificationModel> createNotification(NotificationModel notification);
  Future<NotificationModel> updateNotification(NotificationModel notification);
  Future<List<NotificationModel>> updateNotificationList(
      List<NotificationModel> notifications);
  Future<bool> deleteNotification(NotificationModel notification);

  Stream<List<Future<NotificationModel>>> getNotificationStream(
      {required String userId});

  Stream<SystemConfigModel> getSystemConfiguration();
  Future<AppLinkCommandModel> getAppLinkCommand(String key);
  Future<bool> expireAppLinkCommand(String key);
  Future<LessonBookingModel?> refreshLessonBooking(String id);
  Future<bool> addDispatchJob(JobDispatchModel job);
  Future<UserModel> getUser(String userId);
}
