//
//  NoInternetBanner.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import SwiftUI

struct NoInternetBannerModifier: ViewModifier {
    let isVisible: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            if isVisible {
                VStack {
                    HStack {
                        Image(systemName: "wifi.slash")
                        Text("No Internet Connection")
                            .bold()
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
                    .padding()
                    
                    Spacer()
                }
                .accessibilityIdentifier("NoInternetBanner")
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.easeInOut(duration: 0.3), value: isVisible)
            }
        }
    }
}
