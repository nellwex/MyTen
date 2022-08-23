//
//  ContentView.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var ChatView = ChatViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    @State var showSetting : Bool = false
    @State private var search = ""
    
    var body: some View {
        NavigationView{
            VStack {
                //聊天導覽
                VStack {
                    
                    TextField("", text: $search)
                        .frame(width: .infinity, height: 10, alignment: .center)
                    
                    
                    
                    ScrollViewReader { scrollview in
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(ChatView.getSortedFilteredChat(query: search)){ chat in
                                    
                                    HStack {
                                        
                                        NavigationLink(destination: {
                                            ChatRoom(chat: chat)
                                                .environmentObject(ChatView)
                                            
                                        })
                                        {
                                            ChatRow(chat: chat)
                                                .padding(15)
                                            
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                }
                                
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.67, alignment: .center)
                }
                
                
                Spacer()
                
                //menu
                HStack {
                    VStack {
                        Button{}label: {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: UIScreen.main.bounds.height*0.05))
                                .foregroundColor(Color("MainOrange"))
                        }
                        Text("我的頁面")
                            .foregroundColor(Color.gray)
                    }
                    .padding(10)
                    
                    VStack {
                        Button{}label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: UIScreen.main.bounds.height*0.05))
                                .foregroundColor(Color("MainOrange"))
                        }
                        Text("新增好友")
                            .foregroundColor(Color.gray)
                    }
                    .padding(10)
                    
                    VStack {
                        Button{}label: {
                            Image(systemName: "gear")
                                .font(.system(size: UIScreen.main.bounds.height*0.05))
                                .foregroundColor(Color("MainOrange"))
                        }
                        Text("偏好設定")
                            .foregroundColor(Color.gray)
                    }
                    .padding(10)
                    .onTapGesture {
                        showSetting.toggle()
                    }
                    .sheet(isPresented: $showSetting) {
                        SettingView()
                            .onDisappear(){
                                showSetting = false
                            }
                    }
                }
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
