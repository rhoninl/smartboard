//
//  Item.swift
//  SmartBoard
//
//  Created by 李毓琪 on 2024/2/10.
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
