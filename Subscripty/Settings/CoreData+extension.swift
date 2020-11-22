//
//  CoreData+extension.swift
//  Subscripty
//
//  Created by Михаил Борисов on 15.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import UIKit
import CoreData

struct CardElement {

    var name: String = ""
    var nextBill: String = ""
    var price: String = ""
    var type: String = ""
    var currency: String = ""
    var url: String = ""
    var mainColor: UIColor = .red

    internal func toCardEntity(context: NSManagedObjectContext) {

        guard isCompleted else { return }
        context.perform {
            let card = CardEntity(context: context)
            card.name = self.name
            card.nextBill = self.nextBill
            card.price = self.price
            card.type = self.type
            card.currency = self.currency
            card.url = self.url
            card.mainColor = self.mainColor
            CoreDataManager.shared.saveContext()
        }
    }

    private var isCompleted: Bool {
        return !(name.isEmpty || nextBill.isEmpty || price.isEmpty || type.isEmpty || currency.isEmpty || url.isEmpty)
    }
}

extension CardEntity {

    internal func toCard() -> CardElement {
        return CardElement(name: name!, nextBill: nextBill!, price: price!, type: type!, currency: currency!, url: url!, mainColor: mainColor!)
    }
}
