import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  ValueNotifier<int> selectedPageValueNotifier = ValueNotifier<int>(0);
  final analytics = Modular.get<CoffsyFirebaseAnalytics>();

  @override
  void initState() {
    super.initState();
    Modular.to.addListener(onChangeRoute);
  }

  void onChangeRoute() {
    final path = Modular.to.path;
    if (path.contains('movie_module')) {
      selectedPageValueNotifier.value = 0;
    }

    if (path.contains('tv_show')) {
      selectedPageValueNotifier.value = 1;
    }

    if (path.contains('line_chart')) {
      selectedPageValueNotifier.value = 2;
    }
  }

  @override
  void dispose() {
    Modular.to.removeListener(onChangeRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const RouterOutlet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'floatActionButton',
        onPressed: openTikTok,
        child: Icon(
          Icons.location_searching,
          color: ColorPalettes.white,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          primaryColor: Theme.of(context).colorScheme.secondary,
          textTheme: Theme.of(context).textTheme.copyWith(bodySmall: TextStyle(color: ColorPalettes.setActive)),
        ),
        child: StatefulBuilder(
          builder: (context, setState) => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: Sizes.dp8(context),
            child: ValueListenableBuilder(
              valueListenable: selectedPageValueNotifier,
              builder: (context, selectedPage, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    tooltip: 'movie',
                    color: selectedPage == 0 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                    icon: const Icon(Icons.movie_creation),
                    onPressed: () {
                      Modular.to.navigate('/dashboard/movie_module/');
                    },
                  ),
                  IconButton(
                    tooltip: 'tv_show',
                    color: selectedPage == 1 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                    icon: const Icon(Icons.live_tv),
                    onPressed: () {
                      Modular.to.navigate('/dashboard/tv_show/');
                    },
                  ),
                  IconButton(
                    tooltip: 'additional',
                    color: selectedPage == 2 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                    icon: const Icon(Icons.add_box_rounded),
                    onPressed: () {
                      Modular.to.navigate('/dashboard/line_chart/');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openTikTok() async {
    const tiktokScheme = 'snssdk1128://';
    const tiktokUrl = 'https://www.tiktok.com/';
    final tiktokUri = Uri.parse(tiktokScheme);

    if (await canLaunchUrl(tiktokUri)) {
      // Open TikTok app
      await launchUrl(tiktokUri);
    } else {
      // TikTok app not installed, open TikTok website
      await launchUrl(Uri.parse(tiktokUrl));
    }
  }
}
