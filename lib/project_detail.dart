import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';

import 'utils.dart';
import 'widgets.dart';

import 'project.dart';
import 'project_form.dart';
import 'app_state.dart';

class ProjectDetail extends StatelessWidget {
  final AppState state;
  final Project project;
  ProjectDetail({super.key, required this.state, required this.project});
  @override
  Widget build(context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Project Detail'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              project.imageURL != null
                  ? Card(
                      child: CachedNetworkImage(
                        imageUrl: project.imageURL!,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        imageBuilder: (context, imageProvider) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit
                                .cover, // Adjust the fit to suit your needs
                          ),
                        ),
                      ),
                    )
                  : Text('Image not found'),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(project.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(project.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
