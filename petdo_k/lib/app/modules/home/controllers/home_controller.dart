import 'dart:collection';

import 'package:get/get.dart';

import '../views/dictionary/controllers/dictionary_controller.dart';
import '../views/dictionary/views/dictionary_summary/controllers/dictionary_summary_controller.dart';
import '../views/dictionary/views/dictionary_summary/views/dictionary_summary_view.dart';
import '../views/dictionary/views/dictionary_view.dart';
import '../views/dictionary/views/search_pet_disease/controllers/search_pet_disease_controller.dart';
import '../views/dictionary/views/search_pet_disease/views/search_disease/controllers/search_disease_controller.dart';
import '../views/dictionary/views/search_pet_disease/views/search_disease/views/search_disease_view.dart';
import '../views/dictionary/views/search_pet_disease/views/search_pet/controllers/search_pet_controller.dart';
import '../views/dictionary/views/search_pet_disease/views/search_pet/views/search_pet_view.dart';
import '../views/dictionary/views/search_pet_disease/views/search_pet_disease_view.dart';
import '../views/health_record/controllers/health_record_controller.dart';
import '../views/health_record/views/add_pet/controllers/controllers/add_pet_controller.dart';
import '../views/health_record/views/add_pet/controllers/views/add_pet_view.dart';
import '../views/health_record/views/health_record_detail/controllers/health_record_detail_controller.dart';
import '../views/health_record/views/health_record_detail/views/examination_add/controllers/examination_add_controller.dart';
import '../views/health_record/views/health_record_detail/views/examination_add/views/examination_add_view.dart';
import '../views/health_record/views/health_record_detail/views/examination_edit/controllers/examination_edit_controller.dart';
import '../views/health_record/views/health_record_detail/views/examination_edit/views/examination_edit_view.dart';
import '../views/health_record/views/health_record_detail/views/examination_schedule/controllers/examination_schedule_controller.dart';
import '../views/health_record/views/health_record_detail/views/examination_schedule/views/examination_schedule_view.dart';
import '../views/health_record/views/health_record_detail/views/health_record_detail_view.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_add/controllers/vaccine_add_controller.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_add/views/vaccine_add_view.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_edit/controllers/vaccine_edit_controller.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_edit/views/vaccine_edit_view.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_schedule/controllers/vaccine_schedule_controller.dart';
import '../views/health_record/views/health_record_detail/views/vaccine_schedule/views/vaccine_schedule_view.dart';
import '../views/health_record/views/health_record_view.dart';
import '../views/setting/controllers/setting_controller.dart';
import '../views/setting/views/setting_view.dart';

class HomeController extends GetxController {
  /// Singleton
  static HomeController get instance => Get.find<HomeController>();

  /// Current View
  final _currentView = MainView.dictionary.obs;

  /// Stack of 3 tabs
  final Map<TabType, ListQueue<MainView>> _mapStackView = {
    TabType.dictionary: ListQueue<MainView>.from([MainView.dictionary]),
    TabType.healthRecord: ListQueue<MainView>.from([MainView.healthRecord]),
    TabType.setting: ListQueue<MainView>.from([MainView.setting]),
  };

  /// Nap View
  final Map<MainView, GetView> _mapViews = {
    /// Dictionary
    MainView.dictionary: DictionaryView(),
    MainView.dictionarySummary: DictionarySummaryView(),
    MainView.searchPetDisease: SearchPetDiseaseView(),
    MainView.searchPet: SearchPetView(),
    MainView.searchDisease: SearchDiseaseView(),

    /// Health record
    MainView.healthRecord: HealthRecordView(),
    MainView.addPet: AddPetView(),
    MainView.healthRecordDetail: HealthRecordDetailView(),
    MainView.vaccineSchedule: VaccineScheduleView(),
    MainView.vaccineAdd: VaccineAddView(),
    MainView.vaccineEdit: VaccineEditView(),
    MainView.examinationSchedule: ExaminationScheduleView(),
    MainView.examinationAdd: ExaminationAddView(),
    MainView.examinationEdit: ExaminationEditView(),

    /// Setting
    MainView.setting: SettingView(),
  };

  GetView? get view => _mapViews[_currentView.value];

  TabType get currentTab => _currentView.value.tab;

  /// Dictionary variables
  var selectedAnimalImage = '';
  var selectedAnimalName = '';

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {}

  void changeMainView(MainView view) {
    if (_mapStackView[view.tab]!.last != view) {
      _mapStackView[view.tab]!.add(view);
      switch (view) {

        /// Dictionary
        case MainView.dictionarySummary:
          Get.reload<DictionarySummaryController>();
          break;
        case MainView.searchPetDisease:
          Get.reload<SearchPetDiseaseController>();
          break;
        case MainView.searchPet:
          Get.reload<SearchPetController>();
          break;
        case MainView.searchDisease:
          Get.reload<SearchDiseaseController>();
          break;

        /// Health Record
        case MainView.addPet:
          Get.reload<AddPetController>();
          break;
        case MainView.healthRecordDetail:
          Get.reload<HealthRecordDetailController>();
          break;
        case MainView.vaccineSchedule:
          Get.reload<VaccineScheduleController>();
          break;
        case MainView.vaccineAdd:
          Get.reload<VaccineAddController>();
          break;
        case MainView.vaccineEdit:
          Get.reload<VaccineEditController>();
          break;
        case MainView.examinationSchedule:
          Get.reload<ExaminationScheduleController>();
          break;
        case MainView.examinationAdd:
          Get.reload<ExaminationAddController>();
          break;
        case MainView.examinationEdit:
          Get.reload<ExaminationEditController>();
          break;

        /// Setting
        default:
          break;
      }
    }
    _currentView.value = view;
  }

  void changeTab(TabType tab) {
    // Người dùng ấn lại vào tab đang chọn
    if (tab == currentTab) {
      // Người dùng ấn lại vào tab đang chọn
      // và trang đầu tiên đang được hiển thị
      switch (_currentView.value) {
        case MainView.dictionary:
          Get.find<DictionaryController>().onReady();
          break;
        case MainView.healthRecord:
          Get.find<HealthRecordController>().onReady();
          break;
        case MainView.setting:
          Get.find<SettingController>().onReady();
          break;
        default:
          break;
      }

      // Người dùng ấn lại vào tab đang chọn -> cho lên trang đầu tiên
      _mapStackView[tab] = ListQueue.from([_mapStackView[tab]!.first]);
    }
    // Chuyển sang view của tab được chọn
    changeMainView(_mapStackView[tab]!.last);
  }

  MainView back() {
    late MainView result;
    if (_mapStackView[_currentView.value.tab]!.length > 1) {
      result = _mapStackView[_currentView.value.tab]!.removeLast();
    } else {
      result = _mapStackView[_currentView.value.tab]!.last;
    }
    changeMainView(_mapStackView[_currentView.value.tab]!.last);
    return result;
  }
}

/// Tab Type
enum TabType { dictionary, healthRecord, setting }

/// Main View
enum MainView {
  /// Dictionary
  dictionary,
  dictionarySummary,
  searchPetDisease,
  searchPet,
  searchDisease,

  /// Health Record
  healthRecord,
  addPet,
  healthRecordDetail,
  vaccineSchedule,
  vaccineAdd,
  vaccineEdit,
  examinationSchedule,
  examinationAdd,
  examinationEdit,

  /// Setting
  setting,
}

/// Get Tab of Main View
extension Tab on MainView {
  TabType get tab {
    switch (this) {

      ///
      case MainView.dictionary:
      case MainView.dictionarySummary:
      case MainView.searchPetDisease:
      case MainView.searchPet:
      case MainView.searchDisease:
        return TabType.dictionary;

      ///
      case MainView.healthRecord:
      case MainView.addPet:
      case MainView.healthRecordDetail:
      case MainView.vaccineSchedule:
      case MainView.vaccineAdd:
      case MainView.vaccineEdit:
      case MainView.examinationSchedule:
      case MainView.examinationAdd:
      case MainView.examinationEdit:
        return TabType.healthRecord;

      ///
      case MainView.setting:
        return TabType.setting;
    }
  }
}
