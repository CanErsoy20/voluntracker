import 'package:afet_takip/models/help_center/create_help_center_model.dart';
import 'package:bloc/bloc.dart';

import '../../models/help_center/help_center_model.dart';
import '../../services/help_center_service.dart';
part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit(this.service) : super(HelpCenterInitial());
  HelpCenterService service;
  List<HelpCenterModel>? helpCenterList;
  HelpCenterModel? selectedCenter;

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
}
