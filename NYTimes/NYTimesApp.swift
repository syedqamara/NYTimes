//
//  NYTimesApp.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import SwiftUI
import Dependencies
import DebuggerUI
import Debugger

@main
struct NYTimesApp: App {
    @State var networkDebugAction: NetworkDebuggerActions? = nil
    @State var selectedCommand: ApplicationDebugCommands = .application
    @State var isDebugViewShowing: Bool = false
    @Dependency(\.viewFactory) var viewFactory
    public init() {
        loadConfigurations()
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some Scene {
        WindowGroup {
            VStack {
                switch selectedCommand {
                case .application:
                    NYTimesAppView(startScreen: .list(isLoading: false, error: nil, articles: []))
                case .debugger:
                    AnyView(
                        viewFactory.makeView(input: .breakpoint)
                    )
                }
            }
            .modifier(DebugShakeGestureModifier(selectedCommand: $selectedCommand, isShowing: $isDebugViewShowing, networkDebugAction: $networkDebugAction))
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

