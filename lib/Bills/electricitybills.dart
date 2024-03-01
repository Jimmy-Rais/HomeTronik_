import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class bills extends StatefulWidget {
  const bills({super.key});

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
    return Container(
      width: 350,
      height: 180,
      child: SfCartesianChart(
        // Define your chart properties here
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0), // Remove major grid lines
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0), // Remove major grid lines
        ),
        // primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          StackedColumnSeries<SalesData, String>(
            dataSource: salesData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            width: 0.5,
            color: salesColors[0],
          )
        ],
      ),
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
