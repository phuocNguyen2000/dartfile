import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wcloud/common/http/response.dart';
import 'package:wcloud/feature/domain/bloc/domain_event.dart';
import 'package:wcloud/feature/domain/bloc/domain_state.dart';
import 'package:wcloud/feature/domain/resources/index.dart';
import 'package:wcloud/feature/domain/resources/domain_repository.dart';
import 'package:meta/meta.dart';
import '../../../common/util/form_validator.dart' as validator;

class DomainBloc extends Bloc<DomainEvent, DomainState> {
  final DomainRepository domainRepository;

  DomainBloc({
    @required this.domainRepository,
  }) : super(DomainInitial());

  @override
  Stream<DomainState> mapEventToState(DomainEvent event) async* {
    if (event is DomainButtonPressed) {
      yield DomainLoading();

      try {
        if (validator.FormValidator.validateDomain(event.domain)) {
          final response = await domainRepository.domain(event.domain);
          print('G: ' + response.message.toString());
          if (response.status == Status.ConnectivityError) {
            //Internet problem
            yield const DomainFailure(error: "");
          }
          if (response.status == Status.Success) {
            yield DomainSuccess();
          } else {
            yield DomainFailure(error: response.message);
          }
        } else {
          yield DomainFailure(error: 'Domain không hợp lệ!');
        }
      } catch (error) {
        yield DomainFailure(error: error.toString());
      }
    }
  }
}
