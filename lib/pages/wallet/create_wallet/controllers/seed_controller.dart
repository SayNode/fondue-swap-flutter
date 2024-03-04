import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';

import '../../../../services/wallet_service.dart';
import '../../../home/home_page_loader.dart';
import '../../../password_page/password_page_old.dart';
import '../../wallet_added_page.dart';
import '../../widgets/loading_page.dart';
import '../widgets/seed_word_card.dart';

class SeedController extends GetxController implements GetxService {
  late List<String> seedPhrase;
  late RxList<String> unconfirmedWords;
  RxList<String> confirmedWords = <String>[].obs;
  RxBool wrongOrder = false.obs;
  WalletService walletService = Get.put(WalletService());
  RxBool isAllWordsOrdered = false.obs;

  @override
  void onInit() {
    seedPhrase = Mnemonic.generate();
    unconfirmedWords = List<String>.from(seedPhrase).obs;
    unconfirmedWords.shuffle();
    super.onInit();
  }

  void checkIfAllWordsOrdered() {
    if (unconfirmedWords.isEmpty) {
      isAllWordsOrdered.value = true;
    } else {
      isAllWordsOrdered.value = false;
    }
  }

  void submit() {
    if (listEquals(seedPhrase, confirmedWords)) {
      wrongOrder.value = false;
      Get.to<Widget>(
        () => PasswordPageOld(
          submit: (String password) async {
            LoadingPage.show();
            // ignore: inference_failure_on_instance_creation, always_specify_types
            await Future.delayed(const Duration(seconds: 1));
            await walletService.importWalletWithSeed(
              password,
              confirmedWords.join(' '),
            );

            Get.close(2);
            await showDialog<Widget>(
              context: Get.context!,
              builder: (BuildContext context) {
                return const WalletAddedPage();
              },
            );
            await Get.offAll<Widget>(const HomePageLoader());
          },
        ),
      );
    } else {
      wrongOrder.value = true;
    }
  }

  Widget buildDynamicList(
    List<String> words, {
    required bool confirmedList,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: words.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 22 / 30,
        mainAxisSpacing: 5,
        crossAxisSpacing: 3,
        mainAxisExtent: 50,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            if (confirmedList) {
              unconfirmedWords.add(words[index]);
            } else {
              confirmedWords.add(words[index]);
            }
            words.remove(words[index]);
            confirmedWords.refresh();
            unconfirmedWords.refresh();
            checkIfAllWordsOrdered();
          },
          child: SeedWordCard(
            text: '${(index + 1).toString().padLeft(2, '0')} | ${words[index]}',
          ),
        );
      },
    );
  }

  Column buildStaticSeedGrid() {
//for every second element in seedPhrase
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < seedPhrase.length; i++) {
      if (i.isEven) {
        rows
          ..add(
            Row(
              children: <Widget>[
                Expanded(
                  child: SeedWordCard(
                    text:
                        '${(i + 1).toString().padLeft(2, '0')} | ${seedPhrase[i]}',
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: SeedWordCard(
                    text:
                        '${(i + 2).toString().padLeft(2, '0')} | ${seedPhrase[i + 1]}',
                  ),
                ),
              ],
            ),
          )
          ..add(
            const SizedBox(
              height: 8,
            ),
          );
      }
    }
    return Column(
      children: rows,
    );
  }
}
