import 'package:data_base/Services/Database_helper.dart';
import 'package:flutter/material.dart';
import '../Models/Note_Models.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;
  NoteScreen({super.key, this.note});
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Something here' : 'Yes Its Right'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  "What Are You Thinking",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: TextFormField(
                controller: titleController,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'Write your Impotant Notes',
                    labelText: 'Are You Understand',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: TextFormField(
                controller: descriptionController,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                onChanged: (str) {},
                decoration: InputDecoration(
                  hintText: 'Write Your Important Notes',
                  labelText: 'Are You Understand',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: SizedBox(
                height: 35,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final title = titleController.value.text;
                    final description = descriptionController.value.text;
                    if (title.isEmpty || description.isEmpty) {
                      return null;
                    }
                    final Note model = Note(
                        id: note?.id, title: title, description: description);
                    if (note == null) {
                      await DatabaseHelper.addNote(model);
                    } else {
                      await DatabaseHelper.updateNote(model);
                    }
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(12)))),
                  child: Text(
                    note == null ? 'Save' : 'Edit',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
