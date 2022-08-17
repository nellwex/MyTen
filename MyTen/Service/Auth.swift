//
//  Auth.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/10.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import SwiftUI


class GoogleAuth: ObservableObject{
    

    
    enum SignInState{
        case SignIn
        case SignOut
    }
    
    func SignIn() {
          // 1 Create a Google Sign-In configuration object with the clientID
          if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                
            }
          } else {
            // 2 It fetches the clientID from the GoogleService-Info.plist added to the project earlier.
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // 3 Create a Google Sign-In configuration object with the clientID
            let configuration = GIDConfiguration(clientID: clientID)
            
            // 4 access presentingViewController through the shared instance of the UIApplication
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            // 5
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
              authenticateUser(for: user, with: error)
               
            }
          }
    }
    
    func SignOut(){
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
            state = .SignOut
            
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
        
        Auth.auth().signIn(with: credential){ [unowned self] (_, error) in if let error = error{
            print(error.localizedDescription)
        }else{
            self.state = .SignIn
           
        }
            
        }
    }
    
    @Published var state: SignInState = .SignOut
}


class EmailAuth : ObservableObject{
    
    
    enum SignInState{
        case SignIn
        case SignOut
    }
    
    @Published var userEmail = ""
    @Published var userPassword = ""
    
    
    func SignUp(){
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            
            guard error == nil else{
                return
            }
            
            
        }
        
    }
    
 func checkUser() async{
        
    
        
    }
    @Published var state: SignInState = .SignOut
    
}
