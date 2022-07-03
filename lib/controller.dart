import 'dart:convert' as convert;
import 'package:arep_flutter_sheet_drive/model.form.dart';
import 'package:http/http.dart' as http;

class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL =
      "https://script.google.com/macros/s/AKfycbzqH-kFlVotCF7hR1zOE_lAQQD_Zd1b1IfbmyP18h_obDoMD5ONZd2hMZthTTDCMDcnXA/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    try {
      var uri = Uri.parse(URL + feedbackForm.toParams());
      await http.get(uri).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}
