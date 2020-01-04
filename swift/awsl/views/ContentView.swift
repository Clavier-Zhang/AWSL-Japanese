//
//  ContentView.swift
//  awsl
//
//  Created by clavier on 2019-09-09.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI
import Localize_Swift

struct ContentView: View {
    
    @State var user = User.get()
    
    init() {
        Localize.setCurrentLanguage(Settings.get().isCN() ? "zh-Hans" : "en")
    }
    
    var body: some View {
        VStack {
            if user.isValid() {
                HomeView()
            } else {
                LoginView()
            }
        }
    }
}
