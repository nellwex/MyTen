//
//  ViewMode.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseStorageCombineSwift
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import SwiftUI


enum CurrentView:Int {
    
    case signin
    case create
    case home
    case setting
    
}



class ViewMode: ObservableObject{
    
    let db = Firestore.firestore()
    let ref = Storage.storage().reference()
    
    @Published var currentView = CurrentView.signin
   
    func GetUserImage(id: String){
        
        let image = ref.child("Accounts/\(id)/profile.jpg")
        
    }
    
    func GoSetting(){
        currentView = .setting
    }
    
    func LeaveSetting(){
        currentView = .home
    }
    
    func SignUp(userEmail: String, userPassword: String){
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            guard result != nil, error == nil else {
                self.userIsNotValid()
                return
            }
            self.setUserId(id: userEmail)
            
            self.currentView = .create
        }
        
    }
    
    
    func SignIn(userEmail: String, userPassword: String) {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            guard result != nil, error == nil else {
                self.userIsNotValid()
                return
            }
            
            self.setUserId(id: userEmail)
            self.currentView = .home
            self.userLogin()
            
        }
        
        
      
    }
    
    func SignOut(){
        do {
            try Auth.auth().signOut()
            currentView = .signin
            userLogOut()
            
        } catch {
            print(error.localizedDescription)
        }
        
        currentView = .signin
    }
    
    
    func GoogleSignIn() {
        //  Create a Google Sign-In configuration object with the clientID
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                
                self.currentView = .home
                
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
        guard let emailAddress = user?.profile?.email else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential){
            [unowned self] (_, error) in if let error = error{
                print(error.localizedDescription)
            }else{
                currentView = .home
                userLogin()
                setUserId(id: emailAddress)
            }
            
        }
    }
    
    
    func AppleSignIn(){
       
//        let provider = ASAuthorizationAppleIDProvider()
//        let request = provider.createRequest()
//        let controller = ASAuthorizationController(authorizationRequests: [request])
        
    }
    
    
    
    func setUsername (username: String){
        
        UserDefaults.standard.set(username, forKey: "username")
        
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
    
    func userIsNotValid(){
        
        UserDefaults.standard.set(true, forKey: "isNotValid")
        
    }
    
   
    
}

