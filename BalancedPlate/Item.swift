//
//  Item.swift
//  BalancedPlate
//
//  Created by Bathilde Rocchia on 09/05/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
