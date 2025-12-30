import 'package:ats_friendly_cv_maker_app/color.dart';
import 'package:ats_friendly_cv_maker_app/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin{

  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;

  @override
  void initState(){
    super.initState();

    _controller = AnimationController(vsync: this,
    duration: Duration(microseconds: 900));

    _fadeAnim = CurvedAnimation(parent: _controller,
        curve: Curves.easeOut);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const OnBoardingScreen()));
    });
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FadeTransition(
        opacity: _fadeAnim,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 160),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Appcolors.primaryBlue,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: Offset(0, 6)
                    )
                  ]
                ),
                child: Icon(Icons.description_rounded,
                size: 56,
                color: Colors.white,),
              ),
             const SizedBox(height: 10,),
              Text('ATS Friendly CV Maker',
                style: TextStyle(
                    color: Appcolors.navyText,
                    fontWeight: FontWeight.w600,
                fontSize: 20),),
              SizedBox(height: 10,),
              Text('Easy way to make a CV',
                style: TextStyle(
                color: Appcolors.slateText,
                  fontSize: 16,
                  fontWeight: FontWeight.w400
              ),),
              SizedBox(height: 45,),
              SizedBox(
                height: 32,width: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(Appcolors.primaryBlue),
                ),
              ),
              SizedBox(height: 10,),
              Text('Loading...',style: GoogleFonts.inter(
                fontSize: 12,
              ),),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),),
    ));
  }
}
