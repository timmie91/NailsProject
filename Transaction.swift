//
//  Transaction.swift
//  Nails Keeper
//
//  Created by TIM NGUYEN on 3/29/16.
//  Copyright © 2016 TIM NGUYEN. All rights reserved.
//

import Foundation
import CoreData


class Transaction: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    @NSManaged var amount: NSDecimalNumber?
    @NSManaged var entryTime: NSDate?
    @NSManaged var isAllDay: NSNumber?
    @NSManaged var percentage: NSNumber?
    @NSManaged var stubNumber: NSNumber?
    @NSManaged var tipCard: NSDecimalNumber?
    @NSManaged var tipCash: NSDecimalNumber?
    @NSManaged var transID: NSNumber?
    @NSManaged var workDate: NSDate?

}
