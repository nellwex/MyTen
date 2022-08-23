//
//  MyTenApp.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

enum CurrentView:Int {
    
    case signin
    case create
    case home
    
}

class ViewMode : ObservableObject{
    
    
    @Published var currentView = CurrentView.signin
    
    
    func LogIn(){
        currentView = CurrentView.home
    }
    
    func LogOut(){
        currentView = CurrentView.signin
    }
    
    
    func SignUp(){
        currentView = CurrentView.create
    }
    
}



@main
struct MyTenApp: App {
    
    private var viewmode = ViewMode()
    @StateObject var googleAuth = GoogleAuth()
    @StateObject var emailAuth = EmailAuth()
    
    let isLogIn = UserDefaults.standard.bool(forKey: "isLogIn")
    
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        
        
        
        WindowGroup {
            ForkView().environmentObject(viewmode)
                .onAppear(){
                    if (isLogIn){
                        viewmode.LogIn()
                    }
                }
        }
        
    }
}

