import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'service_cloud_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PINJAMAN ONLINE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///
  ///
  /// UI WIDGETS
  /// UI WIDGETS
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final ServiceCloudStorage storage = ServiceCloudStorage();
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Data'),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg'],
                  );
                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No file selected')));
                  }
                  final path = results!.files.single.path!;
                  final fileName = results.files.single.name;

                  storage
                      .uploadFile(path, fileName)
                      .then((value) => print('Done'));
                },
                child: Text('Upload Data'),
              ),
            ),
            FutureBuilder(
                future: storage.listFiles(),
                builder: (BuildContext context,
                    AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      child: ListView.builder(
                        itemCount: snapshot.data!.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data!.items[index].name),
                          );
                        },
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Container();
                }),
            // FutureBuilder(
            //   future: storage
            //       .downloadURL('053b9dda-a5ba-11ec-8b63-027b6c569736.png'),
            //   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done &&
            //         snapshot.hasData) {
            //       return Container(
            //           width: 300,
            //           height: 250,
            //           child: Image.network(snapshot.data!, fit: BoxFit.cover));
            //     }
            //     if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            //       return CircularProgressIndicator();
            //     }
            //     return Container();
            //   },
            // )
          ],
        ));
  }

  ///
  ///
  /// UI WIDGETS
  /// UI WIDGETS
  ///
  ///
}
