//
//  CircularProgressView.swift
//  
//
//  Created by Saeid Basirnia on 2023-08-05.
//

import SwiftUI

public struct CircularProgressView: View {
    private var style: Style
    @Binding var progress: Double

    init(
        progress: Binding<Double>,
        style: Style
    ) {
        self.style = style
        self._progress = progress
    }

    public var body: some View {
        ZStack {
            Circle()
                .stroke(
                    style.backgroundColor.opacity(0.5),
                    lineWidth: style.strokeWidth
                )
                .frame(
                    width: style.height,
                    height: style.height
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    style.backgroundColor,
                    style: StrokeStyle(
                        lineWidth: style.strokeWidth,
                        lineCap: .round
                    )
                )
                .frame(
                    width: style.height,
                    height: style.height
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircularProgressView(
                progress: Binding.constant(0.6),
                style: .default
            )
            .frame(width: 50, height: 50)
        }
    }
}
