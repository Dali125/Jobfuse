import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';

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
    return CustomScrollView(

      slivers: [



        SliverToBoxAdapter(


          child: Column(
            children: [

              //The Text Field Starts here
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Material(
                    elevation: 15
                    ,
                    shadowColor: AppColors.splashColor2,
                    child: Container(
                      decoration: BoxDecoration(
                        
                        border: Border.all(

                          color: AppColors.splashColor2
                        )
                      ),
                      height: 50,
                      child: TextField(

                        decoration: const InputDecoration(
                          disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            prefixIcon: Icon(Icons.search_outlined),hintText: 'Type Keyword of job'
                        ),
                        onChanged: (val){
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              )

              //The Text Field ends here
              ,

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



                                    child: Text('Type in Searchbar to view results'),
                                  );


                                }
                                if(data['title'].toString().contains(name.toLowerCase()) || data['Description'].toString().contains(name.toLowerCase())){

                                  return ListTile(
                                    title: Text('${data['title']}' ,maxLines: 1,),
                                    subtitle: Text(data['ExperienceLevel'].toString(), maxLines: 1,),

                                    onTap: (){


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


    );
  }
}
