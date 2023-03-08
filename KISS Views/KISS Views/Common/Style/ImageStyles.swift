//
//  ImageStyles.swift
//  KISS Views
//

import SwiftUI

extension Image {
    func leadIcon() -> some View {
        aspectRatio(1, contentMode: .fit)
            .frame(width: 150, height: 150)
    }
}
