import 'dart:convert';
import 'dart:async';
import 'package:books/book_forminput.dart';
import 'package:flutter/material.dart';
import 'package:books/models/mbook.dart';
import 'package:books/models/api.dart';
import 'package:http/http.dart' as http;
import 'book_details.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<ModelBook>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<ModelBook>> getSwList() async {
    final response = await http.get(Uri.parse(BaseUrl.data));
    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body);
      return items.map<ModelBook>((json) => ModelBook.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Book');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text(
          "Data Buku",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormTambah()),
            );
          },
          icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(

        child: FutureBuilder<List<ModelBook>>(

          future: sw,
          builder:
              (BuildContext context, AsyncSnapshot<List<ModelBook>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No data found");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    
                    trailing: Icon(Icons.arrow_right),
                    title: Text(
                      "${data.judul} - ${data.sinopsis}",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kategori: ${data.kategori}"),
                        Text("Tanggal Terbit: ${data.tanggal_terbit}"),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailBook(sw: data)));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      
    

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => FormTambah()),
      //     );
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.blue,
      // ),
    );
  }
}