import 'package:dreampocket/addtargetpage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<TargetItem> targetList = [];
  String title = "";
  int week = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 198, 134),
      appBar: AppBar(
        title: Text('Dream Pocket'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 180, 133, 56),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toNextPage,
        backgroundColor: const Color.fromARGB(255, 236, 160, 38),
        child: const Icon(Icons.add),
      ),

      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child:
              targetList
                  .isEmpty // sama macam if je cuma shortform
              ? Center(
                  child: Text(
                    'No targets. Click the + button to add a target.',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: targetList.length,
                  itemBuilder: (context, index) {
                    var item = targetList[index];
                    return Column(
                      children: [
                        Card(
                          margin: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.black),
                          ),

                          child: ListTile(
                            title: Text('Target: ${item.title}'),
                            subtitle: Text(
                              'Estimated Weeks to Achieve: ${item.week} weeks',
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  targetList.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }

  Future<void> toNextPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Addtargetpage()),
    );

    if (result != null) {
      setState(() {
        targetList.add(
          TargetItem(result['title'], result['week']),
        ); // same like get method.
      });
    }
  }
}

class TargetItem {
  late String title;
  late int week;

  TargetItem(String title, int week) {
    this.title = title;
    this.week = week;
  }
}
