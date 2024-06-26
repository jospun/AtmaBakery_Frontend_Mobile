import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pages/customer/walletPage.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:p3l_atmabakery/data/client/saldoHistoryClient.dart';

class TarikWalletPage extends StatefulWidget {
  const TarikWalletPage({Key? key}) : super(key: key);

  @override
  State<TarikWalletPage> createState() => _TarikWalletPageState();
}

class _TarikWalletPageState extends State<TarikWalletPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController jumlahUangController = TextEditingController();
  TextEditingController namaBankController = TextEditingController();
  TextEditingController nomorRekeningController = TextEditingController();

  String nama = "Guest";
  String pfp = "";
  String email = "Please log In";

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? "Guest";
      pfp = prefs.getString('foto_profil') ?? "";
      email = prefs.getString('email') ?? "Please log In";
    });
  }

  void submission() async {
    print(jumlahUangController.text);
    try {
      await HistoriSaldoClient.create(jumlahUangController.text,
          namaBankController.text, nomorRekeningController.text);
      showSnackbar(
          context, "Berhasil Mengajukan Penarikan Saldo", Colors.green);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WalletPage(),
        ),
      );
    } catch (e) {
      print(e.toString());
      showSnackbar(context, e.toString(), Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Penarikan Saldo",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(pfp.isNotEmpty
                          ? pfp
                          : "https://res.cloudinary.com/daorbrq8v/image/upload/f_auto,q_auto/v1/atma-bakery/r1xujbu1yfoenzked4rc"),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$nama",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                  indent: 0,
                  endIndent: 0,
                ),
                SizedBox(height: 30),
                const Text(
                  "Jumlah Uang",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: jumlahUangController,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: false,
                    fillColor: const Color.fromRGBO(234, 234, 234, 1),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(210, 145, 79, 1),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 181, 179, 179)),
                    ),
                    hintText: 'Masukkan jumlah uang',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(height: 0.13.h),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan masukkan jumlah uang';
                    }
                    try {
                      int intValue = int.parse(value);
                      if (intValue % 50000 != 0) {
                        return 'Jumlah Uang Harus Kelipatan 50000!';
                      } else if (intValue <= 0) {
                        return 'Tidak Bisa Kurang dari 0!';
                      }
                    } catch (e) {
                      return 'Inputan Harus Berupa Angka';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                const Text(
                  "Nama Bank",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: namaBankController,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: false,
                    fillColor: const Color.fromRGBO(234, 234, 234, 1),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(210, 145, 79, 1),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 181, 179, 179)),
                    ),
                    hintText: 'Masukkan nama bank',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(height: 0.13.h),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan masukkan nama bank';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                const Text(
                  "Nomor Rekening",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nomorRekeningController,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: false,
                    fillColor: const Color.fromRGBO(234, 234, 234, 1),
                    border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(244, 142, 40, 1)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(210, 145, 79, 1),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 181, 179, 179)),
                    ),
                    hintText: 'Masukkan nomor rekening',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    hintStyle: TextStyle(height: 0.13.h),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silahkan masukkan nomor rekening';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 80.w,
                    height: 5.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(244, 142, 40, 1)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Apakah Anda Yakin?'),
                              content: const Text(
                                  'Semua hal tidak dapat dikembalikan saat menekan OK'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    submission(),
                                    Navigator.pop(context, 'OK'),
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Tarik',
                        style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
