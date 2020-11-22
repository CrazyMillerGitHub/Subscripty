//
//  CardView.swift
//  Subscribify
//
//  Created by Михаил Борисов on 08.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import SwiftUI

struct CardView: View {

    @EnvironmentObject var environment: CardEnvironment

    internal enum CardMode {

        case big, small
        var isBig: Bool {
            return self == .big
        }
    }

    internal var mode: CardMode = .big

    var body: some View {
        return VStack(alignment: .center) {
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(String(describing: environment.card.name))
                            .foregroundColor(.white)
                            .font(.system(size: mode.isBig ? 24 : 9, weight: .semibold, design: .rounded))
                        Spacer()
                        Text([unwrapValue(environment.card.price), unwrapValue(environment.card.currency)].joined(separator: ""))
                            .foregroundColor(.white)
                            .font(.system(size: mode.isBig ? 24 : 9, weight: .medium, design: .rounded))
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Type")
                            .foregroundColor(.white)
                            .font(.system(size: mode.isBig ? 15 : 7, weight: .medium, design: .rounded))
                        Text(unwrapValue(environment.card.type))
                            .foregroundColor(.white)
                            .italic()
                            .font(.system(size: mode.isBig ? 15 : 7, weight: .light, design: .rounded))
                        Spacer()
                        Text("Expiret\n\(unwrapValue(environment.card.nextBill))")
                            .foregroundColor(.white)
                            .font(.system(size: mode.isBig ? 15 : 7, weight: .light, design: .rounded))
                            .multilineTextAlignment(.trailing)
                    }
                }.padding(mode.isBig ? 30 : 14)
            }
        }
        .frame(height: mode.isBig ? 180 : 80)
        .frame(maxWidth: mode.isBig ? .infinity : 120)
        .background(Color(environment.card.mainColor).animation(.spring()))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.zero)
        .shadow(color: Color(environment.card.mainColor).opacity(0.3), radius: 6, x: 0, y: 3)
    }

    func unwrapValue(_ val: String?) -> String {
        return String(describing: val ?? "")
    }
}
