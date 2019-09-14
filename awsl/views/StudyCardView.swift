//
//  SwiftUIView.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

struct StudyCardView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var btnBack : some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss() }
            ) {
                HStack {
                    Image(systemName: "house") // set image here
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                    Text("Go back")
                }
            }
            Text("Go back")
        }
        
        
    }

    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: HomeView()) {
                    HStack {
                    Image(systemName: "house") // set image here
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        Text("Go back")
                    }
                }
                
                VStack {
                    Text("body")
                    
                }
                    .background(Color.blue)

            }
                .background(base)
        }
            .navigationViewStyle(StackNavigationViewStyle())

            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: btnBack)

    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StudyCardView()
    }
}
