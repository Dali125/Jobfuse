import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MyServices extends StatefulWidget {
  const MyServices({Key? key}) : super(key: key);

  @override
  State<MyServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 220,
        width: width,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('freelance_services').
            where('Userid',isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).snapshots(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){

                    var services = snapshot.data!.docs[index];
                    return Material(
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(height: 110,width: 200,
                          child: Image.network(services['service_image'],height: 110,fit: BoxFit.fitWidth,
                          ),

                          //Image.network(services['service_image'],height: 110,fit: BoxFit.fitWidth,),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(services['description']),
                          ),



                        ],
                      )
                    );


                  }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 15,);
                },);
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
