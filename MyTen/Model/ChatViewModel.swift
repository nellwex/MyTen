//
//  ChatViewModel.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import Foundation

class ChatViewModel : ObservableObject{
    
    @Published var chats = Chat.SampleChat
    
    func getSortedFilteredChat (query: String) -> [Chat] {
        
        let SortedChats = chats.sorted {
            guard let date1 = $0.message.last?.date else {return false}
            guard let date2 = $1.message.last?.date else {return false}
            return date1 > date2
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
   
    func getSection (for chat: Chat) -> [[Message]] {
        var res = [[Message]]()
        var tpm = [Message]()
        for message in chat.message{
            if let firstMessage = tpm.first{
                let daysBetween = firstMessage.date.dayBetween(date: message.date)
                if daysBetween >= 1 {
                    res.append(tpm)
                    tpm.removeAll()
                    tpm.append(message)
                }else{
                    tpm.append(message)
                }
            }else{
                tpm.append(message)
            }
        }
        res.append(tpm)
        return res
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

