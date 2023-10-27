import 'package:flutter/material.dart';

// class ParentPage extends StatelessWidget {
//   ParentPage({super.key, required this.listData, required this.callback});
//   Widget listData;
//   Function callback;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           backgroundColor: AppColors.kPrimaryColor,
//           child: Icon(
//             Icons.add,
//             color: AppColors.kSecondaryColor,
//           ),
//           onPressed: () {
//             callback();
//           },
//         ),
//         body: Column(
//           children: [
//             // Container(
//             //   padding: EdgeInsets.zero,
//             //   child: Stack(children: [
//             //     Container(
//             //       width: double.maxFinite,
//             //       height: 600,
//             //       decoration: const BoxDecoration(
//             //           color: Colors.white,
//             //           image: DecorationImage(
//             //               image: AssetImage('Assets/Images/main_back.jpg'),
//             //               fit: BoxFit.cover)),
//             //     ),
//             //     Positioned(
//             //       top: 0,
//             //       left: 0,
//             //       right: 0,
//             //       bottom: 0,
//             //       child: Container(
//             //         padding: EdgeInsets.zero,
//             //         decoration: BoxDecoration(
//             //             color: AppColors.kBlackColor.withOpacity(0.3)),
//             //       ),
//             //     ),
//             //   ]),
//             // ),
//             Expanded(
//               child: listData,
//             )
//           ],
//         ));
//   }
// }

class ParentPage extends StatelessWidget {
  ParentPage({super.key, required this.listData, required this.callback});
  Widget listData;
  Function callback;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Container(
        //   padding: EdgeInsets.zero,
        //   child: Stack(children: [
        //     Container(
        //       width: double.maxFinite,
        //       height: 600,
        //       decoration: const BoxDecoration(
        //           color: Colors.white,
        //           image: DecorationImage(
        //               image: AssetImage('Assets/Images/main_back.jpg'),
        //               fit: BoxFit.cover)),
        //     ),
        //     Positioned(
        //       top: 0,
        //       left: 0,
        //       right: 0,
        //       bottom: 0,
        //       child: Container(
        //         padding: EdgeInsets.zero,
        //         decoration: BoxDecoration(
        //             color: AppColors.kBlackColor.withOpacity(0.3)),
        //       ),
        //     ),
        //   ]),
        // ),
        Flexible(
          child: listData,
        )
      ],
    );
  }
}
