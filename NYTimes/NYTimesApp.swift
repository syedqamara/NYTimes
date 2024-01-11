//
//  NYTimesApp.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import SwiftUI
import Dependencies
import DebuggerUI

@main
struct NYTimesApp: App {
    
    var body: some Scene {
        WindowGroup {
            NYTimesAppView(startScreen: .list(isLoading: false, error: nil, articles: []))
        }
    }
}

extension View {
    public func navigationTitleView(_ title: String, font: Font = .largeTitle.bold()) -> some View {
        self
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ScrollView(.horizontal) {
                        HStack {
                            Text(title)
                                .font(font)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                }
            }
    }
}

