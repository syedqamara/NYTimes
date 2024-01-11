//
//  ContentView.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import SwiftUI
import Dependencies
import core_architecture
import DebuggerUI

public struct NYTimesAppView: View {
    public let startScreen: SwiftUIViewFactory.NYTViewsInput
    public init(startScreen: SwiftUIViewFactory.NYTViewsInput) {
        self.startScreen = startScreen
        loadConfigurations()
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    @Dependency(\.viewFactory) var viewFactory
    public var body: some View {
        NavigationUI {
            AnyView(
                viewFactory.makeView(
                    input: startScreen
                )
            )
        }
        .background(.black)
    }
    func loadConfigurations() {
        let networkConfig = NYTimesConfiguration()
        networkConfig.config(name: "Most Viewed Api", endpoint: .mostViewed(), responseModel: NYTimesDM.self)
    }
}


public struct NYTimesAppView_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    public static var snapshots: Previewer<SwiftUIViewFactory.NYTViewsInput> {
        .init(
            configurations: [
                .init(name: "Preview App while Loading", state: .list(isLoading: true, error: nil, articles: [])),
                .init(name: "Preview App with Error", state: .list(isLoading: false, error: "This is just a preview error", articles: [])),
                .init(name: "Preview App with Article", state: .list(isLoading: false, error: nil, articles: [.init(dataModel: .preview), .init(dataModel: .preview), .init(dataModel: .preview)]))
            ]) { input in
                NYTimesAppView(startScreen: input)
            }
    }
    
}
