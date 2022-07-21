import 'package:flutter/material.dart';
import 'package:todoapp/models/models.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title ?? 'No title',
            style: Theme.of(context).textTheme.headline2,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Text(
            task.description ??
                'Hello User! Welcome to WHAT_TODO app, this is a default task that you can edit or delete to start using the app.',
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 3,
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text(task.chipLabel),
            backgroundColor: Color(task.backgroundColor),
          )
        ],
      ),
    );
  }
}
