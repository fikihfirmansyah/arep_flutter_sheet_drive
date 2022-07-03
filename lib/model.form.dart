class FeedbackForm {
  String _NAMA;
  String _TEMPATTANGGALLAHIR;
  String _ALAMAT;
  String _JUMLAHPINJAMAN;

  FeedbackForm(
      this._NAMA, this._TEMPATTANGGALLAHIR, this._JUMLAHPINJAMAN, this._ALAMAT);

  // Method to make GET parameters.
  String toParams() =>
      "?NAMA=$_NAMA&TEMPATTANGGALLAHIR=$_TEMPATTANGGALLAHIR&ALAMAT=$_ALAMAT&JUMLAHPINJAMAN=$_JUMLAHPINJAMAN";
}
