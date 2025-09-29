import 'package:bookstay/core/models/temple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Temple> fetchTempleData() async{
  final doc = await FirebaseFirestore.instance.collection('temples').doc('temple_master').get();
  if(!doc.exists){
    throw Exception('Temple data not found');
  }

  final data = doc.data()!;
  return Temple.fromMap(data);
}