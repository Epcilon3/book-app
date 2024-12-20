class ModelBook {
  final int id;
  final String judul, pengarang, penerbit, kategori, sinopsis, tanggal_terbit;
  ModelBook({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.kategori,
    required this.sinopsis,
    required this.tanggal_terbit,
  });

  factory ModelBook.fromJson(Map<String, dynamic> json) {
    return ModelBook(
        id: json['id'] ?? 0,
        judul: json['judul'] ?? '',
        pengarang: json['pengarang'] ?? '',
        penerbit: json['penerbit'] ?? '',
        kategori: json['kategori'] ?? '',
        sinopsis: json['sinopsis'] ?? '',
        tanggal_terbit: json['tanggal_terbit'] ?? ''
    );
  }
  Map<String, dynamic> toJson() => {
        'judul': judul,
        'pengarang': pengarang,
        'penerbit': penerbit,
        'kategori': kategori,
        'sinopsis': sinopsis,
        'tanggal_terbit': tanggal_terbit,
      };
}