//
//  NYTimesUIM.swift
//  NYTimes
//
//  Created by Apple on 11/01/2024.
//

import core_architecture

public struct NYTimesUIM: UIModel {
    public typealias DataModelType = NYTimesDM
    public let status: String
    public let copyright: String
    public let numResults: Int?
    public let results: [NYTArticleUIM]?
    init(status: String, copyright: String, numResults: Int?, results: [NYTArticleUIM]?) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
    public init(dataModel: NYTimesDM) {
        self.status = dataModel.status
        self.copyright = dataModel.copyright
        self.numResults = dataModel.numResults
        self.results = dataModel.results?.map { .init(dataModel: $0) }
    }
}

public struct NYTArticleUIM: UIModel, Identifiable {
    public typealias DataModelType = NYTArticle
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
    public let media: [NYTMediaUIM]?
    public let etaId: Int?
    
    public init(uri: String?, url: String?, id: Int?, assetId: Int?, source: String?, publishedDate: String?, updated: String?, section: String?, subsection: String?, nytdsection: String?, adxKeywords: String?, column: String?, byline: String?, type: String?, title: String?, abstract: String?, desFacet: [String]?, orgFacet: [String]?, perFacet: [String]?, geoFacet: [String]?, media: [NYTMediaUIM]?, etaId: Int?) {
        self.uri = uri
        self.url = url
        self.id = id
        self.assetId = assetId
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaId = etaId
    }
    public init(dataModel: NYTArticle) {
        self.uri = dataModel.uri
        self.url = dataModel.url
        self.id = dataModel.id
        self.assetId = dataModel.assetId
        self.source = dataModel.source
        self.publishedDate = dataModel.publishedDate
        self.updated = dataModel.updated
        self.section = dataModel.section
        self.subsection = dataModel.subsection
        self.nytdsection = dataModel.nytdsection
        self.adxKeywords = dataModel.adxKeywords
        self.column = dataModel.column
        self.byline = dataModel.byline
        self.type = dataModel.type
        self.title = dataModel.title
        self.abstract = dataModel.abstract
        self.desFacet = dataModel.desFacet
        self.orgFacet = dataModel.orgFacet
        self.perFacet = dataModel.perFacet
        self.geoFacet = dataModel.geoFacet
        self.media = dataModel.media?.map { .init(dataModel: $0) }
        self.etaId = dataModel.etaId
    }
}

public struct NYTMediaUIM: UIModel, Identifiable {
    public typealias DataModelType = NYTMedia
    public let type: String?
    public let subtype: String?
    public let caption: String?
    public let copyright: String?
    public let approvedForSyndication: Int?
    public let mediaMetadata: [NYTMediaMetadataUIM]?
    public var id: String { (type ?? "")  + (subtype ?? "") + (caption ?? "") }
    public init(type: String?, subtype: String?, caption: String?, copyright: String?, approvedForSyndication: Int?, mediaMetadata: [NYTMediaMetadataUIM]?) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
    public init(dataModel: NYTMedia) {
        self.type = dataModel.type
        self.subtype = dataModel.subtype
        self.caption = dataModel.caption
        self.copyright = dataModel.copyright
        self.approvedForSyndication = dataModel.approvedForSyndication
        self.mediaMetadata = dataModel.mediaMetadata?.map { NYTMediaMetadataUIM(dataModel: $0) }
    }
}

public struct NYTMediaMetadataUIM: UIModel, Identifiable {
    public typealias DataModelType = NYTMediaMetadata
    public let url: String?
    public let format: String?
    public let height: Int?
    public let width: Int?
    public var id: String { url ?? "" }
    public init(url: String?, format: String?, height: Int?, width: Int?) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
    public init(dataModel: NYTMediaMetadata) {
        self.url = dataModel.url
        self.format = dataModel.format
        self.height = dataModel.height
        self.width = dataModel.width
    }
}
