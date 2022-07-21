import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: Column(
        children: [
          buildTopBar(context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          buildOptions(context)
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
          Text('Modify your application',
              style: Theme.of(context).textTheme.headline2),
          IconButton(
              onPressed: () {
                //TODO: User selection
              },
              icon: const Icon(Icons.circle))
        ],
      ),
    );
  }

  Widget buildOptions(BuildContext context) {
    return Card(
      child: Column(
        children: [buildShareButton(context), buildDarkModeSwitch(context)],
      ),
    );
  }

  Widget buildShareButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.share),
      title: Text(
        'Share the application',
        style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_right),
    );
  }

  Widget buildDarkModeSwitch(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.share),
      title: Text(
        'Dark mode',
        style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 18),
      ),
      trailing: Switch(
        value:
            Provider.of<TodoThemeManager>(context, listen: false).getDarkMode,
        onChanged: (value) {
          Provider.of<TodoThemeManager>(context, listen: false)
              .swapTheme(value);
        },
      ),
    );
  }
}
