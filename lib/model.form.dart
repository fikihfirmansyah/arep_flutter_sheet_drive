class FeedbackForm {
  String _NAMA;
  String _TEMPATTANGGALLAHIR;
  String _ALAMAT;
  String _JUMLAHPINJAMAN;
  String _PHOTOKTP;
  String _SELFHIEKTP;

  FeedbackForm(
      this._NAMA, this._TEMPATTANGGALLAHIR, this._JUMLAHPINJAMAN, this._ALAMAT,this._PHOTOKTP,this._SELFHIEKTP);

  // Method to make GET parameters.
  String toParams() =>
      "?NAMA=$_NAMA&TEMPATTANGGALLAHIR=$_TEMPATTANGGALLAHIR&ALAMAT=$_ALAMAT&JUMLAHPINJAMAN=$_JUMLAHPINJAMAN&FOTOKTP=$_PHOTOKTP&SELFIEKTP=$_SELFHIEKTP";
}
