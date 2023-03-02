//
//  ImageStyles.swift
//  KISS Views
//

import SwiftUI

extension Image {
    func leadIcon() -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
    }
}
