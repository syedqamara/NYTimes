//
//  NYTimes.swift
//  NYTimes
//
//  Created by Apple on 10/01/2024.
//

import core_architecture

public struct NYTimesDM: DataModel {
    public let status: String
    public let copyright: String
    public let numResults: Int?
    public let results: [NYTArticle]?
    
    private enum CodingKeys: String, CodingKey {
        case status, copyright, numResults = "num_results", results
    }
}

public struct NYTArticle: DataModel {
    public let uri: String?
    public let url: String?
    public let id: Int?
    public let assetId: Int?
    public let source: String?
    public let publishedDate: String?
    public let updated: String?
    public let section: String?
    public let subsection: String?
    public let nytdsection: String?
    public let adxKeywords: String?
    public let column: String??
    public let byline: String?
    public let type: String?
    public let title: String?
    public let abstract: String?
    public let desFacet: [String]?
    public let orgFacet: [String]?
    public let perFacet: [String]?
    public let geoFacet: [String]?
    public let media: [NYTMedia]?
    public let etaId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case uri, url, id, assetId = "asset_id", source, publishedDate = "published_date", updated, section, subsection, nytdsection, adxKeywords, column, byline, type, title, abstract, desFacet, orgFacet, perFacet, geoFacet, media, etaId
    }
}

public struct NYTMedia: DataModel {
    public let type: String?
    public let subtype: String?
    public let caption: String?
    public let copyright: String?
    public let approvedForSyndication: Int?
    public let mediaMetadata: [NYTMediaMetadata]?
    
    private enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright, approvedForSyndication, mediaMetadata = "media-metadata"
    }
}

public struct NYTMediaMetadata: DataModel {
    public let url: String?
    public let format: String?
    public let height: Int?
    public let width: Int?
}
