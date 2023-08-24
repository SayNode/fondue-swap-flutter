import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/home/home_page_loader.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';

import '../../../../services/wallet_service.dart';
import '../../../password_page/password_page.dart';
import '../../wallet_added_page.dart';
import '../../widgets/loading_page.dart';
import '../widgets/seed_word_card.dart';

class SeedController extends GetxController implements GetxService {
  late List<String> seedPhrase;
  late List<String> unconfirmedWords;
  List<String> confirmedWords = [];
  RxBool rebuildLists = false.obs;
  RxBool wrongOrder = false.obs;
  var walletService = Get.put(WalletService());

  @override
  void onInit() {
    seedPhrase = Mnemonic.generate();
    unconfirmedWords = List.from(seedPhrase);
    unconfirmedWords.shuffle();
    super.onInit();
  }

  checkIfAllWordsOrdered(bool notify) {
    if (unconfirmedWords.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void submit() {
    if (listEquals(seedPhrase, confirmedWords)) {
      wrongOrder.value = false;
      Get.to(
        () => PasswordPage(
          submit: (password) async {
            LoadingPage.show();
            await Future.delayed(const Duration(seconds: 1));
            await walletService.importWalletWithSeed(
                password, confirmedWords.join(' '));

            Get.close(2);
            showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return const WalletAddedPage();
                });
            Get.offAll(const HomePageLoader());
          },
        ),
      );
    } else {
      wrongOrder.value = true;
    }
  }

  buildDynamicList(List words, bool confirmedList, bool notify) {
    List<Widget> rows = [];
    for (var i = 0; i < words.length; i++) {
      if (i % 2 == 0) {
        rows.add(
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (confirmedList) {
                      unconfirmedWords.add(words[i]);
                    } else {
                      confirmedWords.add(words[i]);
                    }
                    words.remove(words[i]);
                    rebuildLists.value = !rebuildLists.value;
                  },
                  child: SeedWordCard(
                    text: '${(i + 1).toString().padLeft(2, '0')} | ${words[i]}',
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              (i + 1 < words.length)
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (confirmedList) {
                            unconfirmedWords.add(words[i]);
                          } else {
                            confirmedWords.add(words[i]);
                          }
                          words.remove(words[i]);
                          rebuildLists.value = !rebuildLists.value;
                        },
                        child: SeedWordCard(
                          text:
                              '${(i + 2).toString().padLeft(2, '0')} | ${words[i + 1]}',
                        ),
                      ),
                    )
                  : const Expanded(child: SizedBox())
            ],
          ),
        );
        rows.add(const SizedBox(
          height: 8,
        ));
      }
    }
    return Column(
      children: rows,
    );
  }

  buildStaticSeedGrid() {
//for every second element in seedPhrase
    List<Widget> rows = [];
    for (var i = 0; i < seedPhrase.length; i++) {
      if (i % 2 == 0) {
        rows.add(
          Row(
            children: [
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
        );
        rows.add(const SizedBox(
          height: 8,
        ));
      }
    }
    return Column(
      children: rows,
    );
  }
}
