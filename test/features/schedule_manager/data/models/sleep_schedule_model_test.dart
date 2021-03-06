import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:polysleep/features/schedule_manager/data/models/alarm_info_model.dart';
import 'package:polysleep/features/schedule_manager/data/models/sleep_schedule_model.dart';
import 'package:polysleep/features/schedule_manager/data/models/sleep_segment_model.dart';
import 'package:polysleep/features/schedule_manager/domain/entities/alarm_info.dart';
import 'package:polysleep/features/schedule_manager/domain/entities/segment_datetime.dart';
import 'package:polysleep/features/schedule_manager/domain/entities/sleep_schedule.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tSleepSegments = [
    SleepSegmentModel(
        startTime: SegmentDateTime(hr: 22),
        endTime: SegmentDateTime(hr: 6),
        alarmInfo:
            AlarmInfoModel.createDefaultUsingTime(SegmentDateTime(hr: 22)))
  ];
  final tSleepScheduleModel =
      SleepScheduleModel(name: "Monophasic", segments: tSleepSegments);

  test('should be subclass of SleepSchedule', () async {
    // assert
    expect(tSleepScheduleModel, isA<SleepSchedule>());
  });

  group('fromJson', () {
    test('should return valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('test_schedule.json'));

      // act
      final result = SleepScheduleModel.fromJson(jsonMap);

      // assert
      expect(result, tSleepScheduleModel);
    });
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tSleepScheduleModel.toJson();
        // assert
        final expectedMap = {
          SleepScheduleModel.nameKey: "Monophasic",
          SleepScheduleModel.segmentsKey: [
            {
              "start": "22:00",
              "end": "06:00",
              SleepSegmentModel.alarmInfoKey: {
                'soundOn': false,
                'vibrationOn': false,
                'ringTime': '22:00',
                'alarmCode': null
              }
            }
          ],
        };
        expect(result, expectedMap);
      },
    );
  });
}
