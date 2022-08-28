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
                    AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape

                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")

                    UINavigationController.attemptRotationToDeviceOrientation()
                    
                    if (isLogIn){
                        viewmode.currentView = .home
                    }
                }
                .onDisappear(perform: {

                      DispatchQueue.main.async {

                        AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait

                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")

                        UINavigationController.attemptRotationToDeviceOrientation()

                      }

                    })

        }
        
        
    }
}

class AppDelegate: NSObject {

  static var orientationLock = UIInterfaceOrientationMask.portrait

}

extension AppDelegate: UIApplicationDelegate {

  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {

    return AppDelegate.orientationLock

  }

}

