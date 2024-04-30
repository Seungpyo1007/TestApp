//
//  Item.swift
//  TestApp
//
//  Created by 홍승표 on 4/30/24.
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
