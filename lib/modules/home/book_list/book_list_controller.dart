import 'package:get/get.dart';

import '../../../api/api.dart';
import '../../../models/book_category.dart';
import '../../../util/extensions/future_extension.dart';
import '../../../util/loadState/load_state.dart';

class BookListController extends GetxController
    with SingleGetTickerProviderMixin, LoadState {
  late BookCategory category;

  @override
  void onReady() {
    super.onReady();
    request();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   request();

  //   bookStatus.listen((_) {
  //     isFirstLoad = true;
  //     update();
  //     request();
  //   });
  // }

  @override
  request({bool pullDown = true}) {
    super.request(pullDown: pullDown);
    Api.share
        .bookList(page: page, perPage: perPage)
        .toastWhenError()
        .then((value) {
      isFirstLoad = false;
      configDataSource(value);
    }).catchError((err) {
      if (isFirstLoad) {
        isFirstLoadError = true;
      }
      endRefreshing();
    }).whenComplete(() {
      update();
    });
  }
}
