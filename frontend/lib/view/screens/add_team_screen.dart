import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_text_form_field.dart';
import 'package:afet_takip/view/widgets/participant_circle.dart';
import 'package:flutter/material.dart';

import '../../models/user/user_model.dart';
import '../../models/user/user_role_model.dart';
import '../../models/volunteer_model.dart';

class AddToTeamScreen extends StatefulWidget {
  const AddToTeamScreen({super.key});

  @override
  State<AddToTeamScreen> createState() => _AddToTeamScreenState();
}

class _AddToTeamScreenState extends State<AddToTeamScreen> {
  List<Volunteer> volunteers = [
    Volunteer(
      id: 2,
      userId: 2,
      user: UserModel(
        firstname: 'Jane',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 2, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 2',
      volunteerTypeCategory: 'Volunteer Category 2',
      image: 'assets/images/volunteer2.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-01 11:00:00',
      updatedAt: '2022-03-01 11:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    Volunteer(
      id: 3,
      userId: 3,
      user: UserModel(
        firstname: 'John',
        surname: 'Doe',
        // userRole holds a list of user role elements
        userRole: List<UserRole>.empty(growable: true)
          ..add(UserRole(userId: 3, userRoleName: "Volunteer")),
      ),
      volunteerTypeName: 'Volunteer Type 3',
      volunteerTypeCategory: 'Volunteer Category 3',
      image: 'assets/images/volunteer3.png',
      volunteerTeamId: 1,
      helpCenterId: 1,
      createdAt: '2022-03-02 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Members To Team"),
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: CustomTextFormField(initialValue: "", label: "Team Name"),
          ),
          Text("Team members: "),
          SizedBox(
            height: 10,
          ),
          _buildVolunteerList(volunteers)
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.green,
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Add to team",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        CustomTextFormField(
                          initialValue: "",
                          label: "",
                          suffixIcon: const Icon(Icons.search),
                        ),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: const [
                              FittedBox(
                                child: ParticipantCircleAvatar(),
                              ),
                              FittedBox(
                                child: ParticipantCircleAvatar(),
                              ),
                              FittedBox(
                                child: ParticipantCircleAvatar(),
                              ),
                              FittedBox(
                                child: ParticipantCircleAvatar(),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: const [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: ListTile(
                                        leading: CircleAvatar(),
                                        title: Text("Name"),
                                        trailing: Icon(Icons
                                            .check_circle_outline_outlined)),
                                  ),
                                  Divider(
                                    indent: 25,
                                    endIndent: 25,
                                    color: Colors.black,
                                    thickness: 2,
                                  )
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _buildVolunteerList(List<Volunteer> volunteers) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: volunteers.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: ListTile(
                leading: const CircleAvatar(),
                title: Text(
                    "${volunteers[index].user?.firstname} ${volunteers[index].user?.surname}"),
                subtitle: Text("${volunteers[index].user?.getHighestRole()}"),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ),
          );
        });
  }
}
