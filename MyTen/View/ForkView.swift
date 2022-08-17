//
//  ForkView.swift
//  MyTen
//
//  Created by 魏頤綸 on 2022/8/13.
//

import SwiftUI
import Combine

struct ForkView: View {
    
    @EnvironmentObject var viewmode: ViewMode
   
    
    var body: some View {
        switch(viewmode.currentView){
        case.signin:
            Signin().environmentObject(viewmode)
            
        case.create:
            CreateView().environmentObject(viewmode)
            
        case.home:
            ContentView().environmentObject(viewmode)
        }
    }
}

