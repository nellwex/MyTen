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
    
    
    func setNickname (nickname: String){
        
        UserDefaults.standard.set(nickname, forKey: "userNickname")
        
    }
    
    func setUserId (id: String){
        
        UserDefaults.standard.set(id, forKey: "userId")
        
    }
    
    func userLogin(){

        UserDefaults.standard.set(true, forKey: "isLogIn")
       
    }
    
    func userLogOut(){
        
        UserDefaults.standard.set(false, forKey: "isLogIn")
        
        
    }
    
}
