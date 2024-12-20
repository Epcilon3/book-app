import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class FormTambah extends StatefulWidget {
  const FormTambah({super.key});
  @override
  State<StatefulWidget> createState() => FormTambahState();
}

class FormTambahState extends State<FormTambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController judulController = TextEditingController();
  TextEditingController pengarangController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  TextEditingController kategoriController = TextEditingController();
  TextEditingController sinopsisController = TextEditingController();
  TextEditingController tanggal_terbitController = TextEditingController();

  String? selectedBook;
  Future createSw() async {
    return await http.post(Uri.parse(BaseUrl.tambah), body: {
      'judul': judulController.text,
      'pengarang': pengarangController.text,
      'penerbit': penerbitController.text,
      "sinopsis": sinopsisController.text,
      'kategori': kategoriController.text,
      "tanggal_terbit": tanggal_terbitController.text,
    });
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Data Buku",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4.0,
      ),
      body: Container(
        child: Column(
          children: [
            _textboxJudul(),
            _textboxPengarang(),
            _textboxPenerbit(),
            _textboxKategori(),
            _textboxsinopsis(),
            _textboxtanggal_terbit(),
            const SizedBox(height: 20.0),
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  _textboxJudul() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Judul Buku",
          prefixIcon: Icon(Icons.book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: judulController,
      ),
    );
  }

  _textboxPengarang() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Nama Pengarang",
          prefixIcon: Icon(Icons.person),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: pengarangController,
      ),
    );
  }

  _textboxPenerbit() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Penerbit",
          prefixIcon: Icon(Icons.menu_book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: penerbitController,
      ),
    );
  }

  _textboxKategori() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(value: 'Novel', child: Text('Novel')),
      DropdownMenuItem(value: 'Sejarah', child: Text('Sejarah')),
      DropdownMenuItem(value: 'Cerita', child: Text('Cerita Rakyat')),
      DropdownMenuItem(value: 'Fiksi', child: Text('Fiksi')),
      DropdownMenuItem(value: 'Fantasi', child: Text('Fantasi')),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Kategori',
          prefixIcon: Icon(Icons.book),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Pilih Kategori Buku',
          style: TextStyle(fontSize: 14),
        ),
        items: items,
        value: selectedBook ??
            (kategoriController.text.isNotEmpty
                ? kategoriController.text
                : null),
        onChanged: (String? value) {
          setState(() {
            selectedBook = value;
            kategoriController.text = selectedBook ?? '';
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Kategori Buku';
          }
          return null;
        },
      ),
    );
  }

  _textboxsinopsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "sinopsis Buku",
          prefixIcon: Icon(Icons.summarize),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: sinopsisController,
      ),
    );
  }

  // _textboxtanggal_terbit() {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: TextField(
  //       controller: tanggal_terbitController,
  //       decoration: const InputDecoration(
  //         labelText: "Tanggal Terbit",
  //         prefixIcon: Icon(Icons.calendar_month),
  //         border: InputBorder.none,
  //         contentPadding:
  //             EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
  //       ),
  //       readOnly: true,
  //       onTap: () async {
  //         DateTime? pickedDate = await showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(1900),
  //           lastDate: DateTime(2100),
  //         );

  //         if (pickedDate != null) {
  //           setState(() {
  //             tanggal_terbitController.text = "${pickedDate.toLocal()}".split(' ')[0];
  //           });
  //         }
  //       },
  //     ),
  //   );
  // }

//   _textboxtanggal_terbit() {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10.0),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.5),
//           spreadRadius: 2,
//           blurRadius: 5,
//           offset: Offset(0, 3),
//         ),
//       ],
//     ),
//     child: TextField(
//       controller: tanggal_terbitController,
//       decoration: const InputDecoration(
//         labelText: "Tahun Terbit",
//         prefixIcon: Icon(Icons.calendar_month),
//         border: InputBorder.none,
//         contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//       ),
//       readOnly: true,
//       onTap: () async {
//         // Menampilkan DatePicker tetapi hanya untuk memilih tahun
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: DateTime.now(),
//           firstDate: DateTime(1900),
//           lastDate: DateTime(2100),
//           builder: (BuildContext context, Widget? child) {
//             return Theme(
//               data: ThemeData.light().copyWith(
//                 primaryColor: Colors.blue,
//                 buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//               ),
//               child: child!,
//             );
//           },
//         );

//         if (pickedDate != null) {
//           setState(() {
//             tanggal_terbitController.text = "${pickedDate.year}"; // Menampilkan hanya tahun
//           });
//         }
//       },
//     ),
//   );
// }

_textboxtanggal_terbit() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: TextField(
      controller: tanggal_terbitController,
      decoration: const InputDecoration(
        labelText: "Tanggal Terbit",
        prefixIcon: Icon(Icons.calendar_month),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue,
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
            setState(() {
              tanggal_terbitController.text = "${pickedDate.toLocal()}".split(' ')[0];
            });
        }
      },
    ),
  );
}



  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.black, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Membuat sudut tombol melengkung
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 30.0), // Padding di dalam tombol
        elevation: 5.0, // Efek shadow di bawah tombol
        shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}