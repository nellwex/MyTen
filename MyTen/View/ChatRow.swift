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
  
     
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 5) {
                ZStack {
                    Rectangle()
                        .frame(width: ScreenWidth*0.65, height: ScreenWidth*0.35, alignment: .leading)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .shadow(color: .gray, radius: 5, x: 3, y: 5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(chat.person.name)
                                .font(.system(size: ScreenWidth*0.053))
                                .bold()
                               
                                
                            Text(chat.message.last?.date.descriptiveString() ?? "" )
                                .frame(width: ScreenWidth*0.4, height: 40, alignment: .trailing)
                                .foregroundColor(Color.gray)
                              
                            
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
                
                Image(chat.person.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: ScreenWidth*0.4, height: ScreenWidth*0.4, alignment: .center)
                    .foregroundColor(Color.green)
                    .padding(20)
              
                
            }
            
           
        }
    }
        
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(chat: Chat.SampleChat[0])
    }
}
