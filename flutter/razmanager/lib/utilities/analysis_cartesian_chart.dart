import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalysisCartesianChart extends StatefulWidget {
  const AnalysisCartesianChart({
    super.key,
    required this.constraints,
    required this.primaryXAxis,
    required this.primaryYAxis,
    this.zoomMode = ZoomMode.xy,
    required this.seriesGenerator,
    this.onLegendTapped,
    this.showDataLabelButton = false,
    this.initialIsDataLabelVisible = false,
  });

  final BoxConstraints constraints;
  final ChartAxis primaryXAxis;
  final ChartAxis primaryYAxis;
  final ZoomMode zoomMode;
  final List<CartesianSeries<dynamic, dynamic>> Function(bool isDataLabelVisible) seriesGenerator;
  //final List<CartesianSeries<dynamic, dynamic>> series;
  final ChartLegendTapCallback? onLegendTapped;
  final bool showDataLabelButton;
  final bool initialIsDataLabelVisible;

  @override
  State<AnalysisCartesianChart> createState() => AnalysisCartesianChartState();
}

class AnalysisCartesianChartState extends State<AnalysisCartesianChart> {
  late ZoomPanBehavior zoomPanBehavior;
  bool isDataLabelVisible = false;

  @override
  void initState() {
    super.initState();
    isDataLabelVisible = widget.initialIsDataLabelVisible;
    zoomPanBehavior = zoomPanBehavior = ZoomPanBehavior(zoomMode: widget.zoomMode, enablePinching: true, enableSelectionZooming: true, enableMouseWheelZooming: true, enablePanning: true);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.constraints.maxWidth > 500) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Row(
          children: [
            Expanded(
              child: SfCartesianChart(
                key: UniqueKey(),
                primaryXAxis: widget.primaryXAxis,
                primaryYAxis: widget.primaryYAxis,
                zoomPanBehavior: zoomPanBehavior,
                trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
                series: widget.seriesGenerator(isDataLabelVisible),
                legend: const Legend(
                  isVisible: true,
                  isResponsive: true,
                  position: LegendPosition.bottom,
                  shouldAlwaysShowScrollbar: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                ),

                onLegendTapped: widget.onLegendTapped,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.zoom_in), tooltip: "Zoom in", onPressed: zoomPanBehavior.zoomIn),
                IconButton(icon: const Icon(Icons.zoom_out), tooltip: "Zoom out", onPressed: zoomPanBehavior.zoomOut),
                IconButton(icon: const Icon(Icons.undo), tooltip: "Reset zoom", onPressed: zoomPanBehavior.reset),
                if (widget.showDataLabelButton)
                  IconButton(
                    icon: Icon(isDataLabelVisible ? Icons.numbers : Icons.rectangle_outlined),
                    tooltip: "Show driver changes, pit stops, deslots, and lap numbers",
                    onPressed: () {
                      isDataLabelVisible = !isDataLabelVisible;
                      setState(() {});
                    },
                  ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        child: SfCartesianChart(
          primaryXAxis: widget.primaryXAxis,
          primaryYAxis: widget.primaryYAxis,
          zoomPanBehavior: zoomPanBehavior,
          trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap),
          series: widget.seriesGenerator(isDataLabelVisible),
          legend: const Legend(
            isVisible: true,
            isResponsive: true,
            position: LegendPosition.bottom,
            shouldAlwaysShowScrollbar: true,
            overflowMode: LegendItemOverflowMode.scroll,
          ),

          onLegendTapped: widget.onLegendTapped,
        ),
      );
    }
  }
}


                          // onZoomEnd: (zoomPanArgs) {
                          //   if (zoomPanArgs.axis?.isVertical ?? false) {
                          //     debugPrint(
                          //         "onZoomEnd zoomingInProgress=${zoomPanArgs.axis?.zoomingInProgress} currentZoomPosition=${zoomPanArgs.currentZoomPosition} previousZoomPosition=${zoomPanArgs.previousZoomPosition}");
                          //     if (zoomPanArgs.axis?.isInversed ?? false) {
                          //      zoomPanArgs.currentZoomPosition = 1 - zoomPanArgs.currentZoomPosition ;
                          //     }
                          //     zoomPanArgs.currentZoomPosition = 0;
                          //     zoomPanArgs.axis!.initialZoomPosition = 0;
                          //   }
                          // },
                          // onZoomEnd: (zoomPanArgs) {
                          //   if (zoomPanArgs.axis?.isVertical ?? false) {
                          //     debugPrint(
                          //         "onZoomEnd zoomingInProgress=${zoomPanArgs.axis?.zoomingInProgress}");
                          //   }
                          // },
                          // onActualRangeChanged: (rangeChangedArgs) {
                          //   if (rangeChangedArgs.orientation == AxisOrientation.vertical) {
                          //     final change = rangeChangedArgs.visibleMin %
                          //         rangeChangedArgs.visibleInterval /
                          //         rangeChangedArgs.visibleInterval;
                          //     debugPrint(
                          //         "onActualRangeChanged ${rangeChangedArgs.visibleMin % rangeChangedArgs.visibleInterval / rangeChangedArgs.visibleInterval}");

                          //     if (change < 0.5) {
                          //       debugPrint("onActualRangeChanged snap!");
                          //       rangeChangedArgs.visibleMin = rangeChangedArgs.visibleMin -
                          //           (rangeChangedArgs.visibleMin %
                          //               rangeChangedArgs.visibleInterval);
                          //     }
                          //   }
                          // },

