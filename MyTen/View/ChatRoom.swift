//
//  ChatRoom.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI

struct ChatRoom: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var textIuput = ""
    @FocusState private var isFocused
    @State private var messageIDtoScroll : UUID?
    let ScreenWidth = UIScreen.main.bounds.width
    
    let chat : Chat
    
    @EnvironmentObject var ViewModel : ChatViewModel
    
    var body: some View {
        VStack(spacing:0) {
            GeometryReader{ georeader in
                ScrollView(){
                    ScrollViewReader { scrollReader in
                        getMessageView(viewWidth: georeader.size.width)
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
            .background(colorScheme == .dark ? Color.black : Color("LightGray"))
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
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
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
                    .frame(width: ScreenWidth*0.1, height: ScreenWidth*0.1, alignment: .center)
                Text(chat.person.name)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .font(.system(size: ScreenWidth*0.06))
                    .bold()
            }
        }
    }
    
    var CallButton: some View{
        HStack {
            Button(action:{}){
                Image(systemName: "video")
                    .foregroundColor(Color("MainPink"))
            }
            Button(action:{}){
                Image(systemName: "phone")
                    .foregroundColor(Color("MainPink"))
            }
        }
    }
    
    
    
    func ToolBarView () -> some View{
        VStack{
            let height : CGFloat = UIScreen.main.bounds.height*0.05
            HStack{
                Button(action:{}){
                    Image(systemName: "plus")
                        .foregroundColor(Color.white)
                        .frame(width: height*0.5, height: height*0.5, alignment: .center)
                        .font(.system(size: height*0.6))
                }
                .padding(5)
                
                Button(action:{}){
                    Image(systemName: "photo")
                        .foregroundColor(Color.white)
                        .frame(width: height*0.5, height: height*0.5, alignment: .center)
                        .font(.system(size: height*0.6))
                }
                .padding(5)
                
                TextField("輸入訊息...", text: $textIuput)
                    .padding(.horizontal, 10)
                    .frame(height: height, alignment: .leading)
                    .background(colorScheme == .dark ? Color("DarkGray") : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .focused($isFocused)
                
                Button(action: sendingMessage ){
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(!textIuput.isEmpty ? Color.blue : Color.white)
                        .frame(width: height, height: height, alignment: .center)
                        .font(.system(size: height*0.6))
                    
                }
                .disabled(textIuput.isEmpty)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color("MainPink"), Color("MainOrange")]), startPoint: .top, endPoint: .bottom))
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
                            .background(isRecieved ? Color("MainOrange") : Color.white)
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
