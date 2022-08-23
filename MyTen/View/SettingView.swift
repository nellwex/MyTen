//
//  SettingView.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/12.
//

import SwiftUI

struct SettingView: View {
    
    let ScreenWidth = UIScreen.main.bounds.width
    @EnvironmentObject var viewmodel : ChatViewModel
    @EnvironmentObject var settingStore: SettingStore
    @StateObject var ChatView = ChatViewModel()
    
    
    var body: some View {
        
        
            VStack {
                Image("PlusEmpty")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: ScreenWidth*0.6, height: ScreenWidth*0.6, alignment: .center)
                    .contextMenu{
                        Button{}label: {
                            HStack {
                                Text("變更相片")
                                Image(systemName: "camera")
                            }
                        }
                    }
                Button(action: { settingStore.userLogOut() }) {
                    ZStack {
                        Rectangle()
                            .frame(width: ScreenWidth*0.3, height: ScreenWidth*0.1, alignment: .center)
                            .cornerRadius(30)
                        .foregroundColor(Color.red.opacity(0.88))
                        Text("登出")
                            .font(.title2)
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    .padding()
                }
            }
            .onDisappear(){
                
            }
        
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

