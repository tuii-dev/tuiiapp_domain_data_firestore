import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/calendar/data/models/lesson_booking_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class RefreshLessonBookingUseCase
    extends UseCase<LessonBookingModel?, RefreshLessonBookingParams> {
  final TuiiModuleRepository repository;

  RefreshLessonBookingUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, LessonBookingModel?>> call(
      RefreshLessonBookingParams params) async {
    return repository.refreshLessonBooking(params.lessonBookingId);
  }
}

class RefreshLessonBookingParams extends Equatable {
  const RefreshLessonBookingParams({required this.lessonBookingId});

  final String lessonBookingId;

  @override
  List<Object> get props {
    return [lessonBookingId];
  }
}
