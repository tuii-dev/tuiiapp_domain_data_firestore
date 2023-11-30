import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class UpdateNotificationUseCase
    extends UseCase<NotificationModel, UpdateNotificationParams> {
  final TuiiModuleRepository repository;

  UpdateNotificationUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, NotificationModel>> call(
      UpdateNotificationParams params) async {
    return repository.updateNotification(params.notification);
  }
}

class UpdateNotificationParams extends Equatable {
  const UpdateNotificationParams({required this.notification});

  final NotificationModel notification;
  @override
  List<Object> get props {
    return [notification];
  }
}
