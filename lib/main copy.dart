import 'package:flutter/material.dart';
import 'package:arep_flutter_sheet_drive/controller.dart';
import 'package:arep_flutter_sheet_drive/model.form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';
import 'package:file_picker/file_picker.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PINJAMAN ONLINE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ///
  ///
  /// FORM CONTROLLER
  /// FORM CONTROLLER
  ///
  ///
  /// Create a global key that uniquely identifies the Form widget
  /// and allows validation of the form.
  ///

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController NAMAController = TextEditingController();
  TextEditingController TEMPATTANGGALLAHIRController = TextEditingController();
  TextEditingController ALAMATController = TextEditingController();
  TextEditingController JUMLAHPINJAMANController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FeedbackForm feedbackForm = FeedbackForm(
          NAMAController.text,
          TEMPATTANGGALLAHIRController.text,
          ALAMATController.text,
          JUMLAHPINJAMANController.text);

      FormController formController = FormController((String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          //
          _showSnackbar("Feedback Submitted");
        } else {
          _showSnackbar("Error Occurred!");
        }
      });

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheet
      formController.submitForm(feedbackForm);
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  ///
  ///
  /// FORM CONTROLLER
  /// FORM CONTROLLER
  ///
  ///

  ///
  ///
  /// UI WIDGETS
  /// UI WIDGETS
  ///
  ///
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: NAMAController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid NAMA";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "NAMA"),
                    ),
                    TextFormField(
                      controller: TEMPATTANGGALLAHIRController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid TEMPAT TANGGAL LAHIR";
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: "TEMPAT TANGGAL LAHIR"),
                    ),
                    TextFormField(
                      controller: ALAMATController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid ALAMAT";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "ALAMAT"),
                    ),
                    TextFormField(
                      controller: JUMLAHPINJAMANController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Valid JUMLAH PINJAMAN";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "JUMLAH PINJAMAN"),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: _submitForm,
                      child: Text('Submit PINJAMAN'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///
  /// UI WIDGETS
  /// UI WIDGETS
  ///
  ///
}
