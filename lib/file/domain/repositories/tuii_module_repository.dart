import 'package:dartz/dartz.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/models/job_dispatch_model.dart';
import 'package:tuiientitymodels/files/auth/domain/entities/user.dart';
import 'package:tuiientitymodels/files/calendar/data/models/lesson_booking_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/app_link_command_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/system_config_model.dart';

abstract class TuiiModuleRepository {
  Future<Either<Failure, NotificationModel>> createNotification(
      NotificationModel notification);
  Future<Either<Failure, NotificationModel>> updateNotification(
      NotificationModel notification);
  Future<Either<Failure, List<NotificationModel>>> updateNotificationList(
      List<NotificationModel> notifications);
  Future<Either<Failure, bool>> deleteNotification(
      NotificationModel notification);

  Either<Failure, Stream<List<Future<NotificationModel>>>>
      getNotificationStream({required String userId});

  Future<Either<Failure, Stream<SystemConfigModel>>> getSystemConfiguration();
  Future<Either<Failure, AppLinkCommandModel>> getAppLinkCommand(String key);
  Future<Either<Failure, bool>> expireAppLinkCommand(String key);
  Future<Either<Failure, bool>> addDispatchJob(JobDispatchModel job);
  Future<Either<Failure, LessonBookingModel?>> refreshLessonBooking(String id);

  Future<User> getUser(String userId);
}
