//
//  Color+Extension.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation
import SwiftUI

extension Color {
    static let primaryText = Color(hex: "#333333")
    static let secondaryText = Color(hex: "#666666")
    static let background = Color(hex: "#F8F8F8")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
