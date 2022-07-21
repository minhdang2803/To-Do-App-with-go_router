import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/models/models.dart';
import 'package:todoapp/providers/providers.dart';

import '../theme.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({Key? key, required this.task}) : super(key: key);
  final Task task;
  static MaterialPage page(Task task) {
    return MaterialPage(
      child: EditingScreen(task: task),
      name: TodoPages.editing,
      key: ValueKey(TodoPages.editing),
    );
  }

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  late TextEditingController _titleTextField;
  late TextEditingController _descriptionTextField;
  late TextEditingController _contentTextField;

  @override
  void initState() {
    super.initState();
    _titleTextField = TextEditingController(
        text: Provider.of<TaskManager>(context, listen: false).getTitle);
    _descriptionTextField = TextEditingController(
        text: Provider.of<TaskManager>(context, listen: false).getDescription);
    _contentTextField = TextEditingController(
        text:
            Provider.of<TaskManager>(context, listen: false).getContentInside);
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextField.dispose();
    _descriptionTextField.dispose();
    _contentTextField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              buildTopBar(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              buildTitleTextField(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              buildDescriptionTextFiled(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              buildChipSelection(context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              buildContentField(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Consumer<TaskManager>(builder: (context, taskManager, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildBackButton(context, taskManager),
          Text('Modify your work!',
              style: Theme.of(context).textTheme.headline2),
          buildDeleteButton(context, taskManager),
        ],
      );
    });
  }

  Widget buildBackButton(BuildContext context, TaskManager taskManager) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.arrow_back_ios_new, size: 25),
      onPressed: () => Provider.of<AppStateManager>(context, listen: false)
          .gotoEditingScreen(false),
      color: taskManager.getColor,
    );
  }

  Widget buildDeleteButton(BuildContext context, TaskManager taskManager) {
    return IconButton(
      onPressed: () {
        taskManager.deleteCurrentTask(widget.task);
        taskManager.setDefault();
        Provider.of<AppStateManager>(context, listen: false)
            .gotoEditingScreen(false);
      },
      icon: Icon(Icons.delete, size: 25, color: taskManager.getColor),
    );
  }

  Widget buildTitleTextField(BuildContext context) {
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        style: Theme.of(context).textTheme.headline1?.copyWith(
            color: taskManager.getColor,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 40),
        controller: _titleTextField,
        decoration: const InputDecoration(
            border: InputBorder.none, contentPadding: EdgeInsets.zero),
        autocorrect: false,
        enableSuggestions: false,
        textAlign: TextAlign.center,
        cursorColor: taskManager.getColor,
        onSubmitted: (value) {
          Provider.of<TaskManager>(context, listen: false)
              .setTitle(_titleTextField.text, widget.task.title!);
        },
      ),
    );
  }

  Widget buildDescriptionTextFiled(BuildContext context) {
    final taskManager = Provider.of<TaskManager>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        style: Theme.of(context).textTheme.headline1?.copyWith(
            color: taskManager.getColor,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 25),
        controller: _descriptionTextField,
        decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero),
        autocorrect: false,
        enableSuggestions: false,
        textAlign: TextAlign.center,
        cursorColor: taskManager.getColor,
        onSubmitted: (value) {
          Provider.of<TaskManager>(context, listen: false)
              .setDescription(_descriptionTextField.text, widget.task.title!);
        },
        cursorHeight: 25,
      ),
    );
  }

  Widget buildChipSelection(BuildContext context) {
    TaskManager taskManager = Provider.of<TaskManager>(context, listen: false);
    return Wrap(
      spacing: 10,
      children: [
        ChoiceChip(
            label: const Text('Normal'),
            selected: taskManager.getSelection == ChipSelection.normal,
            onSelected: (selected) {
              taskManager.setSelection(ChipSelection.normal);
              taskManager.setColor(TodoThemeManager.normalChipColor);
              taskManager.setPriority(widget.task.title!);
            },
            selectedColor: TodoThemeManager.normalChipColor),
        ChoiceChip(
          label: const Text('Important'),
          selected: taskManager.getSelection == ChipSelection.important,
          onSelected: (selected) {
            taskManager.setSelection(ChipSelection.important);
            taskManager.setColor(TodoThemeManager.importantChipColor);
            taskManager.setPriority(widget.task.title!);
          },
          selectedColor: TodoThemeManager.importantChipColor,
        ),
        ChoiceChip(
          label: const Text('Urgent'),
          selected: taskManager.getSelection == ChipSelection.urgent,
          onSelected: (selected) {
            taskManager.setSelection(ChipSelection.urgent);
            taskManager.setColor(TodoThemeManager.veryImportantChipCplor);
            taskManager.setPriority(widget.task.title!);
          },
          selectedColor: TodoThemeManager.veryImportantChipCplor,
        )
      ],
    );
  }

  Widget buildContentField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _contentTextField,
        decoration: const InputDecoration(border: InputBorder.none),
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: 20,
        onChanged: (value) {
          Provider.of<TaskManager>(context, listen: false)
              .changeContent(_contentTextField.text);
        },
      ),
    );
  }
}
