import 'dart:convert';

import 'package:books/models/mbook.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:books/models/api.dart';
import 'package:http/http.dart' as http;

import 'package:books/book_form.dart';

class Edit extends StatefulWidget {
  final ModelBook sw;

  Edit({required this.sw});

  @override
  State<StatefulWidget> createState() => EditState();
}

class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();

  late TextEditingController judulController,
      pengarangController,
      penerbitController,
      kategoriController,
      sinopsisController,
      tanggal_terbitController;

  Future editSw() async {
    return await http.post(Uri.parse(BaseUrl.edit), body: {
      "id": widget.sw.id.toString(),
      "judul": judulController.text,
      "pengarang": pengarangController.text,
      "penerbit": penerbitController.text,
      "kategori": kategoriController.text,
      "sinopsis": sinopsisController.text,
      "tanggal_terbit": tanggal_terbitController.text,
    });
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan data berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    judulController = TextEditingController(text: widget.sw.judul);
    pengarangController = TextEditingController(text: widget.sw.pengarang);
    penerbitController = TextEditingController(text: widget.sw.penerbit);
    kategoriController = TextEditingController(text: widget.sw.kategori);
    sinopsisController = TextEditingController(text: widget.sw.sinopsis);
    tanggal_terbitController = TextEditingController(text: widget.sw.tanggal_terbit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Buku",
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
      bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
        child: Text("Update"),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        onPressed: () {
          _onConfirm(context);
        },
      )),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: EditDataBook(
            formkey: formkey,
            judulController: judulController,
            pengarangController: pengarangController,
            penerbitController: penerbitController,
            kategoriController: kategoriController,
            sinopsisController: sinopsisController,
            tanggal_terbitController: tanggal_terbitController,
          ),
        ),
      ),
    );
  }
}