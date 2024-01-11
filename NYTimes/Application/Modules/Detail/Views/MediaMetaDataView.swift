//
//  MediaMetaDataView.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import SwiftUI

public struct MediaMetadataView: View {
    let metadata: NYTMediaMetadataUIM

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let url = metadata.url, let height = CGFloat(metadata.height ?? 0), let width = CGFloat(metadata.width ?? 0)  {
                HStack {
                    RemoteImage(
                        url: url,
                        lottiePlaceholder: Lotties.loading,
                        size: .init(width: height, height: width)
                    )
                }
                .frame(maxWidth: width, maxHeight: height)
            }
            InformationRow(label: "Format", value: metadata.format ?? "")
            InformationRow(label: "Height", value: String(metadata.height ?? 0))
            InformationRow(label: "Width", value: String(metadata.width ?? 0))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.bottom, 8)
    }
}

public struct MediaMetadataView_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    public static var snapshots: Previewer<NYTMediaMetadataUIM> {
        .init(
            configurations: [
                .init(name: "Preview", state: .init(dataModel: .preview))
            ]) { input in
                MediaMetadataView(metadata: input)
            }
    }
}
