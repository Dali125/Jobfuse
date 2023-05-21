import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';

import '../selected_posts.dart';

class SearchJobs extends StatefulWidget {
  const SearchJobs({Key? key}) : super(key: key);

  @override
  State<SearchJobs> createState() => _SearchJobsState();
}

class _SearchJobsState extends State<SearchJobs> {


  String name = '';


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        title: Card(
          color: Colors.white,

          child: TextField(
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,


                prefixIcon: Icon(Icons.search_outlined),hintText: 'Search Services'
            ),
            onChanged: (val){
              setState(() {
                name = val;
              });
            },
          ),

        ),
      ),
      body: CustomScrollView(

        slivers: [



          SliverToBoxAdapter(


            child: Column(
              children: [


                //The Text Field ends here

                SizedBox(height: 30,),
                Container(
                  height: height,
                  width: width,

                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('ProjectTasks').snapshots(),
                      builder: (context,snapshot) {
                        if (snapshot.hasData) {

                          return FadeInDown(
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index){

                                  var data = snapshot.data!.docs[index].data() as Map <String, dynamic>;

                                  if(name.isEmpty){

                                    return const Center(

                                    );


                                  }
                                  if(data['title'].toString().contains(name.toLowerCase()) || data['Description'].toString().contains(name.toLowerCase())){

                                    return ListTile(
                                      title: Text('${data['title']}' ,maxLines: 1,),
                                      subtitle: Text(data['ExperienceLevel'].toString(), maxLines: 1,),

                                      onTap: (){
                                        //We want to Navigate to the post that we have chosen,or selected in the search
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>

                                            SelectedPost(
                                                experienceLevel: data['ExperienceLevel'],
                                                description: data['Description'],
                                                title: data['title'],
                                                budget: data['Budget'],
                                                clientId: data['Client_id'],
                                                duration: data['Duration'],
                                                documentId : data['DocumentID']),  ));



                                      },

                                    );

                                  }




                                }),
                          );
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
                ),

              ],
            ),

          )


        ],


      ),
    );
  }
}
