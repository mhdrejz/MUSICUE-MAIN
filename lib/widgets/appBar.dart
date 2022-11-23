// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:musicue/widgets/dbox.dart';

// class appBar extends StatelessWidget {
//   appBar({super.key, required this.icon, this.onTap});
//   final IconData icon;
//   final void Function()? onTap;
//   GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();

//   String greeting() {
//     var hour = DateTime.now().hour;
//     if (hour < 12) {
//       return 'Good Morning !';
//     }
//     if (hour < 16) {
//       return 'Good Afternoon !';
//     }
//     if (hour < 19) {
//       return 'Good Evening !';
//     }

//     return 'Good Night !';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           dbox(Child: IconButton(onPressed: onTap, icon: Icon(icon))),
//           Text(greeting()),
//           dbox(Child: IconButton(onPressed: onTap, icon: Icon(icon)))
//         ],
//       ),
//     );
//   }
// }
