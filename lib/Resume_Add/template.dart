import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../models/resume_model.dart';
import '../providers/resume_provider.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({super.key});

  // 1️⃣ SHARE PDF
  Future<void> _sharePDF(BuildContext context) async {
    final resume = Provider.of<ResumeProvider>(context, listen: false).resume;

    final pdf = pw.Document();



    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        build: (context) => buildPdfContent(resume),
      ),
    );

    final bytes = await pdf.save();
    await Printing.sharePdf(bytes: bytes, filename: "resume.pdf");
  }

  // 2️⃣ PDF CONTENT BUILDER (MATCHES UI EXACTLY)
  List<pw.Widget> buildPdfContent(ResumeModel resume,) {
    return [
      /// NAME + TITLE
      pw.Center(
        child: pw.Column(
          children: [
            pw.SizedBox(height: 10),
            pw.Text(
              resume.fullName.isEmpty ? "No Name" : resume.fullName,
              style: pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 6),
            pw.Text(
              resume.title,
              style: pw.TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),

      pw.SizedBox(height: 20),

      /// CONTACT ROW
      pw.Wrap(
        alignment: pw.WrapAlignment.center,
        spacing: 40,
        runSpacing: 12,
        children: [
          pw.Row(children: [
    pw.Text("Phone: "),
            pw.SizedBox(width: 4),
            pw.Text(resume.phone, style: pw.TextStyle(fontSize: 14)),
          ]),

          pw.Row(children: [
    pw.Text("Email: "),
            pw.SizedBox(width: 4),
            pw.Text(resume.email, style: pw.TextStyle(fontSize: 14)),
          ]),

          pw.Row(children: [
    pw.Text("Location: "),
            pw.SizedBox(width: 4),
            pw.Text(resume.location, style: pw.TextStyle(fontSize: 14)),
          ]),
        ],
      ),



      pw.Divider(),
      pw.SizedBox(height: 20),

      /// SUMMARY
      _pdfSectionTitle("Profile Summary"),
      pw.SizedBox(height: 8),
      pw.Text(
        resume.summary.isEmpty ? "No summary added." : resume.summary,
        style: pw.TextStyle(fontSize: 14, height: 1.6),
      ),
      pw.Divider(),

      /// SKILLS
      _pdfSectionTitle("Skills"),
      pw.SizedBox(height: 10),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: resume.skills.map((s) => pw.Text("- $s")).toList(),
      ),
      pw.Divider(),

      /// PROJECTS
      _pdfSectionTitle("Projects"),
      pw.SizedBox(height: 12),
      ...resume.projects.map((p) => _pdfProjectItem(p)),
      pw.Divider(),

      /// EXPERIENCE
      _pdfSectionTitle("Experience"),
      pw.SizedBox(height: 10),
      ...resume.experience.map((e) => pw.Text("- $e")),
      pw.Divider(),

      /// EDUCATION
      _pdfSectionTitle("Education"),
      pw.SizedBox(height: 10),

      pw.Column(
        children: resume.education.map((e) {
          return pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // LEFT SIDE – EDUCATION
                pw.Expanded(
                  child: pw.Text(
                    "- ${e.title}",
                    style: pw.TextStyle(fontSize: 14),
                  ),
                ),

                // RIGHT SIDE – YEAR
                pw.Text(
                  e.year,
                  style: pw.TextStyle(fontSize: 13),
                ),
              ],
            ),
          );
        }).toList(),
      ),

      pw.Divider(),


      /// LANGUAGES
      _pdfSectionTitle("Languages"),
      pw.SizedBox(height: 10),
      ...resume.languages.map((l) => pw.Text("- $l")),
      pw.SizedBox(height: 30),
    ];
  }

  // 3️⃣ PDF SECTION TITLE
  pw.Widget _pdfSectionTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
    );
  }

  // 4️⃣ PDF PROJECT ITEM
  pw.Widget _pdfProjectItem(ProjectModel p) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  p.title,
                  style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Text(
                p.tech,
                style: pw.TextStyle(fontSize: 13, fontStyle: pw.FontStyle.italic),
              ),
              pw.SizedBox(width: 10),
              pw.Row(
                children: [
                  if (p.liveLink != null && p.liveLink!.isNotEmpty)
                    _pdfBadge("Live"),
                  if (p.githubLink != null && p.githubLink!.isNotEmpty)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 6),
                      child: _pdfBadge("GitHub"),
                    ),
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 10),

          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: p.points
                .where((pt) => pt.trim().isNotEmpty)
                .map((pt)
              {
              return pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("- ", style: pw.TextStyle(fontSize: 16)),
                  pw.Expanded(
                    child: pw.Text(
                      pt,
                      style: pw.TextStyle(fontSize: 13.5, height: 1.4),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // 5️⃣ PDF BADGE
  pw.Widget _pdfBadge(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 12)),
    );
  }

  // 6️⃣ FLUTTER UI
  @override
  Widget build(BuildContext context) {
    final resume = Provider.of<ResumeProvider>(context).resume;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _sharePDF(context),
        label: const Text('Share PDF'),
        icon: const Icon(Icons.share),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// NAME + TITLE
            Center(
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Text(
                    resume.fullName.isEmpty ? "No Name" : resume.fullName,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    resume.title ?? "Your Role (Flutter Developer)",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// CONTACT ROW
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 12,
              children: [
                _contactItem(Icons.phone, resume.phone),
                _contactItem(Icons.email_outlined, resume.email),
                _contactItem(Icons.location_on_outlined, resume.location),
              ],
            ),

            Divider(thickness: 2),
            SizedBox(height: 30),

            /// SUMMARY
            _sectionTitle("Profile Summary"),
            SizedBox(height: 8),
            Text(
              resume.summary.isEmpty ? "No summary added." : resume.summary,
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
            Divider(),
            SizedBox(height: 10),

            /// SKILLS
            _sectionTitle("Skills"),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              resume.skills.map((s) => Text("- $s", style: TextStyle(fontSize: 14))).toList(),
            ),
            Divider(),
            SizedBox(height: 10),

            /// PROJECTS
            _sectionTitle("Projects"),
            SizedBox(height: 12),
            for (var p in resume.projects) _projectItem(p),
            Divider(),
            SizedBox(height: 10),

            /// EXPERIENCE
            _sectionTitle("Experience"),
            SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              resume.experience.map((e) => Text("- $e", style: TextStyle(fontSize: 14))).toList(),
            ),
            Divider(),
            SizedBox(height: 10),

            /// EDUCATION
            _sectionTitle("Education"),
            SizedBox(height: 14),

            Column(
              children: resume.education.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LEFT – EDUCATION
                      Expanded(
                        child: Text(
                          "- ${e.title}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),

                      // RIGHT – YEAR
                      Text(
                        e.year,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Divider(),
            SizedBox(height: 10),

            Divider(),
            SizedBox(height: 10),

            /// LANGUAGES
            _sectionTitle("Languages"),
            SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              resume.languages.map((l) => Text("- $l", style: TextStyle(fontSize: 14))).toList(),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 7️⃣ UI HELPERS
  Widget _contactItem(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        SizedBox(width: 6),
        Text(value, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _projectItem(ProjectModel p) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE + TECH + BADGES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  p.title,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                p.tech,
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
              SizedBox(width: 10),
              Row(
                children: [
                  if (p.liveLink != null && p.liveLink!.isNotEmpty) _badge("Live"),
                  if (p.githubLink != null && p.githubLink!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: _badge("GitHub"),
                    ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),

          /// BULLETS
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: p.points
                .where((pt) => pt.trim().isNotEmpty)
                .map((pt)
              {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("- ", style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        pt,
                        style: TextStyle(fontSize: 13.5, height: 1.4),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 12)),
    );
  }
}
