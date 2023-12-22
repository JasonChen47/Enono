import 'package:flutter/material.dart';

import 'project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                project.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Date: ${project.date}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const Divider(),
            Expanded(
              child: Text(
                project.description,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      height: 1.3,
                      wordSpacing: 1.2,
                      letterSpacing: 1.05,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
