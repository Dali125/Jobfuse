import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/payments_page/tabs/transfer_options/confirm_pay.dart';


class ChooseRecepient extends StatefulWidget {

  final balance;
  const ChooseRecepient({Key? key, required this.balance}) : super(key: key);

  @override
  State<ChooseRecepient> createState() => _ChooseRecepientState();
}

class _ChooseRecepientState extends State<ChooseRecepient> {

  String name ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: AppColors.logColor,
        title: Card(

          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_outlined),hintText: 'Search Number of recipient...'
            ),
            onChanged: (val){
              setState(() {
                name = val;
              });
            },
          ),

        ),
      ),

      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context,snapshot) {
            if (snapshot.hasData) {

              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){

                    var data = snapshot.data!.docs[index].data();

                if(name.isEmpty){

                  return ListTile(
                    title: Text('${data['First_name']} ${data['Last_name']}' ,maxLines: 1,),
                    subtitle: Text(data['Phone_Number'].toString(), maxLines: 1,),

                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => SendMoney(

                        name: '${data['First_name']} ${data['Last_name']}',
                        number: data['Phone_Number'],
                        avatar: data['imageUrl'],
                        email: data['email'],
                        userId: data['Userid'],
                        currentUserbalance: widget.balance,


                      )));
                    },
                  );


                }
                if(data['Phone_Number'].toString().startsWith(name.toLowerCase())){

                  return ListTile(
                      title: Text('${data['First_name']} ${data['Last_name']}' ,maxLines: 1,),
                    subtitle: Text(data['Phone_Number'].toString(), maxLines: 1,),

                  onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => SendMoney(

                          name: '${data['First_name']} ${data['Last_name']}',
                          number: data['Phone_Number'],
                          avatar: data['imageUrl'],
                          email: data['email'],
                          userId: data['Userid'],
                          currentUserbalance: widget.balance,


                        )));
                  },

                  );

                }




              });
            }
            else if(snapshot.connectionState == ConnectionState.waiting){

              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.splashColor2,
                ),
              );
            }
            else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );

  }
}
