//
//  CardEntity+CoreDataProperties.swift
//  Subscripty
//
//  Created by Михаил Борисов on 16.08.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit.UIColor

extension CardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardEntity> {
        return NSFetchRequest<CardEntity>(entityName: "CardEntity")
    }

    @NSManaged public var currency: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var nextBill: String?
    @NSManaged public var price: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var mainColor: UIColor?

}
