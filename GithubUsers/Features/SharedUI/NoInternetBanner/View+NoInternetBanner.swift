//
//  View+NoInternetBanner.swift
//  GithubUsers
//
//  Created by Chinmay Balutkar on 29/04/25.
//

import SwiftUI

extension View {
    func noInternetBanner(isVisible: Bool) -> some View {
        self.modifier(NoInternetBannerModifier(isVisible: isVisible))
    }
}
