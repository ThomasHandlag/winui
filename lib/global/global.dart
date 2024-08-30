import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;

sealed class SidebarEvent {
  const SidebarEvent();
}

class SidebarExpandEvent extends SidebarEvent {
  const SidebarExpandEvent();
}

class SidebarSelectEvent extends SidebarEvent {
  final int index;
  const SidebarSelectEvent(this.index);
}

class SidebarObjectState extends Equatable {
  final int index;
  final bool isOpen;
  const SidebarObjectState(this.index, this.isOpen);

  @override
  List<Object?> get props => [index, isOpen];
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    dev.log('${bloc.runtimeType} $change');
  }
}
