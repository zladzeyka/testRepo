//
//  Document.swift
//  Pods-GiniExample
//
//  Created by Enrique del Pozo Gómez on 1/14/18.
//

import Foundation

enum DocumentProgress: String, Decodable {
    case completed = "COMPLETED"
    case pending = "PENDING"
    case error = "ERROR"
}

enum DocumentOrigin: String, Decodable {
    case upload = "UPLOAD"
    case unknown = "UNKNOWN"
}

enum DocumentSourceClassification: String, Decodable {
    case composite = "COMPOSITE"
    case native = "NATIVE"
    case scanned = "SCANNED"
    case sandwich = "SANDWICH"
    case text = "TEXT"
}

public enum DocumentTypeV2 {
    case partial(Data)
    case composite(CompositeDocumentInfo)
    
    var name: String {
        switch self {
        case .partial:
            return "partial"
        case .composite:
            return "composite"
        }
    }
}

public struct Document {

    let compositeDocuments: [CompositeDocument]?
    let creationDate: Date
    let id: String
    let name: String
    let origin: DocumentOrigin
    let pageCount: Int
    let pages: [DocumentPage]?
    let links: DocumentLinks
    let partialDocuments: [PartialDocumentInfo]?
    let progress: DocumentProgress
    let sourceClassification: DocumentSourceClassification

    fileprivate enum Keys: String, CodingKey {
        case compositeDocuments
        case creationDate
        case id
        case links = "_links"
        case name
        case origin
        case pageCount
        case pages
        case partialDocuments
        case progress
        case sourceClassification
    }
}

// MARK: - Decodable

extension Document: Decodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let compositeDocuments = try container.decodeIfPresent([CompositeDocument].self, forKey: .compositeDocuments)
        let creationDate = try container.decode(Date.self, forKey: .creationDate)
        let id = try container.decode(String.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let origin = try container.decode(DocumentOrigin.self, forKey: .origin)
        let pageCount = try container.decode(Int.self, forKey: .pageCount)
        let pages = try container.decodeIfPresent([DocumentPage].self, forKey: .pages)
        let links = try container.decode(DocumentLinks.self, forKey: .links)
        let partialDocuments = try container.decodeIfPresent([PartialDocumentInfo].self, forKey: .partialDocuments)
        let progress = try container.decode(DocumentProgress.self, forKey: .progress)
        let sourceClassification = try container.decode(DocumentSourceClassification.self,
                                                        forKey: .sourceClassification)

        self.init(compositeDocuments: compositeDocuments,
                  creationDate: creationDate,
                  id: id,
                  name: name,
                  origin: origin,
                  pageCount: pageCount,
                  pages: pages,
                  links: links,
                  partialDocuments: partialDocuments,
                  progress: progress,
                  sourceClassification: sourceClassification)
    }
}
