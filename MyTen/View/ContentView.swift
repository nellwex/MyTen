//
//  ContentView.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var ChatView = ChatViewModel()
    
    
    
    @State private var search = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(ChatView.getSortedFilteredChat(query: search)){ chat in
                                    ZStack {
                                       
                                        
                                        NavigationLink(destination: {
                                            ChatRoom(chat: chat)
                                                .environmentObject(ChatView)
                                           
                                        })
                                        {
                                            ChatRow(chat: chat)
                                                .padding(15)
    //                                            .onLongPressGesture(minimumDuration: 1.5){
    //                                                ChatView.MarkedAsUnread(!chat.Unread, chat: chat)
    //
    //                                            }
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        
                                    }
                                    
    //                                .swipeActions(edge: .leading, allowsFullSwipe: true){
    //                                    Button(action: {ChatView.MarkedAsUnread(!chat.Unread, chat: chat)}){
    //
                                    
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.67, alignment: .center)
                    
                    Spacer()
                }
               
                
                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.15, alignment: .center)
                            .foregroundColor(Color.white)
                           
                        
                        HStack {
                            VStack {
                                Button{}label: {
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: UIScreen.main.bounds.height*0.08))
                                        .foregroundColor(Color("MainPink"))
                                }
                                Text("密友群")
                                    .foregroundColor(Color.secondary)
                            }.padding(5)
                            VStack {
                                Button{}label: {
                                    Image(systemName: "plus.bubble.fill")
                                        .font(.system(size: UIScreen.main.bounds.height*0.08))
                                        .foregroundColor(Color("MainPink"))
                                }
                                Text("密友聊聊")
                                    .foregroundColor(Color.blue)
                            }.padding(5)
                            VStack {
                                Button{}label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.system(size: UIScreen.main.bounds.height*0.08))
                                        .foregroundColor(Color("MainPink"))
                                }
                                Text("設定")
                                    .foregroundColor(Color.gray)
                            }.padding(5)
                        }
                    }
                }
                .ignoresSafeArea(.all)
            }
            
        }
        .searchable(text: $search)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
