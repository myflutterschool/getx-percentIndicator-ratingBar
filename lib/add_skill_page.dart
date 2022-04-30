import 'package:add_skill_with_getx/util/skill_rate_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'controller/add_skill_controller.dart';

class AddSkillPage extends StatelessWidget {
  const AddSkillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddSkillController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Skill'),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  Widget _body(final BuildContext context) => Obx(()=> Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _addSkillButton(context),
              const SizedBox(
                height: 20,
              ),
              _skillPercetageView()
            ],
          ),
        ),
  );

  Widget _skillPercetageView() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
          children: _controller.skillList.map(
            (final skill) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularPercentIndicator(
                radius: 60,
                backgroundColor: Colors.grey,
                lineWidth: 6,
                progressColor: SkillRateColor.getSkillRateColor(skill.rate),
                percent: skill.rate/5,
                center: Text(skill.skill,style: const TextStyle(color: Colors.grey),),
              ),
            ),
          ).toList(),
        ),
  );

  Widget _addSkillButton(final BuildContext context) => ElevatedButton(
      onPressed: () async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'add skill',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue),
            ),
            actions: [_dialogBody()],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: const Text('Add skill'));

  Widget _dialogBody() => Obx(
        () => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _addSkillTextField(),
              const SizedBox(
                height: 20,
              ),
              _controller.isShowRatingBar.value
                  ? _ratingBar()
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 20,
              ),
              _controller.isShowRegisterButton.value
                  ? _skillRegisterButton()
                  : const SizedBox.shrink()
            ],
          ),
        ),
      );

  Widget _skillRegisterButton() => ElevatedButton(
      onPressed: () {
        _controller.isShowRatingBar(false);
        _controller.addSkill();
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: const Text('Register'));

  Widget _ratingBar() => RatingBar.builder(
      allowHalfRating: false,
      initialRating: 0,
      itemCount: 5,
      itemBuilder: (context, _) {
        return const Icon(
          Icons.star,
          color: Colors.orange,
        );
      },
      onRatingUpdate: (rate) {
        _controller.isShowRegisterButton(true);
        _controller.skillRate(rate.toInt());
      });

  Widget _addSkillTextField() {
    return SizedBox(
      width: 250,
      height: 40,
      child: TextField(
        controller: _controller.skillTitleTextController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            _controller.isShowRatingBar(true);
          } else {
            _controller.isShowRegisterButton(false);
            _controller.isShowRatingBar(false);
          }
        },
        decoration: const InputDecoration(
            labelText: 'Enter Skill',
            hintText: 'Enter Skill',
            border: OutlineInputBorder()),
      ),
    );
  }

  AddSkillController get _controller => Get.find<AddSkillController>();
}
