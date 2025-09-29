import 'package:bookstay/core/models/temple.dart';
import 'package:bookstay/core/services/upload_temple_data.dart';
import 'package:bookstay/features/widgets/app_button.dart';
import 'package:bookstay/utils/extensions.dart';
import 'package:flutter/material.dart';

class TempleUploadScreen extends StatefulWidget {
  const TempleUploadScreen({super.key});

  @override
  State<TempleUploadScreen> createState() => _TempleUploadScreenState();
}

class _TempleUploadScreenState extends State<TempleUploadScreen> {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> _handleUpload() async {
  print("Upload started");
  isLoading.value = true;

  try {
    await uploadTempleDataToFirebase(templeData);
    print("Upload success");
    context.message("Temple data uploaded successfully");
  } catch (e, st) {
    print("Upload error: $e");
    print("StackTrace: $st");
    context.message("Upload failed: $e");
  } finally {
    isLoading.value = false;
    print("Loading set to false");
  }
}


  @override
  void dispose() {
    isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Temple Data")),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, loading, _) {
            return loading
                ? const CircularProgressIndicator()
                : AppButton(
                    label: 'Upload Temple Data to Firebase',
                    onPressed:(){
                      _handleUpload();
                    },
                  );
          },
        ),
      ),
    );
  }
}
