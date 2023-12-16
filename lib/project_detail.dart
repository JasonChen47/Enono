import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';

import 'utils.dart';
import 'widgets.dart';

import 'entry.dart';
import 'project_form.dart';
import 'app_state.dart';

class ProjectDetail extends StatelessWidget {
  final AppState state;
  final Entry entry;
  ProjectDetail({super.key, required this.state, required this.entry});
  @override
  Widget build(context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Project Detail'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            entry.imageURL != null
                ? CachedNetworkImage(
                    imageUrl: entry.imageURL!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Text('Image not found'),
            Text('hi'),
          ],
        ),
      ),
    );
  }
}
