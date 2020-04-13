//
//  CloudKitTutorial.swift
//  SwiftUITutorial
//
//  Created by Jan Hovland on 13/04/2020.
//  Copyright © 2020 Jan Hovland. All rights reserved.
//

//  Block comment : Ctrl + Cmd + / (on number pad)
//  Indent        : Ctrl + Cmd + * (on number pad)

import CloudKit
import SwiftUI

struct CloudKitTutorial {
    struct RecordType {
        static let Tutorial = "Tutorial"
    }
    /// MARK: - errors
    enum CloudKitHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    // MARK: - fetching from CloudKit
    static func fetchTutorial(predicate:  NSPredicate, completion: @escaping (Result<Tutorial, Error>) -> ()) {
        let query = CKQuery(recordType: RecordType.Tutorial, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["title",
                                 "introduction",
                                 "url"]
        operation.resultsLimit = 50
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let recordID = record.recordID
                guard let title  = record["title"] as? String else { return }
                guard let introduction = record["introduction"] as? String else { return }
                guard let url = record["url"] as? String else { return }
                 
                let tutorial = Tutorial(recordID: recordID,
                                    title: title,
                                    introduction: introduction,
                                    url: url)
                completion(.success(tutorial))
            }
        }
        operation.queryCompletionBlock = { ( _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
            }
        }
        CKContainer.default().privateCloudDatabase.add(operation)
    }
}

