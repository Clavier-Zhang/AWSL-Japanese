//
//  styles.swift
//  awsl
//
//  Created by clavier on 2019-09-12.
//  Copyright © 2019 clavier. All rights reserved.
//

import SwiftUI

var WIDTH = UIScreen.main.bounds.width

var HEIGHT = UIScreen.main.bounds.height

struct AwslStyle {
    
    static var HOMEVIEW_ROW_GAP : CGFloat = UIDevice.isPad ? 50 : 30
    
    static var CountLabelSize : CGFloat = UIDevice.isPad ? 30 : 13
    
    static var COUNT_LABEL_GAP : CGFloat = UIDevice.isPad ? 100 : 25
    
    static var LARGE_FONT : Font = UIDevice.isPad ? .largeTitle : .title
    
    static var MIDDLE_FONT : Font = UIDevice.isPad ? Font.system(size: 20) : .body
    
    static var LARGE_BUTTON_SIZE : CGFloat = UIDevice.isPad ? 300 : 200
    
    static var STUDYVIEW_WIDTH : CGFloat = UIDevice.isPad ? 700 : WIDTH-50
    
    static var SELF_EVALUATION_GAP : CGFloat = UIDevice.isPad ? 100 : 40
    
    static var LEARN_GAP : CGFloat = UIDevice.isPad ? HEIGHT-900 : 10
    
    static var MEANING_HEIGHT : CGFloat = UIDevice.isPad ? 150 : 100
    
    static var EXAMPLE_HEIGHT : CGFloat = UIDevice.isPad ? 230 : 150
    
    static var NAVIGATION_GAP : CGFloat = UIDevice.isPad ? 60 : 45
    
    static var SETTINGS_WIDTH : CGFloat = UIDevice.isPad ? 400 : WIDTH-50
    
    static var PLAN_WIDTH : CGFloat = UIDevice.isPad ? 400 : WIDTH-50
    
    static var PLAN_PICKER_WIDTH : CGFloat = UIDevice.isPad ? 300 : 50
    
    static var PLAN_GAP : CGFloat = UIDevice.isPad ? 150 : 80
    
    static var SETTINGS_GAP : CGFloat = UIDevice.isPad ? 150 : 20
    
    static var SUBMISSION_WIDTH : CGFloat = UIDevice.isPad ? 550 : WIDTH-50
    
    static var SETTINGS_SWITCH_WIDTH : CGFloat = UIDevice.isPad ? 200 : 150
}


struct StartButtonStyle: ButtonStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 60)
            .background(configuration.isPressed ? red.opacity(0.5) : red)
            .cornerRadius(20)
            .font(.system(size: 30))
    }

}



struct NavigationViewHiddenStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle(Text("Title"))
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NavigationViewBackStyle: ViewModifier {
    
    var pressBack : () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton)
    }
    
    var BackButton : some View {
        HStack {
            Button(action: pressBack) {
//                Spacer().frame(width: 20)
                Image(systemName: "house")
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
//                Spacer().frame(width: 20)
            }
        }
        .frame(alignment: .leading)
    }
    

}


struct BaseViewStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200, alignment: .bottom)
            .background(base)
            .foregroundColor(fontBase)
            .offset(y:-200)
    }
}
