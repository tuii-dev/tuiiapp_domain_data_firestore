import 'package:dartz/dartz.dart';
import 'package:tuiiapp_domain_data_firestore/file/data/datasources/tuii_module_data_source.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/models/job_dispatch_model.dart';
import 'package:tuiientitymodels/files/auth/domain/entities/user.dart';
import 'package:tuiientitymodels/files/calendar/data/models/lesson_booking_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/app_link_command_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/system_config_model.dart';

class TuiiModuleRepositoryImpl extends TuiiModuleRepository {
  TuiiModuleRepositoryImpl({required this.dataSource});

  final TuiiModuleDataSource dataSource;

  @override
  Future<Either<Failure, NotificationModel>> createNotification(
      NotificationModel notification) async {
    try {
      final newNotification = await dataSource.createNotification(notification);
      return Right(newNotification);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, NotificationModel>> updateNotification(
      NotificationModel notification) async {
    try {
      final newNotification = await dataSource.updateNotification(notification);
      return Right(newNotification);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> updateNotificationList(
      List<NotificationModel> notifications) async {
    try {
      final newNotifications =
          await dataSource.updateNotificationList(notifications);
      return Right(newNotifications);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteNotification(
      NotificationModel notification) async {
    try {
      final success = await dataSource.deleteNotification(notification);
      return Right(success);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Either<Failure, Stream<List<Future<NotificationModel>>>>
      getNotificationStream({required String userId}) {
    try {
      final stream = dataSource.getNotificationStream(userId: userId);
      return Right(stream);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, Stream<SystemConfigModel>>>
      getSystemConfiguration() async {
    try {
      final config = dataSource.getSystemConfiguration();
      return Right(config);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, AppLinkCommandModel>> getAppLinkCommand(
      String key) async {
    try {
      final cmd = await dataSource.getAppLinkCommand(key);
      return Right(cmd);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, bool>> expireAppLinkCommand(String key) async {
    try {
      final success = await dataSource.expireAppLinkCommand(key);
      return Right(success);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, LessonBookingModel?>> refreshLessonBooking(
      String id) async {
    try {
      final success = await dataSource.refreshLessonBooking(id);
      return Right(success);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, bool>> addDispatchJob(JobDispatchModel job) async {
    try {
      final success = await dataSource.addDispatchJob(job);
      return Right(success);
    } on Failure catch (err) {
      return Left(err);
    }
  }

  @override
  Future<User> getUser(String userId) async {
    final model = await dataSource.getUser(userId);
    return User.fromModel(model: model);
  }
}
