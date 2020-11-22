//
//  AddButtonView.swift
//  Subscripty
//
//  Created by Михаил Борисов on 11.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import SwiftUI

struct SimpleButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .contentShape(Circle())
            .frame(width: 46, height: 46)
            .background(
                Circle()
                    .fill(Color.appColor(.buttonColor))
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: configuration.isPressed ? -5 : 10, y: configuration.isPressed ? -5 : 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: configuration.isPressed ? 10 : -5, y: configuration.isPressed ? 10 : 5)
        )
    }

}

struct AddButtonView: View {

    var body: some View {
        return ZStack {
            Button(action: {
                print("Tapped")
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.gray)
                    .font(Font.body.weight(.bold))
            }
            .buttonStyle(SimpleButtonStyle())
        }
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView()
    }
}
