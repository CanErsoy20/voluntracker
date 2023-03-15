import 'package:afet_takip/models/help_center/create_help_center_model.dart';
import 'package:afet_takip/models/needed_supply/create_needed_supply_model.dart';
import 'package:bloc/bloc.dart';

import '../../models/help_center/help_center_model.dart';
import '../../models/needed_volunteer/create_needed_volunteer_model.dart';
import '../../services/help_center_service.dart';
part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit(this.service) : super(HelpCenterInitial());
  HelpCenterService service;
  List<HelpCenterModel>? helpCenterList;
  HelpCenterModel? selectedCenter;
  CreateNeededVolunteer newVolunteerNeed = CreateNeededVolunteer();
  CreateNeededSupply newSupplyNeed = CreateNeededSupply();

  Future<void> getHelpCenters() async {
    emit(HelpCenterLoading());
    helpCenterList = await service.getHelpCenters();

    if (helpCenterList != null) {
      emit(HelpCenterDisplay());
    } else {
      emit(HelpCenterError("Not Found", "No Help Center Found"));
    }
  }

  Future<void> createHelpCenter(CreateHelpCenter bodyModel) async {
    emit(HelpCenterLoading());
    HelpCenterModel? createdCenter = await service.createHelpCenter(bodyModel);
    if (createdCenter == null) {
      emit(HelpCenterError(
          "Creation failed", "Couldnt't create a new help center"));
    } else {
      emit(HelpCenterDisplay());
    }
  }

  Future<void> createNeededVolunteer(
      CreateNeededVolunteer bodyModel, int helpCenterID) async {
    emit(HelpCenterLoading());
    HelpCenterModel? createdVolunteer =
        await service.createNeededVolunteer(bodyModel, helpCenterID);
    if (createdVolunteer == null) {
      emit(HelpCenterError(
          "Creation failed", "Couldnt't create a new volunteer need"));
    } else {
      emit(HelpCenterDisplay());
    }
  }

  Future<void> updateNeededVolunteer(CreateNeededVolunteer bodyModel,
      int helpCenterID, int neededVolunteerID) async {
    emit(HelpCenterLoading());
    HelpCenterModel? updatedModel = await service.updateNeededVolunteer(
        bodyModel, helpCenterID, neededVolunteerID);
    if (updatedModel == null) {
      emit(HelpCenterError(
          "Couldnt update", "Couldnt update the volunteer need"));
    } else {
      emit(HelpCenterDisplay());
    }
  }

  Future<void> createNeededSupply(
      CreateNeededSupply bodyModel, int helpCenterID) async {
    emit(HelpCenterLoading());
    HelpCenterModel? createdVolunteer =
        await service.createNeededSupply(bodyModel, helpCenterID);
    if (createdVolunteer == null) {
      emit(HelpCenterError(
          "Creation failed", "Couldnt't create a new supply need"));
    } else {
      emit(HelpCenterDisplay());
    }
  }

  Future<void> updateNeededSupply(CreateNeededSupply bodyModel,
      int helpCenterID, int neededSupplyID) async {
    emit(HelpCenterLoading());
    HelpCenterModel? updatedModel = await service.updateNeededSupply(
        bodyModel, helpCenterID, neededSupplyID);
    if (updatedModel == null) {
      emit(HelpCenterError("Couldnt update", "Couldnt update the supply need"));
    } else {
      emit(HelpCenterDisplay());
    }
  }
}
