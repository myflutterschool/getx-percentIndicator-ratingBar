import 'package:add_skill_with_getx/model/skill_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddSkillController extends GetxController {
  RxBool isShowRatingBar = false.obs, isShowRegisterButton = false.obs;

  TextEditingController skillTitleTextController = TextEditingController();

  RxList<SkillViewModel> skillList = <SkillViewModel>[].obs;
  RxInt skillRate = 0.obs;

  void addSkill() {
    skillList.add(SkillViewModel(
        rate: skillRate.value, skill: skillTitleTextController.text));
    skillTitleTextController.clear();
    Get.back();
  }
}
