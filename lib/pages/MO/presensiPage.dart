import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p3l_atmabakery/data/presensi.dart';
import 'package:p3l_atmabakery/data/client/presensiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({Key? key}) : super(key: key);

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  List<Presensi>? listPresensi;
  bool _isLoading = true;
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _loadPresensiData();
  }

  Future<void> editPresensi(int id, Presensi presensi) async {
    print(id);
    print(presensi.status);
    try {
      // Panggil fungsi update dari userClient
      await presensiClient.updatePresensi(id, presensi);
    } catch (e) {
      print("Error during user update: $e");
    }
  }

  Future<void> _loadPresensiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String formattedDate = formatter.format(now);
    setState(() {
      _isLoading = true;
    });
    try {
      listPresensi = await presensiClient.showPresensiByDate(formattedDate);
      print(listPresensi!.length);
    } catch (e) {
      print("Error fetching user history: $e");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var formatter2 = DateFormat('EEEE, dd MMMM yyyy');
    String formattedDate = formatter2.format(now);
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Presensi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: const Color.fromRGBO(244, 142, 40, 1),
          elevation: 4,
          shadowColor: Colors.grey,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: listPresensi?.length ?? 0,
              itemBuilder: (context, index) {
                String selectedValue =
                    listPresensi![index].status == 1 ? 'Hadir' : 'Tidak Hadir';

                return Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${listPresensi![index].nama}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${listPresensi![index].no_telp}',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          DropdownButton<String>(
                            items: <String>['Hadir', 'Tidak Hadir']
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) async {
                              Presensi main;
                              if (value == selectedValue) {
                                main = Presensi(
                                  id: listPresensi![index].id,
                                  status: selectedValue == 'Hadir' ? 1 : 0,
                                );
                              } else {
                                main = Presensi(
                                  id: listPresensi![index].id,
                                  status: selectedValue == 'Hadir' ? 0 : 1,
                                );

                                await editPresensi(
                                    listPresensi![index].id!, main);
                                _loadPresensiData();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    }
  }
}
