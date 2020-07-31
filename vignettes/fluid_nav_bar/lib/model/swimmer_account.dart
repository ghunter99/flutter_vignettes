import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

enum Gender {
  female,
  male,
}

/// A read-only description of a swimmer account
class SwimmerAccount {
  SwimmerAccount({
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender = Gender.female,
    String id,
  }) : id = id ?? _uuid.v4();

  final String id;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final Gender gender;

  @override
  String toString() {
    return 'Swimmer(\'$firstName $lastName\', DOB: $dateOfBirth, Gender:$gender)';
  }
}

/// An object that controls a list of [SwimmerAccount]
class SwimmerAccountList extends StateNotifier<List<SwimmerAccount>> {
  SwimmerAccountList([List<SwimmerAccount> initialSwimmerAccounts])
      : super(initialSwimmerAccounts ?? []);

  void add({
    String firstName,
    String lastName,
    String dateOfBirth,
    Gender gender,
  }) {
    state = [
      ...state,
      SwimmerAccount(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        gender: gender,
      )
    ];
  }

  void edit({
    @required String id,
    @required String firstName,
    @required String lastName,
    @required String dateOfBirth,
    @required Gender gender,
  }) {
    state = [
      for (final swimmerAccount in state)
        if (swimmerAccount.id == id)
          SwimmerAccount(
            id: swimmerAccount.id,
            firstName: firstName,
            lastName: lastName,
            dateOfBirth: dateOfBirth,
            gender: gender,
          )
        else
          swimmerAccount,
    ];
  }

  void remove(SwimmerAccount target) {
    state = state
        .where((swimmerAccount) => swimmerAccount.id != target.id)
        .toList();
  }
}
