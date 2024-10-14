import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:leave_management/core/providers/home_provider/home_provider.dart';
import 'package:leave_management/core/resources/app_constants.dart';
import 'package:leave_management/core/utils/snackbar_helper.dart';
import 'package:leave_management/features/home/model/leave_model.dart';
import 'package:leave_management/features/home/presentation/widgets/app_calender.dart';
import 'package:leave_management/features/home/presentation/widgets/delete_leave_dialog.dart';
import 'package:leave_management/features/home/presentation/widgets/leave_details_dialog.dart';
import 'package:leave_management/features/home/presentation/widgets/leave_dialog.dart';
import 'package:leave_management/features/home/presentation/widgets/leave_item.dart';
import 'package:leave_management/widgets/gradient_app_bar.dart';

class HomeView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(HomeProvider.homeProvider);
    final homeProviderNotifier = ref.read(HomeProvider.homeProvider.notifier);

    void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      homeProviderNotifier.onDaySelected(selectedDay, focusedDay);
    }

    void removeLeave(DateTime day, LeaveModel leave) {
      homeProviderNotifier.removeLeave(day, leave);
    }

    void setSelectedUser(String user) {
      homeProviderNotifier.setSelectedUser(user);
    }

    void handleFABPress() {
      if (!homeProviderNotifier.canAddLeave(homeState.selectedDay)) {
        SnackBarHelper.showSnackBar(context, AppConstants.cannotAddLeave);
        return;
      }
      showDialog(
        context: context,
        builder: (context) {
          return LeaveDialog(
            focusedDay: homeState.focusedDay,
            leaves: homeState.leaves,
            selectedLeave: homeProviderNotifier.getEventsForTheDay(homeState.selectedDay!),
            onLeaveAdded: (String user) {
              setSelectedUser(user);
            },
            onSelectedLeaveChanged: (updatedLeaves) {
              homeProviderNotifier.updateLeavesForDay(homeState.selectedDay!, updatedLeaves);
            },
          );
        },
      );
    }

    void showDeleteDialog(DateTime day, LeaveModel leave) async {
      final shouldDelete = await showDialog<bool>(
        context: context,
        builder: (context) {
          return DeleteLeaveDialog(onConfirm: () {
            Navigator.of(context).pop(true);
          });
        },
      );

      if (shouldDelete == true) {
        removeLeave(day, leave);
      }
    }

    return Scaffold(
      appBar: const GradientAppBar(),
      body: Column(
        children: [
          AppCalender(
            focusedDay: homeState.focusedDay,
            selectedDay: homeState.selectedDay,
            leaves: homeState.leaves,
            selectedLeave: homeProviderNotifier.getEventsForTheDay(homeState.selectedDay!),
            onDaySelected: (selectedDay, focusedDay) {
              onDaySelected(selectedDay, focusedDay);
            }
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: homeState.selectedDay != null
                ? homeProviderNotifier.getEventsForTheDay(homeState.selectedDay!).length
                : 0,
              itemBuilder: (context, index) {
                final leave = homeProviderNotifier.getEventsForTheDay(homeState.selectedDay!)[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => LeaveDetailsDialog(leave: leave),
                    );
                  },
                  child: LeaveItem(
                    leave: leave,
                    onDelete: () => showDeleteDialog(homeState.selectedDay!, leave),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleFABPress,
        child: const Icon(Icons.add),
      ),
    );
  }
}
