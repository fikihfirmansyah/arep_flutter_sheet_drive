import 'dart:io';

import 'package:arep_flutter_sheet_drive/provider/upload_provider.dart';
import 'package:arep_flutter_sheet_drive/widget/custom_form.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../service/service_cloud_storage.dart';
import '../widget/button_picker.dart';
import '../widget/button_rounded.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? fotoKTP = null;
  File? selfieKTP = null;
  String? nama = null;
  String? tempatLahir = null;
  String? alamat = null;
  int? jumlahPinjaman = null;

  @override
  Widget build(BuildContext context) {
    final ServiceCloudStorage storage = ServiceCloudStorage();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Data'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer<UploadProvider>(builder: (context, valueUpload, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                InputFieldRounded(
                  hint: "Nama",
                  onChange: (val) {
                    nama = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Tempat Lahir",
                  onChange: (val) {
                    tempatLahir = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Alamat",
                  onChange: (val) {
                    alamat = val;
                  },
                  secureText: false,
                ),
                InputFieldRounded(
                  hint: "Jumlah Pinjaman",
                  onChange: (val) {
                    jumlahPinjaman = int.parse(val);
                  },
                  secureText: false,
                ),
                fotoKTP != null
                    ? Container(
                        margin: EdgeInsets.only(top: 15, bottom: 30),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(fotoKTP!),
                          ),
                        ),
                      )
                    : ButtonPicker(
                        title: "Photo KTP",
                        onTap: () => doPhotoKTP(),
                      ),
                selfieKTP != null
                    ? Container(
                        margin: EdgeInsets.only(top: 15, bottom: 30),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(selfieKTP!),
                          ),
                        ),
                      )
                    : ButtonPicker(
                        title: "Selfhie KTP",
                        onTap: () => doPhotoSelfhie(),
                      ),
                ButtonRounded(
                  text: "Upload Berkas",
                  onPressed: () => doUploadBerkas(context),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  doPhotoSelfhie() async {
    ImagePicker? _imagePicker = ImagePicker();

    XFile? result = await _imagePicker.pickImage(source: ImageSource.camera);

    if (result != null) {
      setState(() {
        selfieKTP = File(result.path);
      });
    } else {
      // User canceled the picker
    }
  }

  doPhotoKTP() async {
    ImagePicker? _imagePicker = ImagePicker();

    XFile? result = await _imagePicker.pickImage(source: ImageSource.camera);

    if (result != null) {
      setState(() {
        fotoKTP = File(result.path);
      });
    } else {
      // User canceled the picker
    }
  }

  doUploadBerkas(BuildContext context) async {
    if (fotoKTP != null &&
        selfieKTP != null &&
        nama != null &&
        tempatLahir != null &&
        alamat != null &&
        jumlahPinjaman != null) {
      EasyLoading.show(status: "Loading");

      var result = await Provider.of<UploadProvider>(context, listen: false)
          .doUploadBerkas(
              fotoKTP: fotoKTP!,
              selfieKTP: selfieKTP!,
              nama: nama!,
              tempatLahir: tempatLahir!,
              alamat: alamat!,
              jumlahPinjaman: jumlahPinjaman!);

      EasyLoading.dismiss();
      if (result) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Success",
          desc: "Berhasil upload berkas",
          buttons: [
            DialogButton(
              onPressed: (){
                setState(() {
                  fotoKTP = null;
                  selfieKTP = null;
                  nama = null;
                  tempatLahir = null;
                  alamat = null;
                  jumlahPinjaman = null;
                });
                Navigator.pop(context);
              },
              radius: BorderRadius.circular(0.0),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ).show();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Gagal upload berkas",
          desc: "Something went wrong",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              radius: BorderRadius.circular(0.0),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ).show();
      }
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Gagal upload berkas",
        desc: "Harap isi seluruh formulir",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            radius: BorderRadius.circular(0.0),
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ).show();
    }
  }
}
