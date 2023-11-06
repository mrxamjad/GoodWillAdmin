import 'package:flutter/material.dart';

Container timerUI(String S) {
  return Container(
      width: 8,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.teal, borderRadius: BorderRadius.circular(2)),
      child: Center(
        child: Text(
          S,
          style: const TextStyle(
              fontSize: 5, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ));
}
