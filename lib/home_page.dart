import 'package:ats_friendly_cv_maker_app/Resume_Add/template.dart' show TemplatePage;
import 'package:ats_friendly_cv_maker_app/color.dart';
import 'package:ats_friendly_cv_maker_app/Resume_Add/new_resume.dart';
import 'package:ats_friendly_cv_maker_app/models/resume_model.dart';
import 'package:ats_friendly_cv_maker_app/providers/resume_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    final resume = Provider.of<ResumeProvider>(context);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('   CV Builder',
          style: TextStyle(color: Appcolors.primaryBlue,fontWeight: FontWeight.w600),),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 30,),
              const Text('Welcome, ',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),),
            ],
          ),
          SizedBox(height: 5,),
          const Text('Create a resume within simple steps.',style: TextStyle(fontSize: 16),),
          SizedBox(height: 15,),
          ElevatedButton(
              onPressed: (){
                final provider = Provider.of<ResumeProvider>(context, listen: false);

                provider.clearResume();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewResume()));
              },
              child: const Text('Start new Resume',
                style: TextStyle(color: Appcolors.navyText,fontSize: 19,fontWeight: FontWeight.w600),)),
          SizedBox(height: 40,),
          Column(
            children: [
              resume.hasResumeData
                  ? ResumePreviewCard(resume: resume.resume)
                  : const Text(
                "No resume edited yet",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class ResumePreviewCard extends StatelessWidget {
  final ResumeModel resume;


  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Resume?"),
          content: const Text("Are you sure you want to delete your saved resume?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ResumeProvider>(context, listen: false).clearResume();
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }


  const ResumePreviewCard({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => TemplatePage()));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(), // keeps alignment clean

                // Edit BUTTON
                GestureDetector(
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (_)=>NewResume()));
                  },
                  child: const Icon(Icons.edit, color: Colors.black, size: 24),
                ),

                SizedBox(width: 10,),

                // DELETE BUTTON
                GestureDetector(
                  onTap: () {
                    _showDeleteDialog(context);
                  },
                  child: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 5),

            Text(resume.fullName,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(resume.email),
            Text(resume.phone),
            const SizedBox(height: 10),
            Text("Skills:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(resume.skills.take(3).join(", ")),
          ],
        ),
      ),
    );
  }
}

