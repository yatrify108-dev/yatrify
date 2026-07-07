import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/bajana_audio_service.dart';
import 'package:yatrify/core/services/locale_service.dart';
import 'package:yatrify/features/firebase_manager/firebase_manager.dart';
import 'package:yatrify/features/widgets/mini_player.dart';
import 'package:yatrify/features/widgets/temple_media_widget.dart';
import 'package:yatrify/utils/color.schemes.g.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:yatrify/utils/media_utils.dart';

class BhajansViewPage extends StatefulWidget {
  const BhajansViewPage({super.key, required this.bhajans});

  final List<Bhajans> bhajans;

  @override
  State<BhajansViewPage> createState() => _BhajansViewPageState();
}

class _BhajansViewPageState extends State<BhajansViewPage> {
  final TextEditingController searchController = TextEditingController();

  late final ValueNotifier<List<Bhajans>> filteredBhajans;
  ValueNotifier<bool> isSearch = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    filteredBhajans = ValueNotifier((widget.bhajans));
  }

  void _search(String query) {
    if (query.trim().isEmpty) {
      filteredBhajans.value = widget.bhajans;
      return;
    }
    final lowerQuery = query.toLowerCase();
    filteredBhajans.value = widget.bhajans.where((bhajan) {
      if (bhajan.name == null) return false;
      return bhajan.name!.values.any(
        (value) => value.toLowerCase().contains(lowerQuery),
      );
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    filteredBhajans.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final label = context.labels;
    const double miniPlayerHeight = 74;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    return ValueListenableBuilder<bool>(
        valueListenable: BhajanAudioService.instance.showMiniPlayer,
        builder: (context, showMini, _) {
          return Scaffold(
            extendBody: true,
            bottomNavigationBar: showMini
                ? const SafeArea(
                    top: false,
                    child: MiniPlayer(),
                  )
                : null,
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: Text(
                label.bhajans,
                style: context.style.titleLarge!
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              actions: [
                if (widget.bhajans.length > 1)
                  IconButton(
                    onPressed: () {
                      isSearch.value = true;
                    },
                    icon: const Icon(Icons.search),
                  ),
              ],
            ),
            body: Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: isSearch,
                    builder: (context, search, child) {
                      if (!search) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: context.scheme.outlineVariant),
                          ),
                          child: ValueListenableBuilder(
                              valueListenable: searchController,
                              builder: (context, value, child) {
                                return TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.only(left: 12, top: 8),
                                    hintText: label.searchBhajans,
                                    hintStyle: TextStyle(
                                      color: context.scheme.outlineVariant,
                                    ),
                                    suffixIcon: (value.text.isNotEmpty)
                                        ? GestureDetector(
                                            onTap: () {
                                              searchController.clear();
                                              _search('');
                                            },
                                            child: const Icon(Icons.close),
                                          )
                                        : null,
                                  ),
                                  onChanged: _search,
                                );
                              }),
                        ),
                      );
                    }),
                Expanded(
                  child: ValueListenableBuilder<List<Bhajans>>(
                    valueListenable: filteredBhajans,
                    builder: (context, list, _) {
                      if (list.isEmpty) {
                        return Center(
                          child: Text(label.noBhajansAvailable),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.fromLTRB(
                          16,
                          10,
                          16,
                          showMini
                              ? miniPlayerHeight + bottomSafeArea + 16
                              : bottomSafeArea + 16,
                        ),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final bhajan = list[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {
                                    try {
                                      final url = bhajan.url?.toString() ?? "";

                                      if (url.isEmpty) return;

                                      if (MediaUtils.isVideoUrl(url)) {
                                        showGeneralDialog(
                                          context: context,
                                          barrierColor:
                                              Colors.black.withOpacity(0.4),
                                          barrierDismissible: true,
                                          barrierLabel: 'Video overlay',
                                          transitionDuration:
                                              const Duration(milliseconds: 250),
                                          pageBuilder: (context, anim1, anim2) {
                                            return VideoOverlayPlayer(
                                                videoUrl: url);
                                          },
                                        );
                                        return;
                                      }

                                      if (MediaUtils.isAudioUrl(url)) {
                                        final originalIndex =
                                            widget.bhajans.indexWhere(
                                          (e) => e.url == bhajan.url,
                                        );
                                        // context.push(
                                        //   '/audio-player',
                                        //   extra: {
                                        //     'bhajans': widget.bhajans,
                                        //     'index': originalIndex == -1
                                        //         ? 0
                                        //         : originalIndex,
                                        //   },
                                        // );
                                        context.push('/audio-player');

                                        BhajanAudioService.instance
                                            .loadPlaylist(
                                          bhajans: widget.bhajans,
                                          startIndex: originalIndex == -1
                                              ? 0
                                              : originalIndex,
                                        );
                                      }
                                      isSearch.value = false;
                                      searchController.clear();
                                      _search('');
                                    } catch (e, stackTrace) {
                                      FirebaseManager()
                                          .reportError(e, stackTrace);
                                    }
                                  },
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: bhajan.image!,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    LocaleService.getLocalized(bhajan.name!),
                                    style: context.style.titleSmall,
                                    maxLines: 2,
                                    // textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: const Text(""),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  thickness: 0.5,
                                  color: Colors.grey.withOpacity(0.4),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
