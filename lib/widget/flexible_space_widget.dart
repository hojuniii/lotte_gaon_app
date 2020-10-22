// import 'package:carousel_slider/carousel_slider.dart';

// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// import 'package:gaon/const/app_color.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:provider/provider.dart';

// import '../provider/home_provider.dart';

// class FlexibleSpaceWidget extends StatefulWidget {
//   const FlexibleSpaceWidget({Key key, this.minTitle}) : super(key: key);
//   final String minTitle;

//   @override
//   _FlexibleSpaceWidgetState createState() => _FlexibleSpaceWidgetState();
// }

// class _FlexibleSpaceWidgetState extends State<FlexibleSpaceWidget> {
//   int curIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     HomeProvider provider = Provider.of<HomeProvider>(context);
//     double deviceWidth = MediaQuery.of(context).size.width;
//     double deviceHeight = MediaQuery.of(context).size.height;

//     return LayoutBuilder(
//       builder: (context, c) {
//         final settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
//         final deltaExtent = settings.maxExtent - settings.minExtent;
//         final t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
//             .clamp(0.0, 1.0) as double;
//         final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
//         const fadeEnd = 1.0;
//         final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

//         return Stack(
//           overflow: Overflow.clip,
//           children: [
//             Center(
//               child: Opacity(
//                 opacity: 1 - opacity,
//                 child: headTitle(
//                   '${widget.minTitle}',
//                 ),
//               ),
//             ),
//             Opacity(
//               opacity: opacity,
//               child: Container(
//                 width: deviceWidth,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                       'asset/profile_background.png',
//                     ),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 height: deviceHeight * 0.5,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 50,
//                       ),
//                       child: Column(
//                         children: [
//                           Align(
//                             child: Image.asset(
//                               'asset/profile_none.png',
//                               scale: 1.5,
//                             ),
//                           ),
//                           Text(
//                             '${provider.user.username}님 ',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 24,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 '오늘의 택배',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 14,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 '3/10개',
//                                 overflow: TextOverflow.fade,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget headTitle(String text) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: AppColor.mainRedColor,
//           fontSize: 26.0,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
