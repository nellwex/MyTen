//
//  ViewMode.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftUI

enum CurrentView:Int {
    
    case signin
    case create
    case home
    case setting
    
}

class ViewMode: ObservableObject{
    
    
    
    @Published var currentView = CurrentView.signin
    
    
    let isLogIn = UserDefaults.standard.bool(forKey: "isLogIn")
    
    func GoSetting(){
        currentView = .setting
    }
    
    func LeaveSetting(){
        currentView = .home
    }
    
    func SignUp(userEmail: String, userPassword: String){
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                return
            }
           
        }
        currentView = .create
    }
    
    
    func SignIn(userEmail: String, userPassword: String){
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                return
            }
            
        }
        
        currentView = .home
        userLogin()
    }
    
    func SignOut(){
        currentView = .signin
    }
    
    
    func GoogleSignIn() {
        //  Create a Google Sign-In configuration object with the clientID
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                
            }
        } else {
            //  It fetches the clientID from the GoogleService-Info.plist added to the project earlier.
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            //  Create a Google Sign-In configuration object with the clientID
            let configuration = GIDConfiguration(clientID: clientID)
            
            //  access presentingViewController through the shared instance of the UIApplication
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                
            }
        }
    }
    
    
    func GoogleSignOut(){
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            currentView = .signin
            userLogOut()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?){
        if let error = error{
            print(error.localizedDescription)
            return
        }
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential){
            [unowned self] (_, error) in if let error = error{
                print(error.localizedDescription)
            }else{
                currentView = .home
                userLogin()
                setUserId(id: idToken)
            }
            
        }
    }
    
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

