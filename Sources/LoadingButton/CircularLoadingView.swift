//
//  CircularLoadingView.swift
//  
//
//  Created by Saeid Basirnia on 2023-08-05.
//

import SwiftUI

public struct CircularLoadingView: View {
    private var style: Style
    @State private var isLoading = false

    init(style: Style) {
        self.style = style
    }

    public var body: some View {
        Circle()
            .trim(from: 0, to: 0.6)
            .stroke(
                style.backgroundColor,
                style: StrokeStyle(
                    lineWidth: style.strokeWidth,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            .frame(
                width: style.height - 20,
                height: style.height - 20
            )
            .rotationEffect(
                Angle(degrees: isLoading ? 360 : 0)
            )
            .animation(
                Animation
                    .linear.speed(0.4)
                    .repeatForever(autoreverses: false),
                value: isLoading
            )
            .opacity(isLoading ? 1 : 0)
            .onAppear {
                isLoading = true
            }
    }
}

struct CircularLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircularLoadingView(
                style: .default
            )
            .frame(width: 50, height: 50)
        }
    }
}
