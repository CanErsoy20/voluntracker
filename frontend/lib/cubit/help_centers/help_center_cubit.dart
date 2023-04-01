import 'package:voluntracker/models/assign_volunteer_model.dart';
import 'package:voluntracker/models/help_center/busiest_hours_model.dart';
import 'package:voluntracker/models/help_center/contact_info_model.dart';
import 'package:voluntracker/models/help_center/create_help_center_model.dart';
import 'package:voluntracker/models/help_center/location_model.dart';
import 'package:voluntracker/models/help_center/open_close_info_model.dart';
import 'package:voluntracker/models/needed_supply/create_needed_supply_model.dart';
import 'package:voluntracker/models/types/supply_types_model.dart';
import 'package:bloc/bloc.dart';

import '../../models/help_center/help_center_model.dart';
import '../../models/needed_volunteer/create_needed_volunteer_model.dart';
import '../../models/types/volunteer_types_model.dart';
import '../../services/help_center_service.dart';
part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit(this.service) : super(HelpCenterInitial()) {
    getSupplyTypes();
    getVolunteerTypes();
  }
  HelpCenterService service;
  List<HelpCenterModel>? helpCenterList;
  HelpCenterModel? selectedCenter;
  HelpCenterModel? myCenter;

  // Create and Update HelpCenter Related
  CreateNeededVolunteer newVolunteerNeed = CreateNeededVolunteer();
  CreateNeededSupply newSupplyNeed = CreateNeededSupply();
  CreateHelpCenter updateHelpCenter = CreateHelpCenter(
      busiestHours: BusiestHours(),
      openCloseInfo: OpenCloseInfo(),
      contactInfo: ContactInfo(),
      location: Location());

  // Types and Categories
  List<SupplyTypeModel>? supplyTypes = [];
  List<VolunteerTypeModel>? volunteerTypes = [];
  List<String> volunteerTypeNames = [];
  List<String> volunteerTypeCategory = [];
  List<String> supplyTypeNames = [];
  List<String> supplyTypeCategory = [];

  Future<void> getHelpCenters() async {
    emit(HelpCenterLoading());
    helpCenterList = await service.getHelpCenters();
    if (helpCenterList != null) {
      emit(HelpCenterDisplay());
    } else {
      emit(HelpCenterError("Not Found", "No Help Center Found"));
    }
  }

  Future<void> getMyCenter() async {
    emit(HelpCenterLoading());
    myCenter = await service.getMyCenter();
    if (myCenter != null) {
      emit(HelpCenterDisplay());
    } else {
      emit(HelpCenterError("Couldn't Found", "Cannot fetch your help center"));
    }
  }

  Future<void> createHelpCenter(CreateHelpCenter bodyModel) async {
    emit(HelpCenterLoading());
    HelpCenterModel? createdCenter = await service.createHelpCenter(bodyModel);
    if (createdCenter == null) {
      emit(HelpCenterError(
          "Creation failed", "Couldnt't create a new help center"));
    } else {
      emit(HelpCenterSuccess(
          "Successfully Created", "Successfully created a new help center"));
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
      emit(HelpCenterSuccess(
          "Successfully Created", "Sucessfully created a new help center"));
    }
  }

  Future<void> updateNeededVolunteer(CreateNeededVolunteer bodyModel,
      int helpCenterID, int neededVolunteerID) async {
    emit(HelpCenterLoading());
    HelpCenterModel? updatedModel = await service.updateNeededVolunteer(
        bodyModel, helpCenterID, neededVolunteerID);
    if (updatedModel == null) {
      emit(HelpCenterError(
          "Couldn't update", "Couldnt update the volunteer need"));
    } else {
      emit(HelpCenterSuccess(
          "Successfully Updated", "Successfully updated the volunteer need"));
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
      emit(HelpCenterSuccess(
          "Successfully Creation", "Successfully created a new supply need"));
    }
  }

  Future<void> updateNeededSupply(CreateNeededSupply bodyModel,
      int helpCenterID, int neededSupplyID) async {
    emit(HelpCenterLoading());
    HelpCenterModel? updatedModel = await service.updateNeededSupply(
        bodyModel, helpCenterID, neededSupplyID);
    if (updatedModel == null) {
      emit(
          HelpCenterError("Couldn't update", "Couldnt update the supply need"));
    } else {
      emit(HelpCenterSuccess(
          "Successfully Updated", "Successfully updated the supply need"));
    }
  }

  Future<void> updateOtherDetails(
      CreateHelpCenter bodyModel, int helpCenterID) async {
    emit(HelpCenterLoading());
    HelpCenterModel? updatedModel =
        await service.updateOtherDetails(bodyModel, helpCenterID);
    if (updatedModel == null) {
      emit(HelpCenterError("Couldn't update", "Couldn't update other details"));
    } else {
      emit(HelpCenterSuccess(
          "Successfully Updated", "Successfully updated other details"));
    }
  }

  Future<void> getSupplyTypes() async {
    supplyTypes = await service.getSupplyTypes();
    for (var i = 0; i < supplyTypes!.length; i++) {
      if (!supplyTypeCategory.contains(supplyTypes![i].category!)) {
        supplyTypeCategory.add(supplyTypes![i].category!);
      }
      if (!supplyTypeNames.contains(supplyTypes![i].typeName!)) {
        supplyTypeNames.add(supplyTypes![i].typeName!);
      }
    }
  }

  Future<void> getVolunteerTypes() async {
    volunteerTypes = await service.getVolunteerTypes();
    for (var i = 0; i < volunteerTypes!.length; i++) {
      if (!volunteerTypeCategory.contains(volunteerTypes![i].category!)) {
        volunteerTypeCategory.add(volunteerTypes![i].category!);
      }
      if (!volunteerTypeNames.contains(volunteerTypes![i].typeName!)) {
        volunteerTypeNames.add(volunteerTypes![i].typeName!);
      }
    }
  }

  Future<void> assignVolunteers(AssignVolunteerModel bodyModel) async {
    emit(HelpCenterLoading());
    HelpCenterModel? response = await service.assignVolunteer(bodyModel);
    if (response == null) {
      emit(
          HelpCenterError("Could not Assign", "Couldn't assign the volunteer"));
    } else {
      emit(HelpCenterSuccess(
          "Assigntment Successful", "Successfully assigned the volunteer"));
    }
  }

  void emitEditing() {
    emit(HelpCenterEditing());
  }

  void emitDisplay() {
    emit(HelpCenterDisplay());
  }
}
