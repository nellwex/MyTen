//
//  ChatModel.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import Foundation

struct Chat : Identifiable{
    var id: UUID { person.id }
    let person: Person
    var message: [Message]
    var Unread = false
    var isFavorite : Bool
}

struct Person : Identifiable{
    
    enum CurrentStatus{
        case free
        case busy
        case out
    }
    
    let id: UUID
    var name: String
    var image: String
    var nickname: String
    var status: CurrentStatus
}



struct Message : Identifiable {
    
    enum MessageType {
        case Sent, Received
    }
    
    let id: UUID
    let text: String
    let date: Date
    let type: MessageType
    
    init(id: UUID, text: String, type: MessageType, date: Date){
        self.id = id
        self.text = text
        self.type = type
        self.date = date
    }
    
    
}



extension Chat {
    static var SampleChat = [
    
        Chat(person: Person(id: UUID(), name: "Joyce", image: "Joyce", nickname: "", status: .free), message: [
            Message(id: UUID(), text: "哈哈哈哈哈", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message(id: UUID(), text: "怎麼了?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message(id: UUID(), text: "你沒帶便當盒啦", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message(id: UUID(), text: "哈哈哈哈笑死，沒關係，那我等等回家吃，或留著晚上吃等等去吃麥當勞", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
        
        ], Unread: false, isFavorite: true),
        Chat(person: Person(id: UUID(), name: "Brian", image: "Brian", nickname: "", status: .busy), message: [
            Message(id: UUID(), text: "I'm working at ASUS now.", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message(id: UUID(), text: "That's Cool.", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
            Message(id: UUID(), text: ":)", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 1)),
            Message(id: UUID(), text: "How's the payment?", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 1)),
        
        ], Unread: false, isFavorite: false),
        Chat(person: Person(id: UUID(), name: "Conan", image: "Conan", nickname: "", status: .free), message: [
            Message(id: UUID(), text: "ARAM?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3)),
            Message(id: UUID(), text: "ARAM!", type: .Sent, date: Date(timeIntervalSinceNow: -86400 * 2)),
        
        ], Unread: false, isFavorite: false),
        Chat(person: Person(id: UUID(), name: "Mom", image: "Mom", nickname: "", status: .out), message: [
            Message(id: UUID(), text: "When will you two come home?", type: .Received, date: Date(timeIntervalSinceNow: -86400 * 3))
        
        ], Unread: true, isFavorite: false),
        
        
    ]
    
    
    
}
