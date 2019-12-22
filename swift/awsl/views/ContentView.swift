//
//  ContentView.swift
//  awsl
//
//  Created by clavier on 2019-09-09.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var user = User.get()
    
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
