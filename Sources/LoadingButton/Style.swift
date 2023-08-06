//
//  Style.swift
//  
//
//  Created by Saeid Basirnia on 2023-08-05.
//

import SwiftUI

struct Style {
    var width: CGFloat
    var height: CGFloat
    var backgroundColor: Color
    var strokeWidth: CGFloat
    var cornerRadius: CGFloat?

    static var `default`: Style {
        Style(
            width: 300,
            height: 55,
            backgroundColor: .blue,
            strokeWidth: 5,
            cornerRadius: nil
        )
    }
}
