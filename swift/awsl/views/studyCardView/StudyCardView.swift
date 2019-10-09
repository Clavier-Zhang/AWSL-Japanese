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
    
    @State var currentPhase : String = "SELF_EVALUATION"
    
    var BackButton : some View {
        HStack {
            Spacer().frame(width: 20)
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "house")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    
                    Spacer().frame(height: 20)
                    
                    VStack (spacing: 20) {
                        ProgressBar(55, 197, 13)
                        if (self.currentPhase == "SELF_EVALUATION") {
                            SelfEvaluationPhase(currentPhase: $currentPhase)
                        } else if (self.currentPhase == "TEST") {
                            TestPhase(currentPhase: $currentPhase)
                        } else if (self.currentPhase == "LEARN") {
                            LearnPhase(currentPhase: $currentPhase)
                        }
                    }
                        .frame(width: 700, height: 1.05*fullHeight)

                }
                    .frame(width: fullWidth, height: 1.05*fullHeight)
                    .background(studyCardBase)
            }
                .frame(width: fullWidth, height: fullHeight+300)
                .background(base)
                .foregroundColor(fontBase)
        }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton)

    }
}

