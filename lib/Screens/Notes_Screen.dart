import 'package:data_base/Models/Note_Models.dart';
import 'package:data_base/Screens/Note_Screen.dart';
import 'package:data_base/Services/Database_helper.dart';
import 'package:data_base/Widgets/Note_Widget.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => NoteScreen()));
            setState(() {});
          },
          child: Icon(
            Icons.add,
            size: 34,
          )),
      body: FutureBuilder<List<Note>?>(
        future: DatabaseHelper.getAllNotes(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(
                itemBuilder: (context, index) => NoteWidget(
                    note: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteScreen()));
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  Text("Are you sure you want to delete ?"),
                              actions: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () async {
                                      DatabaseHelper.deleteNote(
                                          snapshot.data![index]);
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Text("Yess")),
                                ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Nooo"))
                              ],
                            );
                          });
                    }),
                itemCount: snapshot.data!.length,
              );
            }
            return Center(
              child: Text(
                "Write Somethimg Here",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
