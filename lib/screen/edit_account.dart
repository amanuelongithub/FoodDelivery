import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../components/edit_card.dart';
import '../provider/themeprovider.dart';
import '../utils/colors.dart';

class EditAccount extends StatelessWidget {
  const EditAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";
    return Scaffold(
      backgroundColor:
          isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor:
            isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
        title: Text("  Edit account",
            style: TextStyle(
              fontSize: 18,
              color: isDark == "dark"
                  ? Color.fromARGB(255, 231, 231, 231)
                  : Color.fromARGB(255, 38, 38, 38),
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('user')
                .doc(_auth.currentUser!.uid)
                .snapshots()
                .first,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.maincolor,
                    ),
                  );
                }
              }
              if (!snapshot.hasData) {
                return const Center(
                    child: Text(
                  "user not found",
                  style: TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                ));
              }
              if (snapshot.hasError) {
                return const Center(
                    child: Text(
                  "Unabel to get user data",
                  style: TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                ));
              } else if (snapshot.hasData) {
                
                return EditCard(
                  snap: snapshot.data,
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
