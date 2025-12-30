import 'package:ats_friendly_cv_maker_app/Resume_Add/template.dart';
import 'package:ats_friendly_cv_maker_app/color.dart';
import 'package:ats_friendly_cv_maker_app/models/resume_model.dart';
import 'package:ats_friendly_cv_maker_app/providers/resume_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewResume extends StatefulWidget {
  const NewResume({super.key});

  @override
  State<NewResume> createState() => _NewResumeState();
}

class _NewResumeState extends State<NewResume> {


  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();

  List<TextEditingController> skillsControllers = [TextEditingController()];
  List<TextEditingController> languageControllers = [TextEditingController()];


  List<TextEditingController> experienceControllers = [TextEditingController()];

  // ---------- PROJECT FIELDS ----------
  List<TextEditingController> projectTitleControllers = [TextEditingController()];
  List<TextEditingController> projectTechControllers = [TextEditingController()];
  List<TextEditingController> projectGithubControllers = [TextEditingController()];
  List<TextEditingController> projectLiveControllers = [TextEditingController()];

  List<List<TextEditingController>> projectPointsControllers = [
    [TextEditingController()]
  ];

  List<TextEditingController> educationTitleControllers = [TextEditingController()];
  List<TextEditingController> educationYearControllers = [TextEditingController()];



  @override
  void initState() {
    super.initState();

    final resume = Provider
        .of<ResumeProvider>(context, listen: false)
        .resume;

    // PERSONAL INFO
    fullNameController.text = resume.fullName;
    titleController.text = resume.title;
    emailController.text = resume.email;
    phoneController.text = resume.phone;
    locationController.text = resume.location;
    summaryController.text = resume.summary;

    // ---------- SKILLS ----------
    skillsControllers = resume.skills.isNotEmpty
        ? resume.skills.map((s) => TextEditingController(text: s)).toList()
        : [TextEditingController()];

    // ---------- EDUCATION ----------
    educationTitleControllers = resume.education.isNotEmpty
        ? resume.education
        .map((e) => TextEditingController(text: e.title))
        .toList()
        : [TextEditingController()];

    educationYearControllers = resume.education.isNotEmpty
        ? resume.education
        .map((e) => TextEditingController(text: e.year))
        .toList()
        : [TextEditingController()];


    // ---------- EXPERIENCE ----------
    experienceControllers = resume.experience.isNotEmpty
        ? resume.experience.map((e) => TextEditingController(text: e)).toList()
        : [TextEditingController()];

    // ---------- LANGUAGES ----------
    languageControllers = resume.languages.isNotEmpty
        ? resume.languages.map((l) => TextEditingController(text: l)).toList()
        : [TextEditingController()];

    // ---------- PROJECTS ----------
    if (resume.projects.isEmpty) {
      projectTitleControllers = [TextEditingController()];
      projectTechControllers = [TextEditingController()];
      projectGithubControllers = [TextEditingController()];
      projectLiveControllers = [TextEditingController()];
      projectPointsControllers = [
        [TextEditingController()]
      ];
    } else {
      projectTitleControllers =
          resume.projects.map((p) => TextEditingController(text: p.title)).toList();

      projectTechControllers =
          resume.projects.map((p) => TextEditingController(text: p.tech)).toList();

      projectGithubControllers =
          resume.projects.map((p) => TextEditingController(text: p.githubLink)).toList();

      projectLiveControllers =
          resume.projects.map((p) => TextEditingController(text: p.liveLink)).toList();

      projectPointsControllers = resume.projects.map(
            (p) => p.points.isNotEmpty
            ? p.points.map((pt) => TextEditingController(text: pt)).toList()
            : [TextEditingController()],
      ).toList();
    }
  }


  @override
  void dispose() {
  fullNameController.dispose();
  emailController.dispose();
  phoneController.dispose();
  locationController.dispose();
  super.dispose();
  }

  void addEducationBox() {
    setState(() {
      educationTitleControllers.add(TextEditingController());
      educationYearControllers.add(TextEditingController());
    });
  }

  void deleteEducationBox(int index) {
    setState(() {
      educationTitleControllers[index].dispose();
      educationYearControllers[index].dispose();
      educationTitleControllers.removeAt(index);
      educationYearControllers.removeAt(index);
    });
  }


  void addExperienceBox() {
    setState(() {
      experienceControllers.add(TextEditingController());
    });
  }

  void deleteExperienceBox(int index) {
    setState(() {
      experienceControllers[index].dispose();
      experienceControllers.removeAt(index);
    });
  }

  void addSkillBox() {
    setState(() {
      skillsControllers.add(TextEditingController());
    });
  }

  void deleteSkillBox(int index) {
    setState(() {
      skillsControllers[index].dispose();
      skillsControllers.removeAt(index);
    });
  }

  void addLanguageBox() {
    setState(() {
      languageControllers.add(TextEditingController());
    });
  }

  void deleteLanguageBox(int index) {
    setState(() {
      languageControllers[index].dispose();
      languageControllers.removeAt(index);
    });
  }


  void addProject() {
    setState(() {
      projectTitleControllers.add(TextEditingController());
      projectTechControllers.add(TextEditingController());
      projectGithubControllers.add(TextEditingController());
      projectLiveControllers.add(TextEditingController());
      projectPointsControllers.add([TextEditingController()]);
    });
  }

  void deleteProject(int index) {
    setState(() {
      projectTitleControllers[index].dispose();
      projectTechControllers[index].dispose();
      projectGithubControllers[index].dispose();
      projectLiveControllers[index].dispose();

      for (var c in projectPointsControllers[index]) {
        c.dispose();
      }

      projectTitleControllers.removeAt(index);
      projectTechControllers.removeAt(index);
      projectGithubControllers.removeAt(index);
      projectLiveControllers.removeAt(index);
      projectPointsControllers.removeAt(index);
    });
  }

  void addProjectPoint(int projectIndex) {
    setState(() {
      projectPointsControllers[projectIndex].add(TextEditingController());
    });
  }

  void deleteProjectPoint(int projectIndex, int pointIndex) {
    setState(() {
      projectPointsControllers[projectIndex][pointIndex].dispose();
      projectPointsControllers[projectIndex].removeAt(pointIndex);
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:const Text('  New Resume',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Personal Information',
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
              SizedBox(height: 10,),

              SizedBox(height: 10,),
              Text('Full Name',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                )
              ),
              SizedBox(height: 10),
              Text('title',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  )
              ),
              SizedBox(height: 10,),
              Text('Email',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              TextField(
                controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  )
              ),
              SizedBox(height: 10,),
              Text('Phone Number',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              TextField(
                controller: phoneController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  )
              ),
              SizedBox(height: 10,),
              Text('Location',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              TextField(
                controller: locationController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  )
              ),
              SizedBox(height: 10,),
              Text('Summary',
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              TextField(
                maxLines: 5,
                  controller: summaryController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  )
              ),
              SizedBox(height: 10,),
              Text(
                "Skills",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              Column(
                children: List.generate(skillsControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: skillsControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Skill ${index + 1}",
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        if (skillsControllers.length > 1)
                          GestureDetector(
                            onTap: () => deleteSkillBox(index),
                            child: Icon(Icons.delete, color: Colors.red, size: 26),
                          ),
                      ],
                    ),
                  );
                }),
              ),

              TextButton.icon(
                onPressed: addSkillBox,
                icon: Icon(Icons.add,color: Appcolors.slateText,),
                label: Text("Add More Skills",style: TextStyle(color: Appcolors.slateText),),
              ),

              SizedBox(height: 10,),


              Text(
                "Education",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              Column(
                children: List.generate(educationTitleControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: educationTitleControllers[index],
                            decoration: InputDecoration(
                              labelText: "Education",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: educationYearControllers[index],
                            decoration: InputDecoration(
                              labelText: "Year",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        if (educationTitleControllers.length > 1)
                          GestureDetector(
                            onTap: () => deleteEducationBox(index),
                            child: const Icon(Icons.delete, color: Colors.red, size: 28),
                          ),
                      ],
                    ),
                  );
                }),
              ),

              TextButton.icon(
                onPressed: addEducationBox,
                icon: Icon(Icons.add,color: Appcolors.slateText,),
                label: Text("Add More Education",style: TextStyle(color: Appcolors.slateText),),
              ),


              SizedBox(height: 10,),

              SizedBox(height: 10,),
              Text(
                "Projects",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              Column(
                children: List.generate(projectTitleControllers.length, (index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ---------- PROJECT TITLE ----------
                          TextField(
                            controller: projectTitleControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Project Title",
                            ),
                          ),
                          SizedBox(height: 10),

                          // ---------- TECH STACK ----------
                          TextField(
                            controller: projectTechControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Role",
                            ),
                          ),
                          SizedBox(height: 10),

                          // ---------- LIVE LINK ----------
                          TextField(
                            controller: projectLiveControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Live Link",
                            ),
                          ),
                          SizedBox(height: 10),

                          // ---------- GITHUB LINK ----------
                          TextField(
                            controller: projectGithubControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "GitHub Link",
                            ),
                          ),

                          SizedBox(height: 14),
                          Text("Bullet Points",
                              style: TextStyle(fontWeight: FontWeight.w600)),

                          Column(
                            children: List.generate(projectPointsControllers[index].length, (pIndex) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: TextField(
                                        controller: projectPointsControllers[index][pIndex],
                                        decoration: InputDecoration(
                                          labelText: "Point ${pIndex + 1}",
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  if (projectPointsControllers[index].length > 1)
                                    GestureDetector(
                                      onTap: () => deleteProjectPoint(index, pIndex),
                                      child: Icon(Icons.delete, color: Colors.red),
                                    ),
                                ],
                              );
                            }),
                          ),

                          TextButton.icon(
                            onPressed: () => addProjectPoint(index),
                            icon: Icon(Icons.add),
                            label: Text("Add Bullet Point"),
                          ),

                          // DELETE PROJECT
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => deleteProject(index),
                              icon: Icon(Icons.delete, color: Colors.red),
                              label: Text("Delete Project"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              TextButton.icon(
                onPressed: addProject,
                icon: Icon(Icons.add, color: Appcolors.slateText),
                label: Text("Add Project", style: TextStyle(color: Appcolors.slateText)),
              ),

              SizedBox(height: 10,),

              Text(
                "Experience",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              Column(
                children: List.generate(experienceControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: experienceControllers[index],
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Experience ${index + 1}",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (experienceControllers.length > 1)
                          GestureDetector(
                            onTap: () => deleteExperienceBox(index),
                            child: const Icon(Icons.delete, color: Colors.red, size: 28),
                          ),
                      ],
                    ),
                  );
                }),
              ),

              TextButton.icon(
                onPressed: addExperienceBox,
                icon: Icon(Icons.add,color: Appcolors.slateText,),
                label: Text("Add More Experience",style: TextStyle(color: Appcolors.slateText),),
              ),



              SizedBox(height: 10,),
              Text(
                "Languages",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              Column(
                children: List.generate(languageControllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: languageControllers[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Language  ${index + 1}",
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        if (languageControllers.length > 1)
                          GestureDetector(
                            onTap: () => deleteLanguageBox(index),
                            child: Icon(Icons.delete, color: Colors.red, size: 26),
                          ),
                      ],
                    ),
                  );
                }),
              ),

              TextButton.icon(
                onPressed: addLanguageBox,
                icon: Icon(Icons.add,color: Appcolors.slateText,),
                label: Text("Add More Languages",style: TextStyle(color: Appcolors.slateText),),
              ),

              Center(
                child: ElevatedButton(
                  onPressed: () {

                    final provider = Provider.of<ResumeProvider>(context, listen: false);

                    provider.updatePersonalInfo(
                      fullName: fullNameController.text,
                      title: titleController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      location: locationController.text,
                      summary: summaryController.text
                    );

                    provider.updateSkills(
                        skillsControllers.map((c) => c.text).toList()
                    );

                    provider.updateEducation(
                      List.generate(educationTitleControllers.length, (i) {
                        return EducationModel(
                          title: educationTitleControllers[i].text,
                          year: educationYearControllers[i].text,
                        );
                      }),
                    );


                    provider.updateExperience(
                        experienceControllers.map((c) => c.text).toList()
                    );

                    provider.updateLanguages(
                        languageControllers.map((c) => c.text).toList()
                    );

                    provider.updateProjects(
                      List.generate(projectTitleControllers.length, (i) {
                        return ProjectModel(
                          title: projectTitleControllers[i].text,
                          tech: projectTechControllers[i].text,
                          githubLink: projectGithubControllers[i].text,
                          liveLink: projectLiveControllers[i].text,
                          points: projectPointsControllers[i]
                              .map((c) => c.text.trim())
                              .where((text) => text.isNotEmpty)
                              .toList(),
                        );
                      }),
                    );

                    provider.saveToLocal();



                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: Provider.of<ResumeProvider>(context, listen: false),
                          child: TemplatePage(),
                        ),
                      ),
                    );

                  }, child: Text('Save'),


                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
