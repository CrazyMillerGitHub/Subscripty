//
//  Color+extension.swift
//  Subscripty
//
//  Created by Михаил Борисов on 15.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import SwiftUI

extension Color {

    enum AssetsColor: String {

        case buttonColor
        case textFieldColor
        case endGradient
        case startGradient
        case bgColor

        var value: String {
            return self.rawValue
        }
    }

    static func appColor(_ asset: AssetsColor) -> Color {
        guard let color = UIColor(named: asset.value) else { return Color.white }
        return Color(color)
    }
}
