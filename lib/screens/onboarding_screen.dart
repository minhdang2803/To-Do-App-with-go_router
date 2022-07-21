import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todoapp/components/todo_path.dart';
import 'package:todoapp/providers/app_state_manager.dart';
import 'package:todoapp/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  static MaterialPage page() {
    return MaterialPage(
        child: const OnboardingScreen(),
        key: ValueKey(TodoPages.onboardingPath),
        name: TodoPages.onboardingPath);
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(Icons.chevron_left, size: 35),
          onTap: () => setState(() {
            Navigator.pop(context);
          }),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            children: [
              Expanded(child: buildPage()),
              buildIndicator(),
              buildActionButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: const WormEffect(
        activeDotColor: TodoThemeManager.normalChipColor,
      ),
    );
  }

  Widget buildActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          onPressed: () {
            Provider.of<AppStateManager>(context, listen: false)
                .isOnBoardingScreen();
          },
          child: const Text(
            'Skip',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  Widget buildPage() {
    return PageView(
      physics: const ClampingScrollPhysics(),
      controller: controller,
      children: [
        buidOnboardingPageView(
            const AssetImage('assets/onboarding_screen/todo.png'),
            'Easy texting on your phone!'),
        buidOnboardingPageView(
            const AssetImage('assets/onboarding_screen/todo1.png'),
            'Remind you back anytime'),
        buidOnboardingPageView(
            const AssetImage('assets/onboarding_screen/todo2.png'),
            'Let note yourself'),
      ],
    );
  }

  Widget buidOnboardingPageView(ImageProvider imageProvider, String text) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30),
          Text(
            text,
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
    );
  }
}
