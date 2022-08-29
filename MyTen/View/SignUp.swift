//
//  SignUp.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/29.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseStorageCombineSwift
import FirebaseFirestore
import FirebaseFirestoreSwift


struct SignUp: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var viewmode : ViewMode
    
    let ScreenWidth = UIScreen.main.bounds.width
    
    let db = Firestore.firestore()
    let ref = Storage.storage().reference()
    let defaults = UserDefaults.standard
    let signUpIsValid = UserDefaults.standard.bool(forKey: "signUpIsValid")
    
    @State var userEmail = ""
    @State var userPassword = ""
    @State var emailIsEmpty = false
    @State var passWordIsNotValid = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName:"arrow.left")
                    .font(.system(size: ScreenWidth*0.07))
                    .foregroundColor(Color.blue)
                    .padding(ScreenWidth*0.08)
                    .onTapGesture {
                        viewmode.currentView = .signin
                    }
                Spacer()
            }
            
            Text("帳號註冊")
                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(Color("MainPink"))
                .bold()
                .frame(width: ScreenWidth, height: ScreenWidth*0.1, alignment: .center)
                .padding()
            
            Text("請輸入使用中的Email，密碼需6位英數字以上")
                .font(.system(.subheadline))
                .foregroundColor(Color.gray)
                .padding(.bottom, ScreenWidth*0.15)
            
            HStack {
                
                Text("帳號：")
                    .bold()
                    .font(.system(.title2, design: .rounded))
                    .frame(width: ScreenWidth*0.2, alignment: .center)
                    .foregroundColor(Color("MainPink"))
                
                
                FormField(fieldName: "輸入電子郵件註冊", fieldValue: $userEmail)
                    .padding(.trailing)
                
                
            }
            .padding()
            
            HStack {
                
                Text("密碼：")
                    .bold()
                    .font(.system(.title2, design: .rounded))
                    .frame(width: ScreenWidth*0.2, alignment: .center)
                    .foregroundColor(Color("MainPink"))
                
                
                
                FormField(fieldName: "請設定帳號密碼", fieldValue: $userPassword)
                    .padding(.trailing)
                
                
            }
            .padding()
            
            Button(action:{
            
                viewmode.SignUp(userEmail: self.userEmail, userPassword: self.userPassword)
           
            }) {
                Text("確定")
                    .font(.system(size: ScreenWidth*0.05))
                    .foregroundColor(Color.white)
                    .bold()
            }
            .frame(width: ScreenWidth*0.8, height: ScreenWidth*0.15, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color("MainPink"), Color("MainOrange")]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(30)
            .padding(ScreenWidth*0.1)
            .alert("帳號空白", isPresented: $emailIsEmpty) {
                Button("重新輸入") {
                    self.emailIsEmpty = false
                }
            }
            
            Spacer()
        }
        .background(colorScheme == .dark ? Color(.black).edgesIgnoringSafeArea(.all) : Color(.white).edgesIgnoringSafeArea(.all))
       
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

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

