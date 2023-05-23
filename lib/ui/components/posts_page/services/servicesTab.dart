import 'package:flutter/material.dart';

class SelecteServices extends StatefulWidget {
  String category;

  SelecteServices({Key? key, required this.category}) : super(key: key);

  @override
  State<SelecteServices> createState() => _SelecteServicesState();
}

class _SelecteServicesState extends State<SelecteServices> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
              bottom: TabBar(
                  tabs: [
                         Tab(
                        text: 'Tab 1',
                         ),
                        Tab(
                   text: 'Services',
                          ),
                     ],
                    ),
                    ),
      body: TabBarView(
      children: [
      Text('1'),
        Text('2')
      ],
      ),
      ),
    );
  }
}

      