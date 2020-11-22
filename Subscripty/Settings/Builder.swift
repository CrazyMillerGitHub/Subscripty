//
//  Builder.swift
//  Subscripty
//
//  Created by Михаил Борисов on 15.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import Foundation

protocol Builder {}

extension Builder {
    func with(config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
}

extension NSObject: Builder {}
