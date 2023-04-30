import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../logic/update_user_logic.dart';
import '../colors/colors.dart';

class UpdateInfo extends StatefulWidget {
  final data;
  const UpdateInfo({Key? key, this.data}) : super(key: key);

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {




  @override
  Widget build(BuildContext context) {
    String currentUser = FirebaseAuth.instance.currentUser!.uid;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(




      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: 80,
            backgroundColor: AppColors.logColor,
            flexibleSpace: const Center(child:
            Text('Update User Details',style: TextStyle(
              fontSize: 30
            ),)
              ,),
          ),
          SliverToBoxAdapter(

            child: StreamBuilder(

              stream: FirebaseFirestore.instance.collection('users')
              .where('Userid', isEqualTo: currentUser).snapshots(),

              builder: (context, snapshot){

                if(snapshot.hasData){

                  return Container(
                    height: height,
                    width: width,
                    child: ListView.builder(

                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index){


                          var myData = snapshot.data?.docs[index];


                          TextEditingController firstName = TextEditingController();
                          TextEditingController UserName = TextEditingController();
                          TextEditingController lastName = TextEditingController(text: myData?['Last_name']);
                          TextEditingController phone_number = TextEditingController(text: myData?['Phone_Number'].toString());
                          TextEditingController nrc = TextEditingController(text: myData?['NRC_NUMBER']);



                          return Container(

                            height: height,
                            width: width,

                            child: Padding(padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20,),
                            child: Column(

                              children: [

                                //FirstName
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)
                                  ),

                                  child: TextFormField(
                                    initialValue: myData?['UserName'],

                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 3, color: Colors.deepPurple),
                                          borderRadius: BorderRadius.circular(8),

                                        ),labelText: 'UserName'
                                    ),

                                    controller: UserName,

                                  ),
                                ),

                                const SizedBox(
                                  height: 25,
                                ),



                                //FirstName
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                
                                  child: TextFormField(

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 3, color: Colors.deepPurple),
                                        borderRadius: BorderRadius.circular(8),

                                      ),labelText: 'FirstName'
                                    ),

                                    controller: firstName,

                                  ),
                                ),

                                const SizedBox(
                                  height: 25,
                                ),

                                //LastName
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)
                                  ),

                                  child: TextFormField(

                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 3, color: Colors.deepPurple),
                                          borderRadius: BorderRadius.circular(8),

                                        ),labelText: 'LastName'
                                    ),

                                    controller: lastName,

                                  ),
                                ),

                                const SizedBox(
                                  height: 25,
                                ),

                                //Phone Number
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)
                                  ),

                                  child: TextFormField(

                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 3, color: Colors.deepPurple),
                                          borderRadius: BorderRadius.circular(8),

                                        ),labelText: 'Phone'
                                    ),

                                    controller: phone_number,

                                  ),
                                ),

                                const SizedBox(
                                  height: 25,
                                ),

                                //Nrc
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8)
                                  ),

                                  child: TextFormField(

                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 3, color: Colors.deepPurple),
                                          borderRadius: BorderRadius.circular(8),

                                        ),labelText: 'FirstName'
                                    ),

                                    controller: nrc,

                                  ),
                                ),

                                GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(40, 10, 40, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.logColor,
                                      ),

                                      width: width,
                                      height: 60,
                                      child: const Center(
                                        child: Text('Save and Continue',
                                          style: TextStyle(fontSize: 24),),

                                      ),
                                    ),
                                  ),
                                  onTap: (){


                                    UpdateUser updateuser = UpdateUser(UserName: UserName.text.trim(), Fname: firstName.text.trim(),
                                        Lname: lastName.text.trim(), Pnumber: phone_number.text.trim(), Nrc: nrc.text.trim());

                                    updateuser.PerformUpdate();

                                    Navigator.pop(context);
                                  },
                                )



                              ],
                            ),),
                          );






                    }),
                  );




                }else{

                  return Column();

                }

              },
            ),
          )
        ],
      ),


    );
  }
}
