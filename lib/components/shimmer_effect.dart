import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 13, top: 10),
      height: kDefaultHeight * 5.5,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                right: kDefaultPadding / 2,
                top: kDefaultPadding / 1.5,
                left: kDefaultPadding * 2),
            margin: const EdgeInsets.only(left: kDefaultPadding * 3),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 7,
                      spreadRadius: 2,
                      offset: const Offset(-3, 1)),
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: const Offset(3, -1)),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: shimmerContainer(
                              height: kDefaultHeight,
                              margin: const EdgeInsets.only(top: 4,right: kDefaultPadding*4))),
                      Row(
                          children: [
                        Expanded(
                            flex: 4,
                            child:shimmerContainer(
                                height: 10,
                            )),
                        const SizedBox(width: kDefaultWidth / 2,),
                        Expanded(
                            flex: 2,
                            child:shimmerContainer(
                                height: 30
                            ))

                      ]),
                      shimmerContainer(
                          height: 20,
                        width: MediaQuery.of(context).size.width/3+10,
                        margin: const EdgeInsets.only(bottom: kDefaultPadding/2)
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //image container
          shimmerContainer(
            height: kDefaultHeight * 3.5,
            width: 70,
            margin: const EdgeInsets.only(top: 15, left: 20),
          )
        ],
      ),
    );
  }

  Widget shimmerContainer({required double height, double? width, EdgeInsets? margin}) {
    return Shimmer.fromColors(
      highlightColor: Colors.black26,
      baseColor: Colors.grey,
      child: Container(
        height: height,
        margin: margin,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black38,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
