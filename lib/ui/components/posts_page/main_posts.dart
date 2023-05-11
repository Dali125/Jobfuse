import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/posts_page/posts.dart';
import 'package:jobfuse/ui/components/posts_page/tabs/Search.dart';
import 'package:jobfuse/ui/proposal_page/recieved_proposal.dart';
import 'package:jobfuse/ui/proposal_page/submitted_proposals.dart';

import '../../bookmarks/mybookmarks.dart';
import '../../drawer/my_drawer.dart';




class JobsHome extends StatefulWidget {
  const JobsHome({Key? key}) : super(key: key);

  @override
  State<JobsHome> createState() => _JobsHomeState();
}

class _JobsHomeState extends State<JobsHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        appBar: AppBar(

          backgroundColor: AppColors.logColor,

          title: const DelayedDisplay(delay: Duration(milliseconds: 200)
              ,child: Text('Jobs')),
          centerTitle: true,
          bottom: const TabBar(

            tabs: [
              DelayedDisplay(delay: Duration(milliseconds: 200),
                child: Tab(
                  text: 'Feed',),
              ),

              DelayedDisplay(delay: Duration(milliseconds: 200),
                child: Tab(
                  text: 'Saved',),
              ),
              DelayedDisplay(
                delay: Duration(milliseconds: 200), child: Tab(
                text: 'Search',),
              ),




            ],
          ),



        ),
        body: const TabBarView(
          children: [

            MyHome(),

            MyBookmarks(),

            SearchJobs()

          ],
        ),
        drawer: const MyDrawer(),

      ),
    );
  }
}
