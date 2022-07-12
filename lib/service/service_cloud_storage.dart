import 'dart:io';
import 'package:arep_flutter_sheet_drive/controller.dart';
import 'package:arep_flutter_sheet_drive/model.form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServiceCloudStorage {
  Reference ref = FirebaseStorage.instance.ref();

  Future<bool> saveBerkas({
    required File fotoKTP,
    required File selfieKTP,
    required String nama,
    required String tempatLahir,
    required String alamat,
    required int jumlahPinjaman,
  }) async {

    try{

      String urlFotoKtp = await simpanGambar(gambar: fotoKTP);
      String urlFotoSelfhie = await simpanGambar(gambar: selfieKTP);

      FeedbackForm feedbackForm = FeedbackForm(
          nama,
          tempatLahir,
          jumlahPinjaman.toString(),
          alamat,
          urlFotoKtp,
          urlFotoSelfhie
      );

      FormController formController = FormController((String response) {
        print("Response: $response");
      });

      formController.submitForm(feedbackForm);

      return true;
    }catch(e){
      throw e;
    }

  }

  Future<String> simpanGambar({
    required File gambar,
  }) async {
    try {
      final metadata = SettableMetadata(
        customMetadata: {'picked-file-path': gambar.path},
      );

      String fileName =
          "${DateTime.now().millisecond}-${DateTime.now().minute}-${DateTime.now().hour}-${DateTime.now().day}-${DateTime.now().month}-buku";
      fileName += gambar.path.split('/').last;
      var result = await ref.child(fileName).putFile(gambar, metadata);
      result.ref.getDownloadURL();

      String path = await result.ref.getDownloadURL();
      print(path);
      return path;
    } catch (e) {
      throw e;
    }
  }
}
