// lib/widgets/kpi_card.dart
import 'package:flutter/material.dart';

// class KpiCard extends StatelessWidget {
//   final IconData icon;
//   final String value;
//   final String label;
//   final Color color;
//
//   const KpiCard({
//     Key? key,
//     required this.icon,
//     required this.value,
//     required this.label,
//     required this.color,
//   }) : super(key: key);
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
//             color: Colors.grey.withValues(alpha: 0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: color.withValues(alpha: 0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               icon,
//               color: color,
//               size: 28,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF2D3748),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


class KpiCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const KpiCard({super.key, required this.title, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}