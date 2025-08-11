part of 'credit_bloc.dart';

class CreditState extends Equatable {
  final int credits;
  const CreditState({required this.credits});

  @override
  List<Object> get props => [credits];
}