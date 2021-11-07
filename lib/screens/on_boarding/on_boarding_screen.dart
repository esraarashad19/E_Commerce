import 'package:e_commerce_app/app_localization.dart';
import 'package:e_commerce_app/layout/main_layout.dart';
import 'package:e_commerce_app/screens/user_signing/login/login_screen.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ObBoardingScreen extends StatefulWidget {
  @override
  _ObBoardingScreenState createState() => _ObBoardingScreenState();
}

class _ObBoardingScreenState extends State<ObBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              navigateAndFinish(
                context: context,
                nextScreen: MainLayout(),
              );
            },
            child: Text(AppLocalizations.of(context)!.translate('SKIP')!),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(
                  boarders[index],
                  context,
                ),
                onPageChanged: (index) {
                  if (index == (boarders.length - 1)) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemCount: boarders.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarders.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    dotColor: Colors.grey,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(
                        context: context,
                        nextScreen: MainLayout(),
                      );
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model, BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            height: 380,
            width: double.infinity,
            image: AssetImage(
              model.image,
            ),
            //fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.translate(model.title)!,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.translate(model.body)!,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );

class BoardingModel {
  late String image;
  late String title;
  late String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

List<BoardingModel> boarders = [
  BoardingModel(
    image: 'assets/images/p4.jpg',
    title: 'Screen Title 1',
    body: 'Screen Body 1',
  ),
  BoardingModel(
    image: 'assets/images/p7.jpg',
    title: 'Screen Title 2',
    body: 'Screen Body 2',
  ),
  BoardingModel(
    image: 'assets/images/p5.jpg',
    title: 'Screen Title 3',
    body: 'Screen Body 3',
  ),
];
