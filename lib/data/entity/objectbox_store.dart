import 'package:flutter_developer_assessment/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxStore {
  late final Store store;

  ObjectBoxStore._create(this.store);

  static Future<ObjectBoxStore> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${dir.path}/objectbox');
    return ObjectBoxStore._create(store);
  }
}