import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:kdgaugeview/kdgaugeview.dart';

class bills extends StatefulWidget {
  bills(this.plotname, {super.key});
  String plotname;
  @override
  State<bills> createState() => _billsState();
}

class _billsState extends State<bills> {
  @override
  Widget build(BuildContext context) {
    final List<SalesData> salesData = [
      SalesData('Jan', 12, getColor(12)),
      SalesData('Feb', 8, getColor(8)),
      SalesData('Mar', 9, getColor(9)),
      SalesData('Apr', 13, getColor(13)),
      SalesData('May', 18, getColor(18)),
      SalesData('July', 14, getColor(14)),
      SalesData('Aug', 34, getColor(34)),
      SalesData('Sept', 32, getColor(32)),
      SalesData('Oct', 28, getColor(28)),
      SalesData('Nov', 5, getColor(5)),
      SalesData('Dec', 15, getColor(15)),
    ];
    // Retrieve the sales values in a single line of code
    final List<Color> salesColors =
        salesData.map((data) => data.color).toList();

    return Column(
      children: [
        Container(
          width: 350,
          height: 150,
          child: SfCartesianChart(
            // Define your chart properties here
            primaryXAxis: CategoryAxis(
              majorGridLines:
                  MajorGridLines(width: 0), // Remove major grid lines
            ),
            primaryYAxis: NumericAxis(
              majorGridLines:
                  MajorGridLines(width: 0), // Remove major grid lines
            ),
            // primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              if (widget.plotname == 'monthly')
                StackedColumnSeries<SalesData, String>(
                  dataSource: salesData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  width: 0.5,
                  color: salesColors[1],
                )
              else
                FastLineSeries<SalesData, String>(
                  dataSource: salesData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  width: 3.5,
                  color: salesColors[1],
                )
            ],
          ),
        ),
      ],
    );
  }
}

Color getColor(double sales) {
  if (sales < 10) {
    return Colors.green; // Green for values less than 10
  } else if (sales >= 10 && sales <= 20) {
    return Colors.blue; // Blue for values between 20 and 30
  } else if (sales > 20) {
    return Colors.red; // Red for values above 30
  } else {
    return Colors.purple;
  }
}

// Data model class for chart
class SalesData {
  final String year;
  final double sales;
  final Color color; // Color property to store color for each data point

  SalesData(this.year, this.sales, this.color);
}

class progress extends StatelessWidget {
  const progress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(10),
      child: KdGaugeView(
        innerCirclePadding: 10,
        speedTextStyle: TextStyle(
            color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
        minMaxTextStyle: TextStyle(color: Colors.grey, fontSize: 5),
        unitOfMeasurementTextStyle: TextStyle(color: Colors.grey, fontSize: 10),
        minSpeed: 0,
        maxSpeed: 100,
        speed: 10,
        animate: true,
        duration: Duration(seconds: 3),
        alertSpeedArray: [40, 80, 90],
        alertColorArray: [
          Colors.orange,
          const Color.fromARGB(255, 83, 85, 93),
          Colors.red
        ],
        unitOfMeasurement: "INR(₹)",
        gaugeWidth: 10,
        fractionDigits: 1,
      ),
    );
  }
}
