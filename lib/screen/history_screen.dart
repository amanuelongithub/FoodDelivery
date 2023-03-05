import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../components/history_card.dart';
import '../provider/themeprovider.dart';
import '../utils/colors.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final isDark =
        Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? "dark"
            : "light";

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        shadowColor: Colors.transparent,
        backgroundColor:
            isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
        title: Text("  Your history",
            style: TextStyle(
              fontSize: 18,
              color: isDark == "dark"
                  ? Color.fromARGB(255, 231, 231, 231)
                  : Color.fromARGB(255, 38, 38, 38),
              fontWeight: FontWeight.bold,
            )),
      ),
      backgroundColor:
          isDark == "dark" ? null : Color.fromARGB(255, 231, 231, 231),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 15, bottom: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('orders')
                    .where('uid', isEqualTo: _auth.currentUser!.uid)
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.maincolor,
                        ),
                      );
                    }
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      "There is no History",
                      style:
                          TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                    ));
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Unabel to get the data",
                      style:
                          TextStyle(color: Color.fromARGB(184, 138, 138, 138)),
                    ));
                  }

                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          return HistoryCard(
                              // snap: snapshot.data!.docs[index].data(),
                              );
                        } else if (!snapshot.hasData) {
                          return const Center(
                              child: Text(
                            "No History data get",
                            style: TextStyle(
                                color: Color.fromARGB(246, 152, 152, 152)),
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Some Error occured",
                                style: TextStyle(fontSize: 20)),
                          );
                        } else
                          return Container();
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
