//
//  ChatRoom.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI

struct ChatRoom: View {
    
    @State private var textIuput = ""
    @FocusState private var isFocused
    @State private var messageIDtoScroll : UUID?
    let ScreenWidth = UIScreen.main.bounds.width
    
    let chat : Chat
    
    @EnvironmentObject var ViewModel : ChatViewModel
    
    var body: some View {
        VStack(spacing:0) {
            GeometryReader{ reader in
                ScrollView(){
                    ScrollViewReader { scrollReader in
                        getMessageView(viewWidth: reader.size.width)
                            .padding(.horizontal)
                            .onChange(of: messageIDtoScroll){_ in
                                if let messageID = messageIDtoScroll{
                                    ScrollToMessage(messageID: messageID, shouldAnimate: true, scrollReader: scrollReader)
                                }
                            }
                            .onAppear{
                                if let messageID = chat.message.last?.id{
                                    ScrollToMessage(messageID: messageID, anchor: .bottom , shouldAnimate: false, scrollReader: scrollReader)
                                }
                            }
                    }
                }
                
            }
            .background(Color(hue: 0.541, saturation: 0.042, brightness: 0.94))
            .padding(0)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    profileButton
                        .padding()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    CallButton
                }
            }
            .onAppear(){
                ViewModel.MarkedAsUnread(false, chat: chat)
            }
            
            ToolBarView()
        }
        
        
        
    }
    
    var profileButton: some View{
        Button(action:{}){
            HStack {
                Image(chat.person.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: ScreenWidth*0.11, height: ScreenWidth*0.11, alignment: .center)
                Text(chat.person.name)
                    .foregroundColor(Color.black)
                    .font(.system(size: ScreenWidth*0.06))
                    .bold()
            }
        }
    }
    
    var CallButton: some View{
        HStack {
            Button(action:{}){
                Image(systemName: "video")
            }
            Button(action:{}){
                Image(systemName: "phone")
            }
        }
    }
    
    
    
    func ToolBarView () -> some View{
        VStack{
            let height : CGFloat = UIScreen.main.bounds.height*0.05
            HStack{
                Button(action:{}){
                    Image(systemName: "plus")
                        .foregroundColor(Color.gray)
                        .frame(width: height*0.5, height: height*0.5, alignment: .center)
                        .font(.system(size: height*0.6))
                }
                .padding(5)
                
                Button(action:{}){
                    Image(systemName: "photo")
                        .foregroundColor(Color.gray)
                        .frame(width: height*0.5, height: height*0.5, alignment: .center)
                        .font(.system(size: height*0.6))
                }
                .padding(5)
                
                TextField("輸入訊息...", text: $textIuput)
                    .padding(.horizontal, 10)
                    .frame(height: height, alignment: .leading)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .focused($isFocused)
                
                Button(action: sendingMessage ){
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(!textIuput.isEmpty ? Color.blue : Color.gray)
                        .frame(width: height, height: height, alignment: .center)
                        .font(.system(size: height*0.6))
                    
                }
                .disabled(textIuput.isEmpty)
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical)
        .background(Color("LightGray"))
        .ignoresSafeArea(.all)
        //
    }
    
    
    
    func ScrollToMessage(messageID: UUID, anchor: UnitPoint? = nil, shouldAnimate: Bool , scrollReader: ScrollViewProxy){
        DispatchQueue.main.async {
            withAnimation(shouldAnimate ? Animation.easeIn : nil){
                scrollReader.scrollTo(messageID, anchor: anchor)
            }
        }
    }
    
    func sendingMessage(){
        if let message = ViewModel.sendingMessage(input: textIuput, in: chat){
            textIuput = ""
            messageIDtoScroll = message.id
            
        }
    }
    
    let columns = [GridItem(.flexible(minimum: 10))]
    
    func getMessageView (viewWidth: CGFloat) -> some View {
        LazyVGrid(columns: columns, spacing: 0){
            ForEach(chat.message){ message in
                let isRecieved = message.type == .Received
                HStack{
                    ZStack {
                        Text(message.text)
                            .foregroundColor( isRecieved ? Color.white : Color.black)
                            .padding(.horizontal)
                            .padding(.vertical)
                            .background(isRecieved ? Color.blue.opacity(0.75) : Color.white)
                            .cornerRadius(25)
                    }
                    .frame(maxWidth: viewWidth * 0.7 , alignment: isRecieved ? .leading : .trailing)
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: isRecieved ? .leading : .trailing)
                .id(message.id)
            }
        }
    }
}


struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatRoom(chat: Chat.SampleChat[0])
                .environmentObject(ChatViewModel())
        }
        
    }
}
