import 'package:bloc/bloc.dart';

import '../../models/help_center/help_center_model.dart';
import '../../services/help_center_service.dart';
part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit(this.service) : super(HelpCenterInitial());
  HelpCenterService service;
  List<HelpCenterModel>? helpCenterList;

  Future<void> getHelpCenters() async {
    emit(HelpCenterLoading());
    helpCenterList = await service.getHelpCenters();

    if (helpCenterList != null) {
      emit(HelpCenterDisplay());
    } else {
      emit(HelpCenterError("Not Found", "No Help Center Found"));
    }
  }
}
