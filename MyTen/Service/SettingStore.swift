//
//  SettingStore.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/12.
//

import Foundation
import Combine
import SwiftUI

class SettingStore : ObservableObject{
    
    @EnvironmentObject var viewmode : ViewMode
    
    
  
    
    func setUserId (input: String){
        
        UserDefaults.setValue(input, forKey: "UserID")
        
    }
    
    func userLogin(){

        UserDefaults.standard.set(true, forKey: "isLogIn")
        viewmode.LogIn()
    }
    
    func userLogOut(){
        
        UserDefaults.standard.set(false, forKey: "isLogIn")
        viewmode.LogOut()
        
    }
    
}
