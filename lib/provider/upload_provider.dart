import 'dart:io';

import 'package:arep_flutter_sheet_drive/service/service_cloud_storage.dart';
import 'package:flutter/material.dart';

class UploadProvider extends ChangeNotifier {
  final serviceStorage = ServiceCloudStorage();

  Future<bool> doUploadBerkas({
    required File fotoKTP,
    required File selfieKTP,
    required String nama,
    required String tempatLahir,
    required String alamat,
    required int jumlahPinjaman,
  }) async {
    try {
     var result = await serviceStorage.saveBerkas(fotoKTP: fotoKTP,
          selfieKTP: selfieKTP,
          nama: nama,
          tempatLahir: tempatLahir,
          alamat: alamat,
          jumlahPinjaman: jumlahPinjaman);

      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

}