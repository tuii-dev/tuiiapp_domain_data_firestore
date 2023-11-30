import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tuiicore/core/errors/failure.dart';
import 'package:tuiicore/core/usecases/usecase.dart';
import 'package:tuiiapp_domain_data_firestore/file/domain/repositories/tuii_module_repository.dart';

class ExpireAppLinkCommandUseCase
    extends UseCase<bool, ExpireAppLinkCommandParams> {
  final TuiiModuleRepository repository;

  ExpireAppLinkCommandUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(ExpireAppLinkCommandParams params) async {
    return repository.expireAppLinkCommand(params.key);
  }
}

class ExpireAppLinkCommandParams extends Equatable {
  final String key;

  const ExpireAppLinkCommandParams({required this.key});

  @override
  List<Object> get props => [key];
}
