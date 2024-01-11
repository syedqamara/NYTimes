//
//  RemoteImageViewModel.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import Dependencies
import UIKit
import core_architecture

public protocol RemoteImageViewModeling: ViewModeling {
    var image: UIImage? { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    init(url: String)
    func onAppear()
}

public class RemoteImageViewModel: RemoteImageViewModeling {
    @Published public var image: UIImage? = nil
    @Published public var isLoading: Bool = false
    @Published public var error: Error? = nil
    @Dependency(\.imageSource) private var imageSource
    private var url: String
    required public init(url: String) {
        self.url = url
    }
    public func onAppear() {
        guard !isLoading else { return }
        isLoading.toggle()
        Task {
            do {
                let imageData = try await imageSource.image(for: url)
                let downloadedImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.image = downloadedImage
                    self.isLoading.toggle()
                }
            }
            catch let err {
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                    self.error = err
                }
            }
        }
    }
}
