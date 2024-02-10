import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sikad/data/datasources/auth_remote_datasource.dart';
import 'package:sikad/data/models/request/auth_request_model.dart';
import 'package:sikad/data/models/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(_Loading());
      final respones = await AuthRemoteDatasource().login(event.requestModel);
      respones.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
