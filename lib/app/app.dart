import 'package:APKtask/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:APKtask/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:APKtask/ui/views/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:APKtask/ui/views/login/login_view.dart';
import 'package:APKtask/ui/views/profile/profile_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: LoginScreen),
    MaterialRoute(page: ProfileScreen),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}