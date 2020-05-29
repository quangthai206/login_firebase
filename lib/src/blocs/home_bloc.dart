import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeBloc {
  static void incrementVote(DocumentSnapshot document) {
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(document.reference);
      await transaction.update(freshSnap.reference, {
        'votes': freshSnap['votes'] + 1,
      });
    });
  }

  static void addPlace(BuildContext context, String newPlace) {
    Firestore.instance
        .collection('locations')
        .document()
        .setData({'name': newPlace, 'votes': 0}).then((result) {});
  }
}
