//
//  DataHandler.swift
//  OCResume
//
//  Created by Olivier Conan on 08/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import CocoaLumberjack

class DataHandler {

    private(set) var data: [String: Any]? = nil

    init() {
        data = getDefaultData()
    }

    // If not fetching from a BE, use default config from json
    func getDefaultData() -> [String: Any]? {
        do {
            if let file = Bundle.main.url(forResource: "data_\(locale)", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers])
                if let object = json as? [String: Any] {
                    return object
                }
                return nil
            }
        } catch {
            DDLogError(error.localizedDescription)
        }
        return nil
    }

}
