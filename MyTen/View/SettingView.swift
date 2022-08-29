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
    
    @State var isImagePicking = false
    @State var image : Image
    @State var selectedImage : UIImage?
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    var body: some View {
        
        
            
        VStack {
            VStack {
                Text("username")
                    .font(.system(size: ScreenWidth*0.08))
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
                    image
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
                        .onTapGesture {
                            isImagePicking = true
                        }
                    
                    Button(action: { isImagePicking = true }) {
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
                    
                    Button(action: {
                        viewmode.userLogOut()
                        viewmode.GoogleSignOut()
                    }) {
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
            
        
            
        }
        .onChange(of: selectedImage) { _ in loadImage() }
        .sheet(isPresented: $isImagePicking) {
            ImagePicker(image: $selectedImage)
        }
        
        
        
        
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(image: Image("PlusEmpty"))
    }
}

