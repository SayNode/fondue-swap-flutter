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
  late List<String> unconfirmedWords;
  List<String> confirmedWords = <String>[];
  RxBool rebuildLists = false.obs;
  RxBool wrongOrder = false.obs;
  WalletService walletService = Get.put(WalletService());

  @override
  void onInit() {
    seedPhrase = Mnemonic.generate();
    unconfirmedWords = List<String>.from(seedPhrase);
    unconfirmedWords.shuffle();
    super.onInit();
  }

  bool checkIfAllWordsOrdered({required bool notify}) {
    if (unconfirmedWords.isEmpty) {
      return true;
    } else {
      return false;
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

  Column buildDynamicList(
    List<String> words, {
    required bool confirmedList,
    required bool notify,
  }) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < words.length; i++) {
      if (i.isEven) {
        rows
          ..add(
            Row(
              children: <Widget>[
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
                      text:
                          '${(i + 1).toString().padLeft(2, '0')} | ${words[i]}',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                if (i + 1 < words.length)
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
                        text:
                            '${(i + 2).toString().padLeft(2, '0')} | ${words[i + 1]}',
                      ),
                    ),
                  )
                else
                  const Expanded(child: SizedBox()),
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
