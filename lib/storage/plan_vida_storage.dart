import 'package:hive/hive.dart';
import '../models/plan_vida_section.dart';

class PlanVidaStorage {
  static const String boxName = 'plan_vida_box';

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(PlanVidaSectionAdapter());
    }
    await Hive.openBox<PlanVidaSection>(boxName);
  }

  static Box<PlanVidaSection> get box =>
      Hive.box<PlanVidaSection>(boxName);

  static List<PlanVidaSection> getAll() {
    return box.values.toList();
  }

  static Future<void> add(PlanVidaSection section) async {
    await box.put(section.id, section);
  }

  static Future<void> delete(String id) async {
    await box.delete(id);
  }

  static Future<void> clear() async {
    await box.clear();
  }
}
