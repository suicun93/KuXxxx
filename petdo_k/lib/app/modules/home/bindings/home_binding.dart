import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../views/dictionary/controllers/dictionary_controller.dart';
import '../views/dictionary/views/dictionary_summary/controllers/dictionary_summary_controller.dart';
import '../views/dictionary/views/search_pet_disease/controllers/search_pet_disease_controller.dart';
import '../views/dictionary/views/search_pet_disease/views/search_disease/controllers/search_disease_controller.dart';
import '../views/dictionary/views/search_pet_disease/views/search_pet/controllers/search_pet_controller.dart';
import '../views/health_record/controllers/health_record_controller.dart';
import '../views/health_record/views/add_pet/controllers/controllers/add_pet_controller.dart';
import '../views/health_record/views/health_record_detail/controllers/health_record_detail_controller.dart';
import '../views/health_record/views/health_record_detail/views/examination_add/controllers/examination_add_controller.dart';
import '../views/health_record/views/health_record_detail/views/examination_edit/controllers/examination_edit_controller.dart';
import '../views/health_record/views/health_record_detail/views/examination_schedule/controllers/examination_schedule_controller.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_add/controllers/vaccine_add_controller.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_edit/controllers/vaccine_edit_controller.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_schedule/controllers/vaccine_schedule_controller.dart';
import '../views/setting/controllers/setting_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    /// Dictionary
    Get.lazyPut<DictionaryController>(
      () => DictionaryController(),
    );
    Get.lazyPut<DictionarySummaryController>(
      () => DictionarySummaryController(),
    );
    Get.lazyPut<SearchPetDiseaseController>(
      () => SearchPetDiseaseController(),
    );
    Get.lazyPut<SearchPetController>(
      () => SearchPetController(),
    );
    Get.lazyPut<SearchDiseaseController>(
      () => SearchDiseaseController(),
    );

    /// Health record
    Get.lazyPut<HealthRecordController>(
      () => HealthRecordController(),
    );
    Get.lazyPut<AddPetController>(
      () => AddPetController(),
    );
    Get.lazyPut<HealthRecordDetailController>(
      () => HealthRecordDetailController(),
    );
    Get.lazyPut<VaccineScheduleController>(
      () => VaccineScheduleController(),
    );
    Get.lazyPut<VaccineAddController>(
      () => VaccineAddController(),
    );
    Get.lazyPut<VaccineEditController>(
      () => VaccineEditController(),
    );
    Get.lazyPut<ExaminationScheduleController>(
      () => ExaminationScheduleController(),
    );
    Get.lazyPut<ExaminationAddController>(
      () => ExaminationAddController(),
    );
    Get.lazyPut<ExaminationEditController>(
      () => ExaminationEditController(),
    );

    /// Setting
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}
