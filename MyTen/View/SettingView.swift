//
//  SettingView.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/12.
//

import SwiftUI
import FirebaseStorage
import FirebaseStorageCombineSwift

struct SettingView: View {
    
    let ScreenWidth = UIScreen.main.bounds.width
    @EnvironmentObject var viewmode : ViewMode
    @StateObject var ChatView = ChatViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var userImage = ""
    
    var body: some View {
        
        
            
        VStack {
            VStack {
                Text("username")
                    .font(.system(size: ScreenWidth*0.08))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
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
                        .padding()
                    
                    Button(action: { viewmode.userLogOut() }) {
                        ZStack {
                            Rectangle()
                                .frame(width: ScreenWidth*0.5, height: ScreenWidth*0.1, alignment: .center)
                                .cornerRadius(30)
                                .foregroundColor(Color("MainOrange"))
                            Text("修改相片")
                                .font(.title2)
                                .foregroundColor(Color.white)
                                .bold()
                        }
                        .padding(10)
                    }
                    
                    Button(action: { viewmode.userLogOut() }) {
                        ZStack {
                            Rectangle()
                                .frame(width: ScreenWidth*0.5, height: ScreenWidth*0.1, alignment: .center)
                                .cornerRadius(30)
                                .foregroundColor(Color("MainOrange"))
                            Text("修改名稱")
                                .font(.title2)
                                .foregroundColor(Color.white)
                                .bold()
                        }
                        .padding(10)
                    }
                    
                    Button(action: { viewmode.userLogOut() }) {
                        ZStack {
                            Rectangle()
                                .frame(width: ScreenWidth*0.5, height: ScreenWidth*0.1, alignment: .center)
                                .cornerRadius(30)
                                .foregroundColor(Color.red.opacity(0.9))
                            Text("登出")
                                .font(.title2)
                                .foregroundColor(Color.white)
                                .bold()
                        }
                        .padding(10)
                    }
                    
            }
            .padding()
            
            Spacer()
            
            VStack {
                ZStack {
                    Circle()
                        .frame(width: ScreenWidth*0.18, height: ScreenWidth*0.18, alignment: .center)
                    .foregroundColor(Color("MainPink"))
                    Image(systemName: "arrowshape.turn.up.backward")
                        .font(.system(size: ScreenWidth*0.08))
                        .foregroundColor(Color.white)
                }
              Text("返回")
                    .foregroundColor(Color("MainPink"))
                    .bold()
            }
            .padding()
            
        }
        
        
        
        
        
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

