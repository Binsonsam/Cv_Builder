import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/resume_model.dart';

class ResumeProvider extends ChangeNotifier {

  ResumeModel resume = ResumeModel(
    fullName: '',
    title: '',
    email: '',
    phone: '',
    location: '',
    summary: '',
    skills: [],
    education: [],
    experience: [],
    languages: [],
    projects: []
  );

  // ---------------- SAVE DATA ----------------
  Future<void> saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final educationJson =
    resume.education.map((e) => jsonEncode(e.toJson())).toList();


    prefs.setString('fullName', resume.fullName);
    prefs.setString('title', resume.title);
    prefs.setString('email', resume.email);
    prefs.setString('phone', resume.phone);
    prefs.setString('location', resume.location);
    prefs.setString('summary', resume.summary);

    prefs.setStringList('skills', resume.skills);
    prefs.setStringList('education', educationJson);
    prefs.setStringList('experience', resume.experience);
    prefs.setStringList('languages', resume.languages);

    final projectJson =
    resume.projects.map((p) => jsonEncode(p.toJson())).toList();

    prefs.setStringList('projects', projectJson);
  }

  // ---------------- LOAD DATA ----------------
  Future<void> loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final educationJson = prefs.getStringList('education') ?? [];


    resume.fullName = prefs.getString('fullName') ?? '';
    resume.title = prefs.getString('title') ?? '';
    resume.email = prefs.getString('email') ?? '';
    resume.phone = prefs.getString('phone') ?? '';
    resume.location = prefs.getString('location') ?? '';
    resume.summary = prefs.getString('summary') ?? '';

    resume.skills = prefs.getStringList('skills') ?? [];
    resume.education = educationJson
        .map((e) => EducationModel.fromJson(jsonDecode(e)))
        .toList();
    resume.experience = prefs.getStringList('experience') ?? [];
    resume.languages = prefs.getStringList('languages') ?? [];

    final projectJson = prefs.getStringList('projects') ?? [];

    resume.projects = projectJson
        .map((p) => ProjectModel.fromJson(jsonDecode(p)))
        .toList();

    notifyListeners();
  }

  // ---------------- UPDATE FUNCTIONS ----------------
  void updatePersonalInfo({
    required String fullName,
    required String title,
    required String email,
    required String phone,
    required String location,
    required String summary,
  }) {
    resume.fullName = fullName;
    resume.title = title;
    resume.email = email;
    resume.phone = phone;
    resume.location = location;
    resume.summary = summary;
    notifyListeners();
  }

  void updateSkills(List<String> skills) {
    resume.skills = skills;
    notifyListeners();
  }

  void updateEducation(List<EducationModel> education) {
    resume.education = education;
    notifyListeners();
  }


  void updateExperience(List<String> exp) {
    resume.experience = exp;
    notifyListeners();
  }

  void updateLanguages(List<String> langs) {
    resume.languages = langs;
    notifyListeners();
  }

  void updateProjects(List<ProjectModel> newProjects) {
    resume.projects = newProjects;
    notifyListeners();
  }

  void resetResume() {
    resume = ResumeModel(
      fullName: '',
      title: '',
      email: '',
      phone: '',
      location: '',
      summary: '',
      skills: [],
      education: [],
      experience: [],
      languages: [],
      projects: [],
    );

    notifyListeners();
  }



  void clearResume() async {
    resume = ResumeModel(
      fullName: '',
      title: '',
      email: '',
      phone: '',
      location: '',
      summary: '',
      skills: [],
      education: [],
      experience: [],
      languages: [],
      projects: [
        ProjectModel(title: '', tech: '', points: [])
      ]
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('fullName');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('location');
    await prefs.remove('summary');
    await prefs.remove('skills');
    await prefs.remove('education');
    await prefs.remove('experience');
    await prefs.remove('languages');
    await prefs.clear();
    notifyListeners();
  }



  // ------------- For HomePage preview -------------
  bool get hasResumeData {
    return resume.fullName.isNotEmpty ||
        resume.email.isNotEmpty ||
        resume.skills.isNotEmpty ||
        resume.experience.isNotEmpty ||
        resume.education.isNotEmpty;
  }
}
