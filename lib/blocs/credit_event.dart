part of 'credit_bloc.dart';

abstract class CreditEvent extends Equatable {
  final int amount;
  const CreditEvent({required this.amount});

  @override
  List<Object> get props => [amount];
}

class SpendCredit extends CreditEvent {
  const SpendCredit({int amount = 1}) : super(amount: amount);
}

class AddCredits extends CreditEvent {
  const AddCredits({required int amount}) : super(amount: amount);
}