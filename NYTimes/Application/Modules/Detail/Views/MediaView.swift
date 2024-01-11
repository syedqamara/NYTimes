//
//  MediaView.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import SwiftUI

public struct MediaView: View {
    let media: NYTMediaUIM

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            InformationRow(label: "Type", value: media.type ?? "")
            InformationRow(label: "Caption", value: media.caption ?? "")
            // Display media metadata
            if let metadata = media.mediaMetadata, !metadata.isEmpty {
                Text("Media Metadata:")
                    .font(.headline)
                
                ForEach(metadata) { metadataItem in
                    MediaMetadataView(metadata: metadataItem)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.bottom, 8)
    }
}
public struct MediaView_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    public static var snapshots: Previewer<NYTMediaUIM> {
        .init(
            configurations: [
                .init(name: "Preview", state: .init(dataModel: .preview))
            ]) { input in
                MediaView(media: input)
            }
    }
}
