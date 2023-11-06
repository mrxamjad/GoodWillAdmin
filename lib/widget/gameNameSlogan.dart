import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Column gameNameSlogan(String name, String slogan) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(name,
          style: const TextStyle(
              color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 22)),
      Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3), color: Colors.teal),
          child: Text(slogan,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 8))),
    ],
  );
}
