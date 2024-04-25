import 'package:ce_mobile/model/workspace.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveWorkspace(Workspace workspace) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.workspaces.putSync(workspace));
  }

  Stream<List<Workspace>> streamRecentWorkspaces() async* {
    final isar = await db;
    yield* isar.workspaces.where().sortByLastModifiedDesc().watch(fireImmediately: true);
  }

  Future<Isar> openDB() async {
    final directory = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([WorkspaceSchema], directory: directory.path);
    }

    return Future.value(Isar.getInstance());
  }
}
