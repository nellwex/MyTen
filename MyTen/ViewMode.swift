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
    case signup
    case create
    case home
    
    
}



class ViewMode: ObservableObject{
    
    let db = Firestore.firestore()
    let ref = Storage.storage().reference()
    let defaults = UserDefaults.standard
    
    @Published var currentView = CurrentView.signin
   
    func upLoadUserImage(image: UIImage){
        
        let imageData = image.jpegData(compressionQuality: 1)
        guard imageData != nil else { return }
        let path = "Accounts/\(defaults.value(forKey: "userId") as! String)/profile.jpeg"
        let file = ref.child(path)
        let _ = file.putData(imageData!, metadata: nil){ metadata , error in
            if error == nil && metadata != nil {
                self.db.collection("Accounts").document("\(self.defaults.value(forKey: "userId") as! String)").setData(["image":path])
            }
        }
    }
    
    func GetUserImage(id: String){
        
        let _ = ref.child("Accounts/\(id)/profile.jpeg")
        
        
    }
    
    
    
    func SignUp(userEmail: String, userPassword: String){
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            guard result != nil, error == nil else {
                self.signUpIsNotValid()
                return
            }
            self.setUserId(id: userEmail)
            self.signUpIsValid()
            self.currentView = .create
           
        }
        
    }
    
    
    func SignIn(userEmail: String, userPassword: String) {
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            guard result != nil, error == nil else {
                self.userIsNotValid()
                return
            }
            self.userIsValid()
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
                
                self.userIsNotValid()
                print(error.localizedDescription)
            }else{
                userIsValid()
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
        
        defaults.set(username, forKey: "username")
        
    }
    
    func setUserId (id: String){
        
        defaults.set(id, forKey: "userId")
        
    }
    
    
    
    func userLogin(){
        
        defaults.set(true, forKey: "isLogIn")
        
    }
    
    func userLogOut(){
        
        defaults.set(false, forKey: "isLogIn")
        
        
    }
    
    func userIsNotValid(){
        
        defaults.set(true, forKey: "isNotValid")
        
    }
    
    func userIsValid(){
        
        defaults.set(false, forKey: "isNotValid")
        
    }
    
    func signUpIsValid(){
        defaults.set(true, forKey: "signUpIsValid")
    }
    
    func signUpIsNotValid(){
        defaults.set(false, forKey: "signUpIsValid")
    }
  
}

