import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiientitymodels/files/tuii_app/data/models/app_link_command_model.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class GetAppLinkCommandUseCase
    extends UseCase<AppLinkCommandModel, GetAppLinkCommandParams> {
  final TuiiModuleRepository repository;

  GetAppLinkCommandUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, AppLinkCommandModel>> call(
      GetAppLinkCommandParams params) async {
    return repository.getAppLinkCommand(params.key);
  }
}

class GetAppLinkCommandParams extends Equatable {
  final String key;

  const GetAppLinkCommandParams({required this.key});

  @override
  List<Object> get props => [key];
}
