import 'package:flutter/material.dart';

class NewSWimmerNamePage extends StatefulWidget {
  @override
  _NewSWimmerNamePageState createState() => _NewSWimmerNamePageState();
}

class _NewSWimmerNamePageState extends State<NewSWimmerNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  String _firstName;
  String _lastName;

  @override
  void initState() {
    super.initState();
    _firstName = '';
    _lastName = '';
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the Form is disposed
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
