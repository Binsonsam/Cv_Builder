import 'package:ats_friendly_cv_maker_app/color.dart';
import 'package:ats_friendly_cv_maker_app/home_page.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pagecontroller = PageController();
  int currentIndex = 0;
  final List<Map<String,String>> Pages = [
    {
      "title": "Welcome to Single click resume",
      "subtitle": "Export ur cv",
      "images": "assets/istockphoto-644186760-612x612.jpg"
    },
{
"title": "About to Start",
"subtitle": "Click on get started",
"images": "assets/istockphoto-644186760-612x612.jpg"
},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: Pages.length,
              controller: _pagecontroller,
                itemBuilder: (context, index){
              return Column(
                children: [
                  SizedBox(height: 40,),
                  SizedBox(
                    height: 280,
                    child: Image.asset(Pages[index]["images"]!),
                  ),
                  Text(Pages[index]["title"]!,
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22,color: Appcolors.navyText),),
                  Text(Pages[index]["subtitle"]!,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Appcolors.successGreen),),
                ],
              );
            }),
          ),
          SizedBox(height: 40),
          Row(
            children: List.generate(Pages.length,
                (index)=> AnimatedContainer(duration: Duration(milliseconds: 300),
                  width: currentIndex == index ? 38:8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Appcolors.primaryBlue : Colors.grey,
                  ),
                )),
          ),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
              child: Text('Get Started')),
          SizedBox(height: 30,)
        ],
      )),
    );
  }
}
