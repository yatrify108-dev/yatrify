import 'package:flutter/material.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/core/services/upload_temple_data.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:yatrify/core/models/temple.dart';

class TempleUploadScreen extends StatefulWidget {
  const TempleUploadScreen({super.key});

  @override
  State<TempleUploadScreen> createState() => _TempleUploadScreenState();
}

class _TempleUploadScreenState extends State<TempleUploadScreen> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> _upload(bool toDev) async {
    try {
      isLoading.value = true;

      final app =
          toDev ? FirebaseManagerService.devApp! : FirebaseManagerService.prodApp!;

      await uploadTempleDataToFirebase(templeData, app);

      context.message(
        toDev ? "Uploaded to DEVELOPMENT" : "Uploaded to PRODUCTION",
      );
    } catch (e) {
      context.message("Upload Failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Temple Data")),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (_, loading, __) {
            if (loading) return const CircularProgressIndicator();

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _upload(true),
                  child: const Text("Upload to DEVELOPMENT"),
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () => _upload(false),
                //   child: const Text("Upload to PRODUCTION"),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
