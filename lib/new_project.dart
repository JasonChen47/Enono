import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'dart:math';

import 'utils.dart';
import 'widgets.dart';

import 'entry.dart';
import 'project_form.dart';
import 'app_state.dart';

class NewProject extends StatelessWidget {
  final AppState state;
  NewProject({super.key, required this.state});
  @override
  Widget build(context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('New Project'),
      ),
      child: SafeArea(
        child: ProjectForm(
          key: Key('${Random().nextDouble()}'),
          onSubmit: (e) {
            state.writeEntryToFirebase(e);
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
