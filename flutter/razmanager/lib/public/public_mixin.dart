import 'package:flutter/material.dart';

import '../protobuf/razmanager/protobuf/public/heat.v1.pbserver.dart';
import '../protobuf/razmanager/protobuf/public/event.v1.pb.dart';
import '../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import '../protobuf/razmanager/protobuf/public/race.v1.pb.dart';

mixin PublicFormatter {
  double textWidth(String text, double fontSize) {
    final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr);

    textPainter.layout();
    final size = textPainter.size;

    return size.width;
  }

  Color? fastestTimeTypeColor(HeatIndicatorTimeTypeTime? timeTypeTime) {
    if (timeTypeTime == null) {
      return null;
    }

    switch (timeTypeTime.fastestTimeTypeId) {
      case HeatIndicatorFastestTimeTypeId
            .HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_ALL_INDICATORS:
        return Colors.purpleAccent;
      case HeatIndicatorFastestTimeTypeId
            .HEAT_INDICATOR_FASTEST_TIME_TYPE_ID_INDICATOR:
        return Colors.greenAccent;
      default:
        return null;
    }
  }

  String raceDisplayName({Event? event, required Race race}) {
    String result = "";

    if (event != null) {
      result = event.name;
      if (event.races.length > 2) {
        if (race.name.hasValue()) {
          result += " - Race ${race.name.value}";
        } else {
          result += " - Race ${race.number}";
        }
      }
    } else {
      if (race.name.hasValue()) {
        result = race.name.value;
      } else {
        result = race.number.toString();
      }
    }
    return result;
  }

  String heatDisplayName({Race? race, required Heat heat}) {
    String result = "";

    if (race != null) {
      result = "${raceDisplayName(race: race)} - ";
      if (race.heats.length > 2) {
        result += "Heat ${heat.number} - ";
      }
    } else {
      result = "${heat.number} - ";
    }
    result += heat.sessionType.name;

    return result;
  }
}
