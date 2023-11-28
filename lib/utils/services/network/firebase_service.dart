import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digiday_admin_panel/utils/services/network/api_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService{
  static FirebaseFirestore fireStore=FirebaseFirestore.instance;
  static FirebaseStorage fireStorage=FirebaseStorage.instance;
  static FirebaseAuth fireAuth=FirebaseAuth.instance;

  static Future<bool> addDocToCollection({required String collection,required Map<String,dynamic> docData})async{
    try{
      await fireStore.collection(collection).add(docData);
      return true;
    }
    on FirebaseException catch(e){
      rethrow;
    }
  }

  static Future<bool> addDocToCollectionWithId({required String collection,required docId,required Map<String,dynamic> docData})async{
    try{
      await fireStore.collection(collection).doc(docId).set(docData);
      return true;
    }
    on FirebaseException catch(e){
      rethrow;
    }
  }

 static Future<DocumentSnapshot<Map<String, dynamic>>?> fetchDocByDocID({required String docId,required String collection})async{
    try{
      DocumentSnapshot<Map<String, dynamic>> result=await fireStore.collection(collection).doc(docId).get();
      return result;
    }on FirebaseException catch(e){
      rethrow;
    }
  }

 static Future<bool?> deleteDocByDocID({required String docId,required String collection})async{
    try{
      await fireStore.collection(collection).doc(docId).delete();
      return true;
    }on FirebaseException catch(e){
      rethrow;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> fetchDocsByWhereClause({required String filterKey, dynamic filterValue,required String collection,
    int? limitCount,
    DocumentSnapshot? lastDocument
  })async{
    try {
      late QuerySnapshot<Map<String, dynamic>> result;
      if(limitCount!=null){

        if(lastDocument!=null){
          result = await fireStore.collection(
              collection).where(filterKey, isEqualTo: filterValue).limit(limitCount).startAfterDocument(lastDocument).get();
        }
        else{
          result = await fireStore.collection(
              collection).where(filterKey, isEqualTo: filterValue).limit(limitCount).get();
        }
      }
      else{
         result = await fireStore.collection(
            collection).where(filterKey, isEqualTo: filterValue).get();
      }

      return result;
    } on FirebaseException catch(e){
      rethrow;
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> fetchDocs(String collection)async{
    try {
      QuerySnapshot<Map<String, dynamic>> result = await fireStore.collection(
          collection).get();
      return result;
    } on FirebaseException catch(e){
      rethrow;
    }
  }

  static Future<bool> updateDocById(Map<String, dynamic> data,String docId,String collection)async{
   try{
     await fireStore.collection(collection).doc(docId).update(data);
     return true;
   } on FirebaseException catch(e){
    rethrow;
    }
  }

  static Future<String?> uploadImageMethod({required String folder,required String fileToUpload,required  String uniqueFileName}) async{
    try {
      Reference referenceRoot = fireStorage.ref();
      Reference referenceDirImages = referenceRoot.child(folder);
      Reference referenceImageToUpload = referenceDirImages.child(
          uniqueFileName);
      await referenceImageToUpload.putFile(File(fileToUpload));
      // String imageUrl = await referenceImageToUpload.getDownloadURL();
      return uniqueFileName;
    } on FirebaseException catch(e){
      rethrow;
    }
  }

  static Future<String?> getLoggedInUserUuId()async {
    try {
      User? loggedInUser = fireAuth.currentUser;
      if(loggedInUser==null){
        throw ApiException(message: "Session Expired",status: 440);
      }
      return loggedInUser?.uid;
    } on FirebaseException catch(e){
      rethrow;
    }
  }

  static  Future<String?> getImageUrl(String path)async {
    try {
      Reference referenceRoot = fireStorage.ref();
      Reference referenceDirImages = referenceRoot.child(path);
      return referenceDirImages.getDownloadURL();
    }on FirebaseException catch(e){
      rethrow;
    }
  }


  Future<Map<dynamic, dynamic>?> get currentUserClaims async {
    final user = fireAuth.currentUser;
    // if refresh is set to true, a refresh of the id token is forced.
    final idtokenresult = await user?.getIdTokenResult(true);
    return idtokenresult?.claims;
  }


  static Future<bool> forgotPassword({required String email}) async {
    bool result=true;
    try{
      await fireAuth.sendPasswordResetEmail(email: email).then((value){
        result=true;
      },
        onError: (value){
          result=false;
        }
      );

      return result;
    }
    on FirebaseException catch(e){
      rethrow;
    }
  }


}