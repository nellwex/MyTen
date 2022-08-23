//
//  ChatViewModel.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseStorageCombineSwift

class ChatViewModel : ObservableObject{
    
    @State var selectedImage : UIImage?
    @Published var chat : [Chat] = []
   
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    let data = Data()
    var userId = ""
    
    
    
    func upLoadImage(){
        
        guard selectedImage != nil else { return }
        
        let imageData = selectedImage!.jpegData(compressionQuality: 1)
        
        guard imageData != nil else { return }
        
        
    }
    
    func getUserImage(){
        
        var imageRef = storage.child("ProfileImage/\(userId).jpg ")
        
       
    }
    
    func getMessages(byId: String){
        
        db.collection("Person").addSnapshotListener { querySnapshot, error in }
        
    }
    
    
    
    
    
    
   
    @Published var chats = Chat.SampleChat
    
    func getSortedFilteredChat (query: String) -> [Chat] {
        
        let SortedChats = chats.sorted {
         
            guard let date1 = $0.message.last?.date else {return false}
            guard let date2 = $1.message.last?.date else {return false}
        
            return  date1 > date2
           
            
        }
        
        if query == ""{
            return SortedChats
        }
        return SortedChats.filter { $0.person.name.lowercased().contains(query.lowercased()) }
    }
    
    func MarkedAsUnread (_ newValue: Bool, chat: Chat){
        if let index = chats.firstIndex(where: {$0.id == chat.id}){
            chats[index].Unread = newValue
        }
    }
   

    
    func sendingMessage ( input: String, in chat: Chat) -> Message? {
        if let index = chats.firstIndex(where: {$0.id == chat.id}){
            let message = Message(id: UUID(), text: input, type: .Sent, date: Date.now)
            chats[index].message.append(message)
            return message
        }
        return nil
    }

}

