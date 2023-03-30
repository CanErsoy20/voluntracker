import 'package:afet_takip/models/create_team_model.dart';
import 'package:afet_takip/models/user/user_info.dart';
import 'package:bloc/bloc.dart';

import '../../services/team_service.dart';
part 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit(this.service) : super(TeamInitial());
  TeamService service;
  CreateTeamModel newTeam = CreateTeamModel();
  Future<void> createNewTeam() async {
    emit(TeamLoading());
    newTeam.helpCenterId = UserInfo.loggedUser!.volunteer!.helpCenterId!;
    bool response = await service.createNewTeam(
        newTeam, UserInfo.loggedUser!.volunteer!.helpCenterId!);
    if (response) {
      emit(TeamSuccess(
          "Creation Successful", "Successfully created a new team"));
    } else {
      emit(TeamError("Creation Failed", "Could not create a new team"));
    }
  }
}
