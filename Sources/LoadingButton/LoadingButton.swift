//
//  LoadingButton.swift
//  
//
//  Created by Saeid Basirnia on 2023-08-04.
//

import SwiftUI

public struct LoadingButton<Content: View>: View {

    public enum ProgressType {
        case loading(Binding<Bool>)
        case progress(Binding<Bool>, Binding<Double>)
    }

    @Binding public var isLoading: Bool
    @State private var animationFinished = false

    private var style: Style
    private var content: Content
    private var tapAction: () -> Void
    private var progressType: ProgressType

    public init(
        style: Style = .default,
        progressType: ProgressType,
        @ViewBuilder content: () -> Content,
        tapAction: @escaping () -> Void
    ) {
        if case let ProgressType.loading(isLoading) = progressType {
            self._isLoading = isLoading
        } else if case let ProgressType.progress(isLoading, _) = progressType {
            self._isLoading = isLoading
        } else {
            fatalError("progressType is not valid!")
        }
        self.progressType = progressType
        self.content = content()
        self.tapAction = tapAction
        self.style = style
    }

    @ViewBuilder
    private func getViewForCurrentButtonType() -> some View {
        switch progressType {
        case .loading:
            CircularLoadingView(style: style)
        case .progress(_, let progress):
            CircularProgressView(
                progress: progress,
                style: style
            )
        }
    }

    public var body: some View {
        Button(action: {
            tapAction()
        }) {
            ZStack {
                Rectangle()
                    .fill(
                        isLoading
                        ? style.backgroundColor.opacity(0.1)
                        : style.backgroundColor
                    )
                    .frame(
                        width: isLoading ? style.height : style.width,
                        height: style.height
                    )
                    .cornerRadius(
                        style.cornerRadius == nil
                        ? style.width / 2
                        : style.cornerRadius!
                    )
                if isLoading {
                    getViewForCurrentButtonType()
                } else {
                    Image(systemName: "checkmark")
                        .font(.headline)
                        .foregroundColor(.white)
                        .opacity(animationFinished ? 1 : 0)
                    content
                        .offset(
                            x: 0,
                            y: animationFinished ? -40 : 0
                        )
                        .opacity(animationFinished ? 0 : 1)
                }
            }
            .animation(
                .spring(),
                value: isLoading
            )
            .onChange(of: isLoading, perform: { _ in
                withAnimation(.easeOut) {
                    animationFinished = !isLoading
                }
                Task {
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    withAnimation(.spring(
                        response: 0.4,
                        dampingFraction: 0.6,
                        blendDuration: 0.3
                    )) {
                        animationFinished.toggle()
                    }
                }
            })
        }
        .disabled(isLoading)
    }
}
