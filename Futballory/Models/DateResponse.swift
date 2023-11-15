//
//  DateResponse.swift
//  Futballory
//
//  Created by Aldair Carrillo on 13/11/23.
//

import Foundation

// MARK: - Date Response
struct DateResponse: Codable {
    let success: Bool
    let dates: [String]
}
