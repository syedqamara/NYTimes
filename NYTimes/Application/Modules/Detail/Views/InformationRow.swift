//
//  InformationRow.swift
//  NYTimes
//
//  Created by Apple on 12/01/2024.
//

import Foundation
import SwiftUI
public struct InformationRow: View {
    public let label: String
    public let value: String?

    public var body: some View {
        if let value, value.isNotEmpty {
            HStack {
                Text("\(label):")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Text(value)
                    .font(.subheadline)
                    .multilineTextAlignment(.trailing)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
    }
}
public struct InformationRow_Previews: PreviewProvider {
    public static var previews: some View {
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    public struct Input {
        public let label: String
        public let value: String?
    }
    public static var snapshots: Previewer<Input> {
        .init(
            configurations: [
                .init(name: "Preview", state: .init(label: "Title", value: "Dummy Article Name"))
            ]) { input in
                InformationRow(label: input.label, value: input.value)
            }
    }
}
