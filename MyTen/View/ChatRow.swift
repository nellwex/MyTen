//
//  ChatRow.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI

struct ChatRow: View {
    
    let chat: Chat
    let ScreenWidth = UIScreen.main.bounds.width
    @EnvironmentObject var viewmodel : ChatViewModel
    @StateObject var ChatView = ChatViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 5) {
                ZStack {
                    Rectangle()
                        .frame(width: ScreenWidth*0.65, height: ScreenWidth*0.35, alignment: .leading)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .cornerRadius(25)
                        .shadow(color: Color("MainOrange"), radius: 10, x: 0, y: 0)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(chat.person.name)
                                .font(.system(size: ScreenWidth*0.053))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .bold()
                                .padding(.leading, 10)
                            
                            
                            Text(chat.message.last?.date.descriptiveString() ?? "" )
                                .frame(width: ScreenWidth*0.4, height: 40, alignment: .trailing)
                                .foregroundColor(Color("MainOrange"))
                            
                            
                            Circle()
                                .font(.body)
                                .foregroundColor(chat.Unread ? Color.red : .clear)
                                .frame(width: ScreenWidth*0.025, height: ScreenWidth*0.025, alignment: .center)
                            
                            
                        }
                        
                        Text(chat.message.last?.text.description ?? "")
                            .frame(width: ScreenWidth*0.55, height: ScreenWidth*0.2, alignment: .center)
                            .foregroundColor(Color.gray)
                            .lineLimit(2)
                            .padding(3)
                    }
                }
                .contextMenu{
                    Button(action: {ChatView.MarkedAsUnread(!chat.Unread, chat: chat)}){
                        HStack{
                            Text("標示為已讀")
                            Image(systemName: "envelope.open")
                                .foregroundColor(Color("MainPink"))
                        }
                    }
                }

                .padding()
                
                HStack {
                    
                    VStack{
                        Button{}label: {
                            Image(systemName: "text.book.closed")
                                .font(.system(size: ScreenWidth*0.07))
                                .foregroundColor(Color("MainOrange"))
                                .padding(10)
                        }
                        Spacer()
                    }
                    .frame(height: ScreenWidth*0.4, alignment: .center)
                    
                    Image(chat.person.image)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: ScreenWidth*0.4, height: ScreenWidth*0.4, alignment: .center)
                        .padding(5)
                        .contextMenu{
                            Button{}label: {
                                HStack {
                                    Text("刪除好友")
                                    Image(systemName: "trash")
                                        .foregroundColor(.red.opacity(0.9))
                                }
                                
                            }
                    }
                    
                    VStack{
                        Button{}label: {
                            Image(systemName: "calendar")
                                .font(.system(size: ScreenWidth*0.07))
                                .foregroundColor(Color("MainOrange"))
                                .padding(10)
                        }
                        Spacer()
                    }
                    .frame(height: ScreenWidth*0.4, alignment: .center)
                }
                
                HStack{
                    switch(chat.person.status){
                    case.free:
                        Circle()
                            .frame(width: ScreenWidth*0.03, height: ScreenWidth*0.03, alignment: .center)
                            .foregroundColor(Color.green)
                        Text("有空")
                            .foregroundColor(Color.green)
                    case.busy:
                        Circle()
                            .frame(width: ScreenWidth*0.03, height: ScreenWidth*0.03, alignment: .center)
                            .foregroundColor(Color.red)
                        Text("忙碌中")
                            .foregroundColor(Color.red)
                    case.out:
                        Circle()
                            .frame(width: ScreenWidth*0.03, height: ScreenWidth*0.03, alignment: .center)
                            .foregroundColor(Color.yellow)
                        Text("外出中")
                            .foregroundColor(Color.yellow)
                    }



                }
                
                
                
                
            }
            
            
        }
    }
    
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chat: Chat.SampleChat[0])
    }
}
