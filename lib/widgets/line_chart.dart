import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

// class LineChart extends StatelessWidget {
//   const LineChart({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha:0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: const BoxDecoration(
//                           color: Color(0xFF5B6FED),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'Overall Sales',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF2D3748),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     '12 Millions',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2D3748),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Colors.green[400],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'Overall Earnings',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF2D3748),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     '78 Millions',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2D3748),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Colors.red[300],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'Overall Revenue',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF2D3748),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     '60 Millions',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2D3748),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Container(
//                         width: 10,
//                         height: 10,
//                         decoration: BoxDecoration(
//                           color: Colors.orange[300],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Text(
//                         'New Customers',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Color(0xFF2D3748),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     '23k',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2D3748),
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Container(
//                   height: 250,
//                   padding: const EdgeInsets.only(left: 20, top: 10),
//                   child: CustomPaint(
//                     painter: LineChartPainter(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildTimeButton('Today', true),
//               _buildTimeButton('Yesterday', false),
//               _buildTimeButton('7 days', false),
//               _buildTimeButton('15 days', false),
//               _buildTimeButton('30 days', false),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Center(
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF5B6FED),
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'View Reports',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTimeButton(String label, bool isActive) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: isActive ? const Color(0xFF5CB85C) : Colors.grey[200],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 13,
//           color: isActive ? Colors.white : Colors.grey[700],
//           fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
//         ),
//       ),
//     );
//   }
// }
//
// class LineChartPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint1 = Paint()
//       ..color = const Color(0xFF5B6FED).withValues(alpha:0.3)
//       ..style = PaintingStyle.fill;
//
//     final paint2 = Paint()
//       ..color = const Color(0xFF87CEEB).withValues(alpha:0.3)
//       ..style = PaintingStyle.fill;
//
//     final linePaint1 = Paint()
//       ..color = const Color(0xFF5B6FED)
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke;
//
//     final linePaint2 = Paint()
//       ..color = const Color(0xFF87CEEB)
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke;
//
//     // Generate sample data points
//     final points1 = <Offset>[];
//     final points2 = <Offset>[];
//     final monthsCount = 12;
//
//     for (int i = 0; i < monthsCount; i++) {
//       final x = (size.width / (monthsCount - 1)) * i;
//       final y1 = size.height * 0.3 + math.sin(i * 0.8) * size.height * 0.25;
//       final y2 = size.height * 0.5 + math.cos(i * 0.7) * size.height * 0.2;
//       points1.add(Offset(x, y1));
//       points2.add(Offset(x, y2));
//     }
//
//     // Draw filled areas
//     final path1 = Path();
//     path1.moveTo(0, size.height);
//     for (var point in points1) {
//       path1.lineTo(point.dx, point.dy);
//     }
//     path1.lineTo(size.width, size.height);
//     path1.close();
//     canvas.drawPath(path1, paint1);
//
//     final path2 = Path();
//     path2.moveTo(0, size.height);
//     for (var point in points2) {
//       path2.lineTo(point.dx, point.dy);
//     }
//     path2.lineTo(size.width, size.height);
//     path2.close();
//     canvas.drawPath(path2, paint2);
//
//     // Draw lines
//     final linePath1 = Path();
//     linePath1.moveTo(points1[0].dx, points1[0].dy);
//     for (var point in points1) {
//       linePath1.lineTo(point.dx, point.dy);
//     }
//     canvas.drawPath(linePath1, linePaint1);
//
//     final linePath2 = Path();
//     linePath2.moveTo(points2[0].dx, points2[0].dy);
//     for (var point in points2) {
//       linePath2.lineTo(point.dx, point.dy);
//     }
//     canvas.drawPath(linePath2, linePaint2);
//
//     // Draw month labels
//     final textStyle = TextStyle(color: Colors.grey[600], fontSize: 11);
//     final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//
//     for (int i = 0; i < months.length; i++) {
//       final x = (size.width / (months.length - 1)) * i;
//       final textSpan = TextSpan(text: months[i], style: textStyle);
//       final textPainter = TextPainter(
//         text: textSpan,
//         textDirection: TextDirection.ltr,
//       );
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height + 5));
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
            const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            return Text(months[value.toInt() % 12]);
          })),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 10), FlSpot(1, 25), FlSpot(2, 15), FlSpot(3, 30),
              FlSpot(4, 20), FlSpot(5, 40), FlSpot(6, 35), // etc.
            ],
            isCurved: true,
            color: AppColors.salesLine,
            barWidth: 3,
            dotData: const FlDotData(show: false),
          ),
          LineChartBarData(
            spots: const [
              FlSpot(0, 15), FlSpot(1, 30), FlSpot(2, 20), FlSpot(3, 35),
              FlSpot(4, 20), FlSpot(5, 45), FlSpot(6, 40),
            ],
            isCurved: true,
            color: AppColors.revenueLine,
            barWidth: 3,
            dotData: const FlDotData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            // getTooltipColor: ()=>,
            // tooltipBgColor: Colors.black.withOpacity(0.7),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  'Sales: ${spot.y.toInt()}\nRevenue: 20',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}