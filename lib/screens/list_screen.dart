import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/component.dart';
import 'package:todoapp/providers/app_state_manager.dart';
import 'package:todoapp/providers/task_manager.dart';
import '../models/models.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopBar(context),
              const SizedBox(height: 20),
              buildListView(context)
            ],
          ),
          buildAddButton(context)
        ],
      ),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(image: AssetImage('assets/logo.png')),
          Text('List your works!',
              style: Theme.of(context).textTheme.headline2),
          IconButton(
              onPressed: () {
                Provider.of<TaskManager>(context, listen: false).setDefault();
                Provider.of<AppStateManager>(context, listen: false)
                    .gotoNoteScreen(true);
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return Consumer<TaskManager>(
      builder: (context, taskManager, child) {
        return Expanded(
          child: FutureBuilder<List<Task>>(
            future: taskManager.getTaskList(),
            builder: (context, AsyncSnapshot<List<Task>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString(),
                      style: Theme.of(context).textTheme.headline4),
                );
              }
              return snapshot.data!.isEmpty
                  ? Center(
                      child: Text('No Tasks in list',
                          style: Theme.of(context).textTheme.headline2))
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        Task task = snapshot.data![index];
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) =>
                              taskManager.deleteCurrentTask(task),
                          child: buildCustomTaskCard(context, task),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: snapshot.data!.length,
                    );
            },
          ),
        );
      },
    );
  }

  ClipRRect buildCustomTaskCard(BuildContext context, Task task) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Material(
        child: InkWell(
          onTap: () {
            Provider.of<TaskManager>(context, listen: false).setTask(task);
            Provider.of<AppStateManager>(context, listen: false)
                .gotoEditingScreen(true);
          },
          child: TaskCard(task: task),
        ),
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return Positioned(
      bottom: 10.0,
      right: 0,
      child: InkWell(
        onTap: () {
          Provider.of<TaskManager>(context, listen: false).setDefault();
          Provider.of<AppStateManager>(context, listen: false)
              .gotoNoteScreen(true);
        },
        onLongPress: () async {
          await Provider.of<TaskManager>(context, listen: false)
              .deleteAllTask();
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              color: Color(0xff7349FE),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Image(image: AssetImage('assets/add_icon.png')),
        ),
      ),
    );
  }
}
