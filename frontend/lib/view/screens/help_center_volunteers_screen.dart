import 'package:afet_takip/cubit/help_centers/help_center_cubit.dart';
import 'package:afet_takip/cubit/map/map_cubit.dart';
import 'package:afet_takip/models/help_center/busiest_hours_model.dart';
import 'package:afet_takip/models/help_center/contact_info_model.dart';
import 'package:afet_takip/models/help_center/location_model.dart';
import 'package:afet_takip/models/help_center/open_close_info_model.dart';
import 'package:afet_takip/models/user/user_model.dart';
import 'package:afet_takip/models/user/user_role_model.dart';
import 'package:afet_takip/models/volunteer_model.dart';
import 'package:afet_takip/models/volunteer_team_leader_model.dart';
import 'package:afet_takip/models/volunteer_team_model.dart';
import 'package:afet_takip/router.dart';
import 'package:afet_takip/view/widgets/custom_drawer.dart';
import 'package:afet_takip/view/widgets/volunteer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../helper_functions.dart';
import '../../models/help_center/help_center_model.dart';
import '../../models/user/user_info.dart';
import '../widgets/custom_need_card.dart';

class HelpCenterVolunteersScreen extends StatefulWidget {
  const HelpCenterVolunteersScreen({super.key});

  @override
  _VolunteersScreenState createState() => _VolunteersScreenState();

  // @override
  // Widget build(BuildContext context) {
  //   HelpCenterModel currentCenter = context.read<HelpCenterCubit>().myCenter!;
  //   return Scaffold(
  //       appBar: AppBar(
  //         centerTitle: true,
  //         title: const FittedBox(
  //           fit: BoxFit.fitWidth,
  //           child: Text("Help Center Volunteers"),
  //         ),
  //       ),
  //       endDrawer: CustomDrawer(loggedIn: UserInfo.loggedUser != null),
  //       body: DefaultTabController(
  //         length: 2,
  //         child: Column(
  //           children: [
  //             // Image.asset(
  //             //   fit: BoxFit.fitWidth,
  //             //   width: MediaQuery.of(context).size.width,
  //             //   height: MediaQuery.of(context).size.height / 6,
  //             //   "assets/images/bilkent.jpg",
  //             // ),
  //             Text(
  //               currentCenter.name!,
  //               style: const TextStyle(fontSize: 20),
  //             ),
  //           ],
  //         ),
  //       ));
  // }
}

class _VolunteersScreenState extends State<HelpCenterVolunteersScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteers'),
      ),
      body: VolunteerList(
        volunteerTeams: volunteerTeams,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
