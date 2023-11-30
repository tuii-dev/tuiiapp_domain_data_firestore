import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';

import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/notification_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class GetNotificationStreamUseCase
    implements
        SyncUseCase<Stream<List<Future<NotificationModel>>>,
            GetNotificationParams> {
  final TuiiModuleRepository repository;

  GetNotificationStreamUseCase({required this.repository});

  @override
  Either<Failure, Stream<List<Future<NotificationModel>>>> call(
      GetNotificationParams params) {
    return repository.getNotificationStream(userId: params.userId);
  }
}

class GetNotificationParams extends Equatable {
  final String userId;

  const GetNotificationParams({required this.userId});

  @override
  List<Object> get props => [userId];
}
