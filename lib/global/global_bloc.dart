import 'package:bloc/bloc.dart';
import 'package:winui/global/global.dart';
import 'dart:developer' as dev;

class SidebarBloc extends Bloc<SidebarEvent, SidebarObjectState> {
  SidebarBloc() : super(const SidebarObjectState(0, true)) {
    on<SidebarExpandEvent>(_onOpenSidebar);
    on<SidebarSelectEvent>(_onSelectIndex);
  }

  void _onOpenSidebar(
      SidebarExpandEvent event, Emitter<SidebarObjectState> emit) {
    emit(SidebarObjectState(state.index, !state.isOpen));
  }

  void _onSelectIndex(
      SidebarSelectEvent event, Emitter<SidebarObjectState> emit) {
    emit(SidebarObjectState(event.index, state.isOpen));
  }

  @override
  void onChange(Change<SidebarObjectState> change) {
    super.onChange(change);

    dev.log(change.currentState.toString());
  }
}
