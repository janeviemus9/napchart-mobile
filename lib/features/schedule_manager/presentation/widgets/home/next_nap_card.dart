import 'package:flutter/material.dart';
import 'package:polysleep/features/schedule_manager/domain/entities/alarm_info.dart';
import 'package:polysleep/features/schedule_manager/domain/entities/sleep_schedule.dart';
import 'package:polysleep/features/schedule_manager/domain/entities/sleep_segment.dart';
import 'package:polysleep/features/schedule_manager/presentation/presenters/next_nap_info_presenter.dart';
import 'package:polysleep/features/schedule_manager/presentation/view_models/edit_alarm_view_model.dart';
import 'package:polysleep/features/schedule_manager/presentation/time_formatter.dart';
import '../../localizations.dart';
import 'package:polysleep/features/schedule_manager/presentation/view_models/home_view_model.dart';
import 'package:intl/intl.dart';
import '../../../../../injection_container.dart';
import 'edit_alarm_modal.dart';

class NextNapCard extends StatelessWidget {
  final HomeViewModel vm;
  NextNapCard(this.vm);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SleepSchedule>(
        stream: vm.currentScheduleStream,
        builder: (context, currentScheduleStream) {
          if (vm.shouldShowNapNavigationArrows) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 10.0),
                  onPressed: () {
                    vm.onLeftNapArrowTapped();
                  },
                ),
                Expanded(child: nextNapCardCentralSection(context)),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 10.0),
                  onPressed: () {
                    vm.onRightNapArrowTapped();
                  },
                )
              ],
            );
          } else {
            return nextNapCardCentralSection(context);
          }
        });
  }

  Widget nextNapCardCentralSection(BuildContext ctxt) {
    if (vm.currentSchedule == null) {
      return Container();
    }
    SleepSegment selectedSegment = vm.currentSchedule.getSelectedSegment();
    TimeFormatter tf = TimeFormatter();
    final NextNapInfoPresenter presenter = NextNapInfoPresenter(ctxt, this.vm);

    return Card(
        child: Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Text('Start'),
                    Text(presenter.currentNapStartTime)
                  ],
                )),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Text('End'),
                    Text(presenter.currentNapEndTime)
                  ],
                )),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Text('Duration'),
                    Text(presenter.currentNapDuration)
                  ],
                )),
              ],
            )),
        ListTile(
          title: Text('Alarm'),
          leading: Icon(
              presenter.currentNapAlarmOn ? Icons.alarm_on : Icons.alarm_off),
          subtitle: Text(presenter.currentNapAlarmInfoText),
          contentPadding: EdgeInsets.only(left: 30),
          onTap: () async {
            await showModalBottomSheet(
                context: ctxt, builder: (context) => EditAlarmModal(vm));
          },
        ),
        /*
        ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            title: Text('Notification'),
            leading: Icon(presenter.currentNapNotificationOn
                ? Icons.notifications_active
                : Icons.notifications_off),
            subtitle: Text(presenter.currentNapNotificationInfoText))*/
      ],
    ));
  }
}
