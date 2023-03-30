import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/participant_circle.dart';
import 'package:flutter/material.dart';

class AddTeamScreen extends StatefulWidget {
  const AddTeamScreen({super.key});

  @override
  State<AddTeamScreen> createState() => _AddTeamScreenState();
}

class _AddTeamScreenState extends State<AddTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create New Team"),
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Color.fromARGB(63, 171, 127, 127),
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Participants",
                              style: TextStyle(color: Colors.red),
                            ),
                            FloatingActionButton(
                              onPressed: () {},
                              child: const Icon(
                                Icons.add,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          crossAxisCount: 5,
                          children: const [
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                            FittedBox(child: ParticipantCircleAvatar()),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
