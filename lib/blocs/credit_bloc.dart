import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credit_event.dart';
part 'credit_state.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  CreditBloc() : super(const CreditState(credits: 10)) {
    on<SpendCredit>(_onSpendCredit);
    on<AddCredits>(_onAddCredits);
  }

  void _onSpendCredit(SpendCredit event, Emitter<CreditState> emit) {
    if (state.credits >= event.amount) {
      emit(CreditState(credits: state.credits - event.amount));
    }
  }

  void _onAddCredits(AddCredits event, Emitter<CreditState> emit) {
    emit(CreditState(credits: state.credits + event.amount));
  }
}