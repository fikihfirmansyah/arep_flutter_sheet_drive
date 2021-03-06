import 'dart:io';
import 'package:arep_flutter_sheet_drive/page/home_page.dart';
import 'package:arep_flutter_sheet_drive/provider/upload_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'service/service_cloud_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:material_color_generator/material_color_generator.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UploadProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        title: 'PINJAMAN ONLINE',
        theme: ThemeData(
          primarySwatch:
              generateMaterialColor(color: Color.fromARGB(255, 15, 57, 35)),
        ),
        home: const HomePage(),
      ),
    );
  }
}
