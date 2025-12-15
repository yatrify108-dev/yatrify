
import 'package:yatrify/core/models/temple.dart';
import 'package:yatrify/core/services/firebase_manager_service.dart';

Future<Temple> fetchTempleData() async{
  final fireStore = FirebaseManagerService.currentFirestore;
  final doc = await fireStore.collection('temple').doc('temple_master').get();
  if(!doc.exists){
    throw Exception('Temple data not found');
  }

  final data = doc.data()!;
  return Temple.fromMap(data);
}