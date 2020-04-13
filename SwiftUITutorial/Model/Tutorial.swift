//
//  Tutorial.swift
//  SwiftUITutorial
//
//  Created by Jan Hovland on 13/04/2020.
//  Copyright © 2020 Jan Hovland. All rights reserved.
//

//  Block comment : Ctrl + Cmd + / (on number pad)
//  Indent        : Ctrl + Cmd + * (on number pad)

import SwiftUI
import CloudKit

struct Tutorial: Identifiable {
    var id = UUID()
    var recordID: CKRecord.ID?
    var title: String = ""
    var introduction: String = ""
    var url: String = ""
}


