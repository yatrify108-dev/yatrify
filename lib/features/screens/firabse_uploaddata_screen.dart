import 'package:flutter/material.dart';
import 'package:yatrify/core/models/home_stay.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';
import 'package:yatrify/core/services/upload_firebasedata_data.dart';
import 'package:yatrify/utils/extensions.dart';
import 'package:yatrify/core/models/temple.dart';

class FirebaseDataUploadScreen extends StatefulWidget {
  const FirebaseDataUploadScreen({super.key});

  @override
  State<FirebaseDataUploadScreen> createState() => _FirebaseDataUploadScreenState();
}

class _FirebaseDataUploadScreenState extends State<FirebaseDataUploadScreen> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> _uploadTemple(bool toDev) async {
    try {
      isLoading.value = true;

      final app =
          toDev ? FirebaseManagerService.devApp! : FirebaseManagerService.prodApp!;

      await uploadTempleDataToFirebase(templeData, app);

      context.message(
        toDev ?  "Temple uploaded to DEVELOPMENT"
            : "Temple uploaded to PRODUCTION",
      );
    } catch (e) {
      context.message("Upload Failed: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _uploadPG(bool toDev) async {
    try {
      isLoading.value = true;

      final app = toDev
          ? FirebaseManagerService.devApp!
          : FirebaseManagerService.prodApp!;


      await uploadHomeStayDataToFirebase(
        homeStayData,
        app,
      );


      context.message(
        toDev
            ? "PG uploaded to DEVELOPMENT"
            : "PG uploaded to PRODUCTION",
      );

    } catch (e) {
      context.message("PG Upload Failed: $e");
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
                  onPressed: () => _uploadTemple(true),
                  child: const Text("Upload Temple DEVELOPMENT"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _uploadTemple(false),
                  child: const Text("Upload Temple PRODUCTION"),
                ),

                const SizedBox(height: 30),



                // PG Development
                ElevatedButton(
                  onPressed: () => _uploadPG(true),
                  child: const Text(
                    "Upload PG DEVELOPMENT",
                  ),
                ),


                const SizedBox(height: 15),


                // PG Production
                ElevatedButton(
                  onPressed: () => _uploadPG(false),
                  child: const Text(
                    "Upload PG PRODUCTION",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
