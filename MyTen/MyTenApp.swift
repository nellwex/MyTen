//
//  MyTenApp.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import SwiftUI
import Firebase




@main
struct MyTenApp: App {
    
    @StateObject var viewmode = ViewMode()
    
    
    let isLogIn = UserDefaults.standard.bool(forKey: "isLogIn")
    
    init(){
        FirebaseApp.configure()
        
    }
    
    
    var body: some Scene {
        
        
        
        WindowGroup {
            
            ForkView().environmentObject(viewmode)
                .onAppear(){
                    if (isLogIn){
                        viewmode.currentView = .home
                    }
                }
        }
        
        
    }
}

