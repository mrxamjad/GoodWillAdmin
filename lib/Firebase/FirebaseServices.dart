import 'package:cloud_firestore/cloud_firestore.dart';

import '../Constrants/FirebaseKey.dart';

class FirebaseService {
  static final _firebaseInstance = FirebaseFirestore.instance;

  static final currentMatchRef = _firebaseInstance.collection("current_match");
  static final novelRef =
      currentMatchRef.doc(FirebaseKey.novel).collection(FirebaseKey.novel);
  static final heroRef =
      currentMatchRef.doc(FirebaseKey.hero).collection(FirebaseKey.hero);
  static final fizzRef =
      currentMatchRef.doc(FirebaseKey.fizz).collection(FirebaseKey.fizz);

  static final eliteRef =
      currentMatchRef.doc(FirebaseKey.elite).collection(FirebaseKey.elite);

  //Update match Winner
  static updateMatchWinner(String matchCategory, String matchId, String winner,
      bool winnerSelected, bool lowAmountWinner) async {
    await FirebaseFirestore.instance
        .collection(FirebaseKey.matchHistory)
        .doc(matchCategory)
        .collection(matchCategory)
        .doc(matchId)
        .update({
      FirebaseKey.matchWinner: winner,
      FirebaseKey.winnerSelected: winnerSelected,
      FirebaseKey.highAmount: lowAmountWinner
    });
  }
}
