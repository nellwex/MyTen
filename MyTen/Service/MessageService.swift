//
//  MessageService.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/20.
//
import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseStorageCombineSwift


class MessageService : ObservableObject{
    
    @State var selectedImage : UIImage?
    @Published var chat : [Chat] = []
   
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    let data = Data()
    var userId = ""
    var userImage = storage.child("ProfileImage/\(userId).jpg ")
    
    
    func upLoadUserImage(){
        
        guard selectedImage != nil else { return }
        
        let imageData = selectedImage!.jpegData(compressionQuality: 1)
        
        guard imageData != nil else { return }
        
        
    }
    
    func getUserImage(){
        
        var imageRef = storage.child("ProfileImage/\(userId).jpg ")
        
       
    }
    
    func getMessages(byId: String){
        
        
        
    }
}
