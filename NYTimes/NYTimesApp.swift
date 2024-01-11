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
    public init() {
        loadConfigurations()
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    @Dependency(\.viewFactory) var viewFactory
    var body: some Scene {
        WindowGroup {
            NavigationUI {
                AnyView(
                    viewFactory.makeView(
                        input: .list(isLoading: false, error: nil, articles: [])
                    )
                )
            }
            .background(.black)
        }
    }
    func loadConfigurations() {
        let networkConfig = NYTimesConfiguration()
        networkConfig.config(name: "Most Viewed Api", endpoint: .mostViewed(), responseModel: NYTimesDM.self)
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

