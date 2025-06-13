import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GreenAction {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final Color categoryColor;
  final num co2;
  final num water;
  final num energy;
  final num points;
  final num cap;

  GreenAction(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.category,
      required this.categoryColor,
      required this.co2,
      required this.water,
      required this.energy,
      required this.points,
      required this.cap});
}

class UserPoints {
  final num points;
  UserPoints({required this.points});
}

class LocalUser {
  final String id;
  final String name;
  final num points;
  final String imageUrl;

  final num co2;
  final num water;
  final num energy;
  final num co2Footprint;
  final num waterFootprint;
  final num energyFootprint;
  final num foodWaste;
  final num tally;

  LocalUser(
      {required this.id,
      required this.name,
      required this.points,
      required this.imageUrl,
      required this.co2,
      required this.water,
      required this.energy,
      required this.co2Footprint,
      required this.waterFootprint,
      required this.energyFootprint,
      required this.foodWaste,
      required this.tally});
}

class UserAction {
  final String id;
  final DocumentReference userId;
  final DocumentReference actionId;
  final DateTime date;

  UserAction(
      {required this.id,
      required this.userId,
      required this.actionId,
      required this.date});
}

class SameActionTally {
  final int tally;

  SameActionTally({required this.tally});
}

class Favorite {
  final String id;
  final DocumentReference userId;
  final DocumentReference actionId;

  Favorite({required this.id, required this.userId, required this.actionId});
}

class DailyActionRecord {
  final String timestamp;
  final String name;
  final String imageUrl;
  final String category;
  final Color categoryColor;

  DailyActionRecord(
      {required this.timestamp,
      required this.name,
      required this.imageUrl,
      required this.category,
      required this.categoryColor});
}
