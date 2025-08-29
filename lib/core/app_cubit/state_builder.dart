import 'package:poi/core/app_cubit/state_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateBuilder<Value> extends StatelessWidget {
  const StateBuilder({
    super.key,
    this.cubit,
    required this.builder,
    this.onCubitCreated,
    this.onValueChanged,
  });

  final StateCubit<Value>? cubit;
  final Function(Value value) builder;
  final Function(StateCubit<Value> cubit)? onCubitCreated;
  final void Function(Value value)? onValueChanged;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StateCubit<Value>, StateState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is StateLoaded<Value> && onValueChanged != null) {
          onValueChanged!(state.value);
        }
      },
      builder: (context, state) {
        if (state is StateInitial) {
          if (onCubitCreated != null && cubit != null) onCubitCreated!(cubit!);
        }
        return builder(state.value);
      },
    );
  }
}
