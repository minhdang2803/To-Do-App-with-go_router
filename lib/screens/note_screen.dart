import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/theme.dart';
import 'package:todoapp/models/models.dart';
import '../providers/providers.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      child: const NoteScreen(),
      name: TodoPages.item,
      key: ValueKey(TodoPages.item),
    );
  }

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _textInside = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
    _description.dispose();
    _textInside.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                ChipSelection selection =
                    Provider.of<TaskManager>(context, listen: false)
                        .getSelection;
                String getSelection = getPriority(selection);
                int color = Provider.of<TaskManager>(context, listen: false)
                    .getColor
                    .value;
                // String getColor = getColor(_color);
                Provider.of<TaskManager>(context, listen: false).addTask(
                  Task(
                    title: _title.text,
                    description: _description.text,
                    contextInside: _textInside.text,
                    chipLabel: getSelection,
                    backgroundColor: color,
                  ),
                );
                // ignore: use_build_context_synchronously
                Provider.of<TaskManager>(context, listen: false).setDefault();
                Provider.of<AppStateManager>(context, listen: false)
                    .gotoNoteScreen(false);
              },
              icon: const Icon(Icons.check)),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitleField(),
                  buildDescriptionTextField(),
                  const SizedBox(height: 8),
                  buildChoiceChip(context),
                  const SizedBox(height: 8),
                  buildContextInside()
                ],
              ),
            ),
            buildCancelButton(context)
          ],
        ),
      ),
    );
  }

  String getPriority(ChipSelection chip) {
    if (chip == ChipSelection.normal) {
      return 'Normal';
    } else if (chip == ChipSelection.important) {
      return 'Important';
    } else {
      return 'Urgent';
    }
  }

  TextField buildTitleField() {
    return TextField(
      cursorColor: TodoThemeManager.veryImportantChipCplor,
      controller: _title,
      decoration: InputDecoration(
        hintText: 'Title',
        hintStyle: Theme.of(context).textTheme.headline1,
        border: InputBorder.none,
      ),
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(color: TodoThemeManager.veryImportantChipCplor),
    );
  }

  Widget buildChoiceChip(BuildContext context) {
    return Consumer<TaskManager>(builder: (context, taskManager, child) {
      return Wrap(
        spacing: 10,
        children: [
          ChoiceChip(
              label: const Text('Normal'),
              selected: taskManager.getSelection == ChipSelection.normal,
              onSelected: (selected) {
                taskManager.setSelection(ChipSelection.normal);
                taskManager.setColor(TodoThemeManager.normalChipColor);
              },
              selectedColor: TodoThemeManager.normalChipColor),
          ChoiceChip(
            label: const Text('Important'),
            selected: taskManager.getSelection == ChipSelection.important,
            onSelected: (selected) {
              taskManager.setSelection(ChipSelection.important);
              taskManager.setColor(TodoThemeManager.importantChipColor);
            },
            selectedColor: TodoThemeManager.importantChipColor,
          ),
          ChoiceChip(
            label: const Text('Urgent'),
            selected: taskManager.getSelection == ChipSelection.urgent,
            onSelected: (selected) {
              taskManager.setSelection(ChipSelection.urgent);
              taskManager.setColor(TodoThemeManager.veryImportantChipCplor);
            },
            selectedColor: TodoThemeManager.veryImportantChipCplor,
          )
        ],
      );
    });
  }

  Widget buildContextInside() {
    return Expanded(
      child: TextField(
        cursorColor: TodoThemeManager.veryImportantChipCplor,
        controller: _textInside,
        decoration: const InputDecoration(
            hintText: 'Input your note here!', border: InputBorder.none),
        keyboardType: TextInputType.multiline,
        maxLines: 100,
      ),
    );
  }

  Widget buildDescriptionTextField() {
    return TextField(
      cursorColor: TodoThemeManager.veryImportantChipCplor,
      controller: _description,
      decoration: InputDecoration(
        hintText: 'Description',
        hintStyle: Theme.of(context).textTheme.headline2,
        border: InputBorder.none,
      ),
      style: Theme.of(context)
          .textTheme
          .headline2!
          .copyWith(color: TodoThemeManager.veryImportantChipCplor),
    );
  }

  Widget buildCancelButton(BuildContext context) {
    return Positioned(
      bottom: 25.0,
      right: 15.0,
      child: InkWell(
        onTap: () => Provider.of<AppStateManager>(context, listen: false)
            .gotoNoteScreen(false),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              color: Color(0xffFE3577),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: const Image(image: AssetImage('assets/delete_icon.png')),
        ),
      ),
    );
  }
}
