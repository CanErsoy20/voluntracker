import 'package:afet_takip/models/help_center/busiest_hours_model.dart';
import 'package:afet_takip/models/help_center/contact_info_model.dart';
import 'package:afet_takip/models/help_center/location_model.dart';
import 'package:afet_takip/models/help_center/open_close_info_model.dart';
import 'package:afet_takip/models/user/user_model.dart';
import 'package:afet_takip/models/user/user_role_model.dart';
import 'package:afet_takip/models/volunteer_model.dart';
import 'package:afet_takip/models/volunteer_team_leader_model.dart';
import 'package:afet_takip/models/volunteer_team_model.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/custom_text_field.dart';
import 'package:afet_takip/view/widgets/volunteer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_menu/star_menu.dart';
import '../../cubit/team/team_cubit.dart';
import '../../models/help_center/help_center_model.dart';
import '../widgets/custom_snackbars.dart';

class HelpCenterVolunteersScreen extends StatefulWidget {
  const HelpCenterVolunteersScreen({super.key});

  @override
  State<HelpCenterVolunteersScreen> createState() =>
      _HelpCenterVolunteersScreenState();
}

class _HelpCenterVolunteersScreenState
    extends State<HelpCenterVolunteersScreen> {
  List<VolunteerTeam> volunteerTeams = [
    VolunteerTeam(
      id: 1,
      teamName: 'Team A',
      helpCenter: HelpCenterModel(
        id: 1,
        name: 'Help Center A',
        additionalInfo: "Additional Info A",
        volunteerCapacity: 500,
        contactInfo: ContactInfo(
          address: 'Address A',
          phone: '1234567890',
          email: '',
        ),
        location: Location(
          lat: 39.0,
          lon: 32.0,
        ),
        busiestHours: BusiestHours(
          start: '2022-03-01 10:00:00',
          end: '2022-03-01 10:00:00',
        ),
        openCloseInfo: OpenCloseInfo(
          start: '2022-03-01 10:00:00',
          end: '2022-03-01 10:00:00',
        ),
        city: 'City A',
        country: 'Country A',
        createdAt: '2022-03-01 10:00:00',
        updatedAt: '2022-03-01 10:00:00',
        neededSupplyList: List.empty(),
        neededVolunteerList: List.empty(),
      ),
      volunteerTeamLeader: VolunteerTeamLeader(
        id: 1,
        volunteer: Volunteer(
          id: 1,
          userId: 1,
          user: UserModel(
            firstname: 'John',
            surname: 'Doe',
            // userRole holds a list of user role elements
            userRole: List<UserRole>.empty(growable: true)
              ..add(UserRole(userId: 1, userRoleName: "Volunteer Team Leader")),
          ),
          volunteerTypeName: 'Volunteer Type 1',
          volunteerTypeCategory: 'Volunteer Category 1',
          image: 'assets/images/volunteer1.png',
          volunteerTeamId: 1,
          helpCenterId: 1,
          createdAt: '2022-03-01 10:00:00',
          updatedAt: '2022-03-01 10:00:00',
        ),
        volunteerTeam: null,
      ),
      volunteers: [
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
      ],
      createdAt: '2022-03-01 10:00:00',
      updatedAt: '2022-03-02 10:00:00',
    ),
    VolunteerTeam(
      id: 2,
      teamName: 'Team B',
      helpCenter: HelpCenterModel(
        id: 2,
        name: 'Help Center B',
        additionalInfo: "Additional Info B",
        volunteerCapacity: 500,
        contactInfo: ContactInfo(
          address: 'Address B',
          phone: '1234567890',
          email: '',
        ),
        location: Location(
          lat: 39.0,
          lon: 32.0,
        ),
        busiestHours: BusiestHours(
          start: '2022-03-02 10:00:00',
          end: '2022-03-02 10:00:00',
        ),
        openCloseInfo: OpenCloseInfo(
          start: '2022-03-02 10:00:00',
          end: '2022-03-02 10:00:00',
        ),
        city: 'City B',
        country: 'Country B',
        createdAt: '2022-03-02 10:00:00',
        updatedAt: '2022-03-02 10:00:00',
        neededSupplyList: List.empty(),
        neededVolunteerList: List.empty(),
      ),
      volunteerTeamLeader: VolunteerTeamLeader(
        id: 2,
        volunteer: Volunteer(
          id: 4,
          userId: 4,
          user: UserModel(
            firstname: 'Jane',
            surname: 'Doe',
            // userRole holds a list of user role elements
            userRole: List<UserRole>.empty(growable: true)
              ..add(UserRole(userId: 4, userRoleName: "Volunteer Team Leader")),
          ),
          volunteerTypeName: 'Volunteer Type 4',
          volunteerTypeCategory: 'Volunteer Category 4',
          image: 'assets/images/volunteer4.png',
          volunteerTeamId: 2,
          helpCenterId: 2,
          createdAt: '2022-03-02 11:00:00',
          updatedAt: '2022-03-02 11:00:00',
        ),
        volunteerTeam: null,
      ),
      volunteers: [
        Volunteer(
          id: 5,
          userId: 5,
          user: UserModel(
            firstname: 'Bob',
            surname: 'Johnson',
            // userRole holds a list of user role elements
            userRole: List<UserRole>.empty(growable: true)
              ..add(UserRole(userId: 5, userRoleName: "Volunteer")),
          ),
          volunteerTypeName: 'Volunteer Type 5',
          volunteerTypeCategory: 'Volunteer Category 5',
          image: 'assets/images/volunteer5.png',
          volunteerTeamId: 2,
          helpCenterId: 2,
          createdAt: '2022-03-03 10:00:00',
          updatedAt: '2022-03-03 10:00:00',
        ),
      ],
      createdAt: '2022-03-02 11:00:00',
      updatedAt: '2022-03-03 10:00:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final createTeamFormKey = GlobalKey<FormState>();
    final assignVolunteerFormKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Volunteers'),
      ),
      endDrawer: CustomDrawer(loggedIn: true),
      body: BlocConsumer<TeamCubit, TeamState>(
        listener: (context, state) {
          if (state is TeamSuccess) {
            CustomSnackbars.successSnackbar(
                context, state.title, state.description);
          } else if (state is TeamError) {
            CustomSnackbars.errorSnackbar(
                context, state.title, state.description);
          }
        },
        builder: (context, state) {
          return VolunteerList(
            volunteerTeams: volunteerTeams,
          );
        },
      ),
      floatingActionButton: StarMenu(
        onItemTapped: (index, controller) {
          if (index != 1) controller.closeMenu!();
        },
        params: const StarMenuParameters(
          shape: MenuShape.linear,
          linearShapeParams: LinearShapeParams(
              angle: 270, space: 10, alignment: LinearAlignment.center),
        ),
        items: [
          FloatingActionButton(
            onPressed: () {
              // show dialog for creating a team
              _showCreateTeamDialog(context, createTeamFormKey);
            },
            child: const Icon(Icons.people),
          ),
          FloatingActionButton(
            onPressed: () {
              // show dialog for adding a volunteer to help center
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Form(
                          key: assignVolunteerFormKey,
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomFormField(
                                  hint: "",
                                  label: "Volunteer Email",
                                  labelColor: Colors.black,
                                  onChanged: (value) {
                                    //TODO:
                                  },
                                ),
                                Text("OR"),
                                CustomFormField(
                                  hint: "",
                                  label: "Volunteer Phone Number",
                                  labelColor: Colors.black,
                                  onChanged: (value) {
                                    //TODO:
                                  },
                                ),
                              ],
                            ),
                          )),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (assignVolunteerFormKey.currentState!
                                  .validate()) {
                                //TODO: assign request at
                              }
                            },
                            child: const Text(
                                "Assign Volunteer to My Help Center")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                      ],
                    );
                  });
            },
            child: const Icon(Icons.person),
          ),
          const SizedBox(height: 70),
        ],
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showCreateTeamDialog(
      BuildContext context, GlobalKey<FormState> formKey) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
                key: formKey,
                child: SizedBox(
                  height: 120,
                  child: Column(
                    children: [
                      CustomFormField(
                        hint: "",
                        label: "Team Name",
                        labelColor: Colors.black,
                        onChanged: (value) {
                          context.read<TeamCubit>().newTeam.teamName = value;
                        },
                      )
                    ],
                  ),
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<TeamCubit>().createNewTeam();
                    }
                  },
                  child: const Text("Create New Team")),
            ],
          );
        });
  }
}
