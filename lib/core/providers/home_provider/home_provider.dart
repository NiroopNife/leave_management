import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_management/features/home/model/leave_model.dart';
import 'package:leave_management/core/providers/home_provider/home_state.dart';

class HomeProvider {
  HomeProvider._();

  static final homeProvider =
      StateNotifierProvider<HomeProviderNotifier, HomeState>((ref) {
    return HomeProviderNotifier();
  });
}

class HomeProviderNotifier extends StateNotifier<HomeState> {
  HomeProviderNotifier()
      : super(HomeState(
            focusedDay: DateTime.now(),
            selectedDay: DateTime.now(),
            leaves: {},
            selectedUser: 'Person B',
            selectedLeaves: []));

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (state.selectedDay != selectedDay) {
      state = state.copyWith(selectedDay: selectedDay, focusedDay: focusedDay);
    }
  }

  List<LeaveModel> getEventsForTheDay(DateTime day) {
    return state.leaves[day] ?? [];
  }

  void removeLeave(DateTime day, LeaveModel leave) {
    if (day.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return;
    }

    final updatedLeaves = Map<DateTime, List<LeaveModel>>.from(state.leaves);
    updatedLeaves[day]?.remove(leave);
    
    if (updatedLeaves[day]?.isEmpty ?? true) {
      updatedLeaves.remove(day);
    }
    state = state.copyWith(leaves: updatedLeaves);
  }

  void setSelectedUser(String user) {
    state = state.copyWith(selectedUser: user);
  }

  void updateSelectedLeaves(List<LeaveModel> leaves) {
    state = state.copyWith(selectedLeaves: leaves);
  }

  void updateLeavesForDay(DateTime day, List<LeaveModel> leaves) {
    final updatedLeaves = Map<DateTime, List<LeaveModel>>.from(state.leaves);
    updatedLeaves[day] = leaves;
    state = state.copyWith(leaves: updatedLeaves);
  }

  bool canAddLeave(DateTime? selectedDay) {
    if (selectedDay == null) return false;
    return !selectedDay.isBefore(DateTime.now().subtract(const Duration(days: 1)));
  }
}
