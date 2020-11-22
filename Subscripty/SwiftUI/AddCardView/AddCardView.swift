//
//  AddCard.swift
//  Subscribify
//
//  Created by Михаил Борисов on 11.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import SwiftUI
import Combine

extension Color {

    static var randomColor: Color {
        return Color(red: Double.random(in: 0..<1), green: Double.random(in: 0..<1), blue: Double.random(in: 0..<1))
    }
}

struct CardTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding()
            .background(Color.appColor(.textFieldColor))
            .cornerRadius(15)
            .frame(height: 46)

    }
}

final class CardEnvironment: ObservableObject {

    @Published var card: CardElement

    init(card: CardElement) {
        self.card = card
    }
}

struct CardInfoView: View {

    @EnvironmentObject var environment: CardEnvironment
    private var textFieldStyle = CardTextFieldStyle()

    var body: some View {
        VStack(spacing: 20) {
            TextField("Name", text: $environment.card.name)
                .textFieldStyle(textFieldStyle)
            HStack(spacing: 20) {
                TextField("Price", text: $environment.card.price)
                    .textFieldStyle(textFieldStyle)
                    .keyboardType(.decimalPad)
                TextField("Currency", text: $environment.card.currency)
                    .textFieldStyle(textFieldStyle)
            }
            HStack(spacing: 20) {
                TextField("Next Bill", text: $environment.card.nextBill)
                    .textFieldStyle(textFieldStyle)
                TextField("Type", text: $environment.card.type)
                    .textFieldStyle(textFieldStyle)
            }
            TextField("URL", text: $environment.card.url)
                .textFieldStyle(textFieldStyle)
                .keyboardType(.URL)
        }
    }
}

struct AddCardView: View {

    internal var offset: CGSize = CGSize(width: 22.5, height: 0)
    internal var maxOffset: CGSize = CGSize(width: -UIScreen.main.bounds.width, height: 0)
    internal var dismissAction: ((CardElement) -> Void)

    @State private var ispressed: Bool = false
    @State private var state: Bool = false
    @EnvironmentObject var environment: CardEnvironment
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 20) {
            Text("Add subscription")
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .padding(.top, 30)
            if state {
                VStack {
                    ForEach(0..<2) { _ in
                        HStack(spacing: 20) {
                            ForEach(0..<4) { _ in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.randomColor)
                                    .frame(width: 46, height: 46)
                                    .onTapGesture {
                                        withAnimation {
                                            self.environment.card.mainColor = UIColor.blue
                                            self.state.toggle()
                                        }
                                }
                            }
                        }
                    }
                }
            } else {
                HStack(spacing: 10) {
                    CardView(mode: .small)
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.appColor(.startGradient), Color.appColor(.endGradient)]), startPoint: .bottomLeading, endPoint: .topTrailing))
                        .frame(width: 25)
                        .onTapGesture {
                            withAnimation {
                                self.state.toggle()
                            }
                    }
                }
                .offset(self.offset)
            }
            CardInfoView()
            Button(action: {
                self.dismissAction(self.environment.card)
            }) {
                Text("Done")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.white)
                    .frame(width: 163)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 17)
                        .fill(Color(environment.card.mainColor))
                        .animation(.spring()))
            }
        }
        .padding(47)
        .frame(maxWidth: .infinity)
        .background(Color.appColor(.bgColor))
        .edgesIgnoringSafeArea(.all)
    }

}
