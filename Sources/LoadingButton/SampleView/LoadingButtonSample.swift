//
//  LoadingButtonSample.swift
//  
//
//  Created by Saeid Basirnia on 2023-08-05.
//

import SwiftUI
import Foundation

struct LoadingButtonSample: View {

    enum ButtonType {
        case loading
        case progress
    }

    private var type: ButtonType = .loading
    @State var isLoading = false
    @State var progress = 0.0

    var body: some View {
        if case ButtonType.loading = type {
            LoadingButtonView()
        } else if case ButtonType.progress = type {
            ProgressButtonView()
        } else {
            Text("Type unknown!")
        }
    }
}

struct ProgressButtonView: View {
    @State var isLoading = false
    @State var progress = 0.0

    let timer = Timer
        .publish(
            every: 1,
            on: .main,
            in: .common
        )

    var body: some View {
        VStack {
            LoadingButton(progressType: .progress(
                $isLoading,
                $progress
            )) {
                Text("Tap here!")
                    .foregroundColor(.white)
            } tapAction: {
                isLoading = true
                _ = timer.connect()
            }
            .onReceive(timer) { _ in
                if progress >= 1.0 {
                    isLoading = false
                    progress = 0.0
                    timer.connect().cancel()
                } else {
                    let random = Double.random(in: 0.0...0.3)
                    progress += random
                }
            }
        }
    }
}

struct LoadingButtonView: View {
    @State var isLoading = false
    @State private var counter = 0

    let timer = Timer
        .publish(
            every: 1,
            on: .main,
            in: .common
        )

    var body: some View {
        VStack {
            LoadingButton(progressType: .loading($isLoading)) {
                Text("Tap here!")
                    .foregroundColor(.white)
            } tapAction: {
                isLoading = true
                _ = timer.connect()
            }
            .onReceive(
                timer) { _ in
                    print("Ticked")
                    if counter >= 1 {
                        print("HERE")
                        counter = 0
                        isLoading = false
                        timer.connect().cancel()
                    } else {
                        counter += 1
                    }
                }
        }
    }
}

struct LoadingButtonSample_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButtonSample()
    }
}

