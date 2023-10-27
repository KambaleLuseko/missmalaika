import 'package:provider/provider.dart';

import '../../Resources/Providers/app_state_provider.dart';
import '../../main.dart';

class AppProviders {
  static AppStateProvider appProvider =
      navKey.currentContext!.read<AppStateProvider>();
}
