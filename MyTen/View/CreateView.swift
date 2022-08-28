//
//  CreateView.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/12.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

struct CreateView: View {
    
   
    @EnvironmentObject var viewmode : ViewMode
    
    let ScreenWidth = UIScreen.main.bounds.width
  
    let db = Firestore.firestore()
    let ref = Storage.storage().reference()
    
    
    @State var username = ""
    @State var customId = ""
    @State var nameIsEmpty = false
    @State var isImagePicking = false
    @State var image : Image
    @State var selectedImage : UIImage?
    
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        image = Image(uiImage: selectedImage)
    }
    
    func limitText(text: String ,limit: Int) {
            if text.count > limit {
                nameIsEmpty = true
            }
        }
    
    func settingProfile () {
        
        if (username.isEmpty){
            nameIsEmpty = true
            return
        }
        limitText(text: username, limit: 12)
        viewmode.setUsername(username: username)
        
        
    }
    
    var body: some View {
        
        VStack {
            
            
            Text("帳號設定")
                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(Color("MainPink"))
                .bold()
                .frame(width: ScreenWidth, height: ScreenWidth*0.1, alignment: .center)
                .padding()
            
            Text("您仍可在之後更改這些設定")
                .font(.system(.subheadline))
                .foregroundColor(Color.gray)
                .padding(.bottom, ScreenWidth*0.15)
            
            VStack {
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: ScreenWidth*0.6, height: ScreenWidth*0.6, alignment: .center)
                    .padding()
                    .onTapGesture {
                        isImagePicking = true
                    }
                Text("帳號相片")
                    .font(.system(.title2))
                    .bold()
                    .foregroundColor(Color("MainPink"))
                    .frame(width: ScreenWidth*0.4, alignment: .center)
            }
            
            HStack {
                VStack {
                    Text("名稱：")
                        .bold()
                        .font(.system(.title2, design: .rounded))
                        .frame(width: ScreenWidth*0.2, alignment: .center)
                        .foregroundColor(Color("MainPink"))
                    
                    
                    Text("(必填)")
                        .font(.system(.subheadline))
                        .foregroundColor(Color.gray)
                        .frame(width: ScreenWidth*0.2, alignment: .center)
                }
                .padding(.leading)
                
                FormField(fieldName: "使用者名稱(最多6個字)", fieldValue: $username)
                    .padding(.trailing)
                
                
            }
            .padding()
            
            HStack {
                VStack {
                    Text("ID：")
                        .bold()
                        .font(.system(.title2, design: .rounded))
                        .frame(width: ScreenWidth*0.2, alignment: .center)
                        .foregroundColor(Color("MainPink"))
                    
                    
                    Text("(選填)")
                        .font(.system(.subheadline))
                        .foregroundColor(Color.gray)
                        .frame(width: ScreenWidth*0.2, alignment: .center)
                }
                .padding(.leading)
                
                FormField(fieldName: "自訂ID", fieldValue: $customId)
                    .padding(.trailing)
                
                
            }
            .padding()
            
            Button(action:{}) {
                Text("確定")
                    .font(.system(size: ScreenWidth*0.05))
                    .foregroundColor(Color.white)
                    .bold()
            }
            .frame(width: ScreenWidth*0.8, height: ScreenWidth*0.15, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color("MainPink"), Color("MainOrange")]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(30)
            .padding(ScreenWidth*0.1)
            .alert("名稱錯誤或空白", isPresented: $nameIsEmpty) {
                Button("重新輸入") {
                    self.nameIsEmpty = false
                }
            }
            
            
            
        }
        .onChange(of: selectedImage) { _ in loadImage() }
        .sheet(isPresented: $isImagePicking) {
            ImagePicker(image: $selectedImage)
        }
        
        
    }
    
    
    struct CreateView_Previews: PreviewProvider {
        static var previews: some View {
            CreateView(image: Image("PlusEmpty"))
        }
    }
    
    struct FormField: View {
        
        var fieldName = ""
        @Binding var fieldValue: String
        
        
        var body: some View {
            
            VStack {
                
                TextField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
                
                
                Divider()
                    .frame(height: 2)
                    .background(Color("MainOrange"))
                    .padding(.horizontal)
                
                
            }
        }
    }
}
