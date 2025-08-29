import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'state_state.dart';

class StateCubit<Value> extends Cubit<StateState<Value>> {
  final Function()? onClose;
  Value value;
  int index;

  StateCubit({this.onClose, required Value initialValue, this.index = 0})
    : value = initialValue,
      super(StateInitial<Value>(value: initialValue, index: 0));

  void changeValue(Value value) {
    this.value = value;
    emit(StateLoaded<Value>(value: value));
  }

  void addIndex() {
    emit(StateLoaded<Value>(value: value, index: 1));
  }
}
