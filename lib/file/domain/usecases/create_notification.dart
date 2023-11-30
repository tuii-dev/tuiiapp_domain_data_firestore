import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class CreateNotificationUseCase
    extends UseCase<NotificationModel, CreateNotificationParams> {
  final TuiiModuleRepository repository;

  CreateNotificationUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, NotificationModel>> call(
      CreateNotificationParams params) async {
    return repository.createNotification(params.notification);
  }
}

class CreateNotificationParams extends Equatable {
  const CreateNotificationParams({required this.notification});

  final NotificationModel notification;
  @override
  List<Object> get props {
    return [notification];
  }
}
