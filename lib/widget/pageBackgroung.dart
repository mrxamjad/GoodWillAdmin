import 'package:flutter/material.dart';

Column pageBackground(
    {int flex = 6,
    Color fistBoxColor = Colors.white,
    Color secondBoxColor = Colors.white}) {
  return Column(
    children: [
      Expanded(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: fistBoxColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70)),
            ),

            // child: Text("Card1"),
          ),
        ),
      ),
      Expanded(
        flex: flex,
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: secondBoxColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(70), topRight: Radius.circular(70)),
            ),
          ),
        ),
      )
    ],
  );
}
