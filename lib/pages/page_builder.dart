import 'package:lernplatform/datenklassen/LernfeldPage.dart';

import '../datenklassen/folder_types.dart';
import '../datenklassen/thema_page.dart';

class PageLoader {
  LernfeldPage load(Lernfeld lernfeld) {
    return LernfeldPage(lernfeld: lernfeld);
  }
}


