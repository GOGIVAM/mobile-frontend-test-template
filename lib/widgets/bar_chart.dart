import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// class BarChart extends StatelessWidget {
//   const BarChart({Key? key}) : super(key: key);
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
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Sales',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF2D3748),
//             ),
//           ),
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               _buildBar('Usa', 0.4, const Color(0xFF5B6FED)),
//               _buildBar('Ind', 0.65, const Color(0xFF5B6FED)),
//               _buildBar('Brz', 0.75, const Color(0xFF5B6FED)),
//               _buildBar('Mex', 0.9, const Color(0xFF5B6FED)),
//             ],
//           ),
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 12,
//                 height: 12,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF5B6FED),
//                   shape: BoxShape.circle,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 'Sales',
//                 style: TextStyle(fontSize: 14, color: Color(0xFF2D3748)),
//               ),
//               const SizedBox(width: 20),
//               Container(
//                 width: 12,
//                 height: 12,
//                 decoration: BoxDecoration(
//                   color: Colors.cyan[300],
//                   shape: BoxShape.circle,
//                 ),
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 'Revenue',
//                 style: TextStyle(fontSize: 14, color: Color(0xFF2D3748)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Center(
//             child: Text(
//               '2100',
//               style: TextStyle(
//                 fontSize: 36,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF2D3748),
//               ),
//             ),
//           ),
//           Center(
//             child: Text(
//               '12% higher than last month.',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBar(String label, double heightFactor, Color color) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 60,
//           height: 200 * heightFactor,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 color,
//                 color.withOpacity(0.6),
//               ],
//             ),
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(8),
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             color: Colors.grey[700],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
              const countries = ['Usa', 'Ind', 'Brz', 'Mex'];
              return Text(countries[value.toInt()]);
            })),
          ),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8)]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 12)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 18)]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 14)]),
          ],
        ),
      ),
    );
  }
}