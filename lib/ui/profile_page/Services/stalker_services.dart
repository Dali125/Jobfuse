import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StalkerServices extends StatefulWidget {
  const StalkerServices({Key? key}) : super(key: key);

  @override
  State<StalkerServices> createState() => _StalkerServicesState();
}

class _StalkerServicesState extends State<StalkerServices> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 300,
      width: width,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('freelance_services')
            .where('Userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var services = snapshot.data!.docs[index];
                return Material(
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 300,
                        width: width,
                        child: Image.network(
                          services['service_image'],
                          height: 110,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(services['description']),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 40);
              },
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
