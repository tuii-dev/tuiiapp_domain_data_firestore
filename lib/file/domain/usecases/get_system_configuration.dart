import 'package:dartz/dartz.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/system_config_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class GetSystemConfigurationUseCase
    extends UseCase<Stream<SystemConfigModel>, NoParams> {
  final TuiiModuleRepository repository;

  GetSystemConfigurationUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<SystemConfigModel>>> call(
      NoParams params) async {
    return repository.getSystemConfiguration();
  }
}
