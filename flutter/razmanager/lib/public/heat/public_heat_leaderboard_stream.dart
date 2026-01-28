import 'dart:collection';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../protobuf/razmanager/protobuf/public/heat.v1.pb.dart';
import 'public_heat.dart';
import 'public_heat.model.dart';
import 'public_heat_child_base.dart';

class PublicHeatLeaderboardStream extends StatefulWidget {
  const PublicHeatLeaderboardStream({super.key});

  @override
  State<PublicHeatLeaderboardStream> createState() => _PublicHeatLeaderboardStreamState();
}

class _PublicHeatLeaderboardStreamState extends State<PublicHeatLeaderboardStream> {
  double textWidth(String text, double fontSize) {
    final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        maxLines: 1,
        textDirection: ui.TextDirection.ltr);

    textPainter.layout();
    final size = textPainter.size;

    return size.width;
  }

  @override
  Widget build(BuildContext context) {
    final heatModel = context.read<HeatModel>();

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/srceindhoven.png'))),
      child: Consumer<HeatStateModel>(
        builder: (_, model, __) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final fontSize = 20.0;

                  var heatUsersDriversMaxWidth = heatModel.heatUsers.entries.map((x) => textWidth("${x.value!.shortName.value} ", fontSize)).reduce(max);

                  // if (publicHeatChildState.heatProto.heatIndicators
                  //     .where((x) => x.hasCarImage())
                  //     .isNotEmpty) {
                  //   heatUsersDriversMaxWidth += fontSize + 8;
                  // }

                  if (heatModel.heatUsers.entries.where((x) => x.value!.hasImage()).isNotEmpty) {
                    heatUsersDriversMaxWidth += fontSize + 8;
                  }

                  final leaderboardColumns = <_PublicHeatLeaderboardStreamColumnKey, double>{};

                  leaderboardColumns.addEntries({
                    _PublicHeatLeaderboardStreamColumnKey.position: textWidth("Pos ", fontSize),
                    _PublicHeatLeaderboardStreamColumnKey.driver: heatUsersDriversMaxWidth,
                    _PublicHeatLeaderboardStreamColumnKey.gapInterval: textWidth(" XXXL", fontSize),
                    _PublicHeatLeaderboardStreamColumnKey.gapIntervalSpace: textWidth(" ", fontSize),
                  }.entries);

                  var leaderboardColumnWidth = leaderboardColumns.entries.map((x) => x.value).reduce((a, b) => a + b);

                  return Stack(children: [
                    Opacity(
                      opacity: 0.90,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Consumer<HeatStateHeaderModel>(builder: (_, model, __) {
                          return SizedBox(
                            width: leaderboardColumnWidth,
                            child: Container(
                              color: Theme.of(context).colorScheme.onSecondaryFixed,
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                if (model.laps != null) Text("${model.laps!} ", style: TextStyle(fontSize: fontSize)),
                                if (model.timer != null) Text(" ${model.timer!}", style: TextStyle(fontSize: fontSize)),
                              ]),
                            ),
                          );
                        }),
                        Expanded(
                          child: Consumer<HeatLeaderboardModel>(builder: (context, model, __) {
                            return Stack(fit: StackFit.expand, children: [
                              if (model.heatLeaderboard != null)
                                ...model.heatLeaderboard!.indicators.map((heatLeaderboardIndicator) {
                                  final heatIndicator =
                                      heatModel.heatProto!.heatIndicators.where((x) => x.indicatorId == heatLeaderboardIndicator.indicatorId).singleOrNull;
                                  final heatUser = heatModel.heatUsers[heatLeaderboardIndicator.indicatorId];
                                  // final timeTypeTimeLap = heatLeaderboardIndicator
                                  //     .timeTypeTimes
                                  //     .where((x) =>
                                  //         x.timeTypeId ==
                                  //         HeatIndicatorTimeTypeId
                                  //             .HEAT_INDICATOR_TIME_TYPE_ID_LAP)
                                  //     .singleOrNull;
                                  final lapsHasValue = heatLeaderboardIndicator.getFieldOrNull(heatLeaderboardIndicator.getTagNumber("laps") ?? -1) != null;
                                  return AnimatedPositioned(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                    top: fontSize * 0.5 + (heatLeaderboardIndicator.position - 1) * fontSize * 2,
                                    //left: left,
                                    child: Row(
                                      children: [
                                        Container(
                                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                                          child: Row(
                                              children: leaderboardColumns.entries.map((x) {
                                            switch (x.key) {
                                              case _PublicHeatLeaderboardStreamColumnKey.position:
                                                return SizedBox(
                                                  width: x.value,
                                                  child: Center(
                                                    child: Text(lapsHasValue ? heatLeaderboardIndicator.position.toString() : '',
                                                        style: TextStyle(fontSize: fontSize)),
                                                  ),
                                                );
                                              case _PublicHeatLeaderboardStreamColumnKey.indicator:
                                                return SizedBox(
                                                  width: x.value,
                                                  child: Center(
                                                    child: heatIndicator != null && heatIndicator.hasColor()
                                                        ? CircleAvatar(backgroundColor: Color(heatIndicator.color.value), radius: fontSize / 2)
                                                        : Text(heatLeaderboardIndicator.indicatorId.toString(), style: TextStyle(fontSize: fontSize)),
                                                  ),
                                                );
                                              case _PublicHeatLeaderboardStreamColumnKey.driver:
                                                return SizedBox(
                                                  width: x.value,
                                                  child: Row(
                                                    children: [
                                                      if (heatIndicator != null && heatIndicator.hasCarImage() && heatIndicator.carImage.value.isNotEmpty) ...[
                                                        CircleAvatar(
                                                            foregroundImage: MemoryImage(Uint8List.fromList(heatIndicator.carImage.value)),
                                                            radius: fontSize / 2),
                                                        SizedBox(width: 8),
                                                      ],
                                                      if (heatUser != null && heatUser.hasImage() && heatUser.image.value.isNotEmpty) ...[
                                                        CircleAvatar(
                                                            foregroundImage: MemoryImage(Uint8List.fromList(heatUser.image.value)), radius: fontSize / 2),
                                                        SizedBox(width: 8),
                                                      ],
                                                      Expanded(
                                                        child: Text(heatUser?.shortName.value ?? '?',
                                                            overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: fontSize)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              case _PublicHeatLeaderboardStreamColumnKey.gapInterval:
                                                return SizedBox(
                                                  width: x.value,
                                                  child: Text(heatLeaderboardIndicator.gapInterval.value,
                                                      textAlign: TextAlign.end, style: TextStyle(fontSize: fontSize)),
                                                );
                                              case _PublicHeatLeaderboardStreamColumnKey.gapIntervalSpace:
                                                return SizedBox(
                                                  width: x.value,
                                                  child: Text('', style: TextStyle(fontSize: fontSize)),
                                                );
                                            }
                                          }).toList()),
                                        ),
                                        ...heatLeaderboardIndicator.flags.map((x) {
                                          switch (x) {
                                            case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FINISHED:
                                              return Icon(Icons.sports_score, size: fontSize);
                                            case HeatIndicatorFlag.HEAT_INDICATOR_FLAG_FASTEST_LAP:
                                              return Icon(Icons.timer, color: Colors.purpleAccent, size: fontSize);
                                            default:
                                              return Icon(Icons.question_mark, size: fontSize);
                                          }
                                        })
                                      ],
                                    ),
                                  );
                                })
                            ]);
                          }),
                        ),
                      ]),
                    ),
                    if (model.heatStateType != null &&
                        (model.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN ||
                            model.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_YELLOW ||
                            model.heatStateType!.id == HeatStateTypeId.HEAT_STATE_TYPE_ID_COUNTDOWN_RED))
                      StartLights(model: model, constraints: constraints),
                  ]);
                },
              ));
        },
      ),
    );
  }
}

enum _PublicHeatLeaderboardStreamColumnKey {
  position,
  indicator,
  driver,
  gapInterval,
  gapIntervalSpace,
}
