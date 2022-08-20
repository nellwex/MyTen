//
//  MyTenApp.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI
import FirebaseCore

enum CurrentView:Int {
    
    case signin
    case create
    case home
    
}

class ViewMode : ObservableObject{
    
  
    @Published var currentView = CurrentView.signin
    
    func swithToHome(){
        currentView = CurrentView.home
    }

   
}



@main
struct MyTenApp: App {
    
   private var viewmode = ViewMode()

    
    
    
    init(){
     setupAuthentication()
    }
    
    
    var body: some Scene {
        
    
        
        WindowGroup {
            ForkView().environmentObject(viewmode)
        }
    }
}

extension MyTenApp {
    
    func setupAuthentication(){
        FirebaseApp.configure()
    }
    
}
