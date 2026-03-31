//
//  AccountData.swift
//  FocusFixr
//
//  Created by Adriana Luns on 20/03/2026.
//

import Foundation
import SwiftData

@Model
class EmailAddresses {
    var id: UUID
    var email: String
    var isSelected: Bool

    init(email: String, isSelected: Bool) {
        self.email = email
        self.id  = UUID()
        self.isSelected = isSelected
    }
}

@Model
class AccountData {
    var accountName: String
    
    init(accountName: String) {
        self.accountName = accountName
    }
}
