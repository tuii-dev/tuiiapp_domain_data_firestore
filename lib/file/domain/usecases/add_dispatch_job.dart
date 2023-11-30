import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/models/job_dispatch_model.dart';
import 'package:tuiicore/core/usecases/usecase.dart';

class AddDispatchJobUseCase extends UseCase<bool, AddDispatchJobParams> {
  final TuiiModuleRepository repository;

  AddDispatchJobUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(AddDispatchJobParams params) async {
    return repository.addDispatchJob(params.job);
  }
}

class AddDispatchJobParams extends Equatable {
  const AddDispatchJobParams({required this.job});

  final JobDispatchModel job;
  @override
  List<Object> get props {
    return [job];
  }
}
