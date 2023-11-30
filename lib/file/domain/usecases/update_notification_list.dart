import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class UpdateNotificationListUseCase
    extends UseCase<List<NotificationModel>, UpdateNotificationListParams> {
  final TuiiModuleRepository repository;

  UpdateNotificationListUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<NotificationModel>>> call(
      UpdateNotificationListParams params) async {
    return repository.updateNotificationList(params.notifications);
  }
}

class UpdateNotificationListParams extends Equatable {
  const UpdateNotificationListParams({required this.notifications});

  final List<NotificationModel> notifications;
  @override
  List<Object> get props {
    return [notifications];
  }
}
