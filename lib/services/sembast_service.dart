import 'dart:async';
import 'dart:developer';

import 'package:ce_mobile/model/workspace.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastService {
  bool isOpen = false;
  late Future<Database> database;

  SembastService() {
    database = openDB();
  }

  Future<Database> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (!isOpen) {
      isOpen = true;
      return await databaseFactoryIo.openDatabase('${dir.path}/workspaces.db');
    }

    return database;
  }

  Future<void> saveWorkspace(Workspace workspace) async {
    final db = await database;
    final store = stringMapStoreFactory.store('workspaces');
    final json = JsonMapper.toMap(workspace) as Map<String, Object?>;

    await db.transaction((transaction) async {
      final record = store.record(workspace.uuid);

      await record
          .put(transaction, json, merge: true)
          .then((value) => log('Updated'));
    });
  }

  Stream<List<Workspace>> streamRecentWorkspaces() async* {
    final db = await database;
    final store = stringMapStoreFactory.store('workspaces');

    yield* store
        .query(finder: Finder(sortOrders: [SortOrder('lastModified', false)]))
        .onSnapshots(db)
        .transform(StreamTransformer<
            List<RecordSnapshot<String, Map<String, Object?>>>,
            List<Workspace>>.fromHandlers(handleData: (data, sink) {
      sink.add(List<Workspace>.generate(data.length, (index) {
        final uuid = data[index].value['uuid']! as String;
        final json = JsonMapper.deserialize<Workspace>(data[index].value)!;
        json.uuid = uuid;
        return json;
      }));
    }));
  }
}
