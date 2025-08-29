part of 'state_cubit.dart';

@immutable
abstract class StateState<Value> extends Equatable {
  final Value value;
  final int index;
  const StateState({required this.value, this.index = 0});
}

class StateInitial<Value> extends StateState<Value> {
  const StateInitial({required super.value, super.index});
  @override
  List<Object?> get props => [value, index];
}

class StateLoading<Value> extends StateState<Value> {
  const StateLoading({required super.value, super.index});
  @override
  List<Object?> get props => [value, index];
}

class StateLoaded<Value> extends StateState<Value> {
  const StateLoaded({required super.value, super.index});
  @override
  List<Object?> get props => [value, index];
}
