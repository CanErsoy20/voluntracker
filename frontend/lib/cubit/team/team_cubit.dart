import 'package:voluntracker/models/create_team_model.dart';
import 'package:voluntracker/models/user/user_info.dart';
import 'package:bloc/bloc.dart';

import '../../models/add_volunteer_response_model.dart';
import '../../models/volunteer_model.dart';
import '../../models/volunteer_team_model.dart';
import '../../services/team_service.dart';
part 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit(this.service) : super(TeamInitial());
  TeamService service;
  CreateTeamModel newTeam = CreateTeamModel();
  VolunteerTeam selectedTeam = VolunteerTeam(volunteers: []);
  List<Volunteer> volunteersToAdd = [];
  Future<void> createNewTeam() async {
    emit(TeamLoading());

    List<VolunteerTeam>? response = await service.createNewTeam(
        newTeam, UserInfo.loggedUser!.volunteer!.helpCenterId!);
    if (response != null) {
      emit(TeamSuccess(
          "Creation Successful", "Successfully created a new team"));
    } else {
      emit(TeamError("Creation Failed", "Could not create a new team"));
    }
  }

  Future<void> addVolunteers() async {
    emit(TeamLoading());
    List<int> volunteerIdList = [];
    for (var i = 0; i < volunteersToAdd.length; i++) {
      volunteerIdList.add(volunteersToAdd[i].id!);
    }
    AddVolunteerResponseModel? response = await service.addVolunteers(
        selectedTeam.helpCenterId!, selectedTeam.id!, volunteerIdList);
    if (response != null) {
      emit(TeamSuccess(
          "Add Successful", "Successfully added volunteers to the team"));
    } else {
      emit(TeamError(
          "Adding Failed", "Could not add the volunteers to the team"));
    }
  }

  bool isInList(Volunteer volunteer) {
    return volunteersToAdd.contains(volunteer);
  }

  void addToList(Volunteer volunteer) {
    emit(TeamVolunteerAdding());
    volunteersToAdd.add(volunteer);
    emit(TeamDisplay());
  }

  void removeFromList(int index) {
    emit(TeamVolunteerRemove());
    volunteersToAdd.removeAt(index);
    emit(TeamDisplay());
  }

  void emitDisplay() {
    emit(TeamDisplay());
  }

  void emitLoading() {
    emit(TeamLoading());
  }
}
