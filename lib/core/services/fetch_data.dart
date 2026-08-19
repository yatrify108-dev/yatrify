
import 'package:yatrify/core/models/home_stay.dart';
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




Future<HomeStay> fetchHomeStayData() async{
  final fireStore = FirebaseManagerService.currentFirestore;
  final doc = await fireStore.collection('homestay').doc('homestay_master').get();
  if(!doc.exists){
    throw Exception('Home Stay data not found');
  }

  final data = doc.data()!;
  return HomeStay.fromMap(data);
}