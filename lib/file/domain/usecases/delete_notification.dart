import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class DeleteNotificationUseCase
    extends UseCase<bool, DeleteNotificationParams> {
  final TuiiModuleRepository repository;

  DeleteNotificationUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(DeleteNotificationParams params) async {
    return repository.deleteNotification(params.notification);
  }
}

class DeleteNotificationParams extends Equatable {
  const DeleteNotificationParams({required this.notification});

  final NotificationModel notification;
  @override
  List<Object> get props {
    return [notification];
  }
}
