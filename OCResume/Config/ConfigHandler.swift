//
//  ConfigHandler.swift
//  OCResume
//
//  Created by Olivier Conan on 08/04/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import CocoaLumberjack

class ConfigHandler {

    private(set) var config: [String: Any]? = nil

    init() {
        config = getDefaultConfig()
    }

    // If not fetching from a BE, use default config from json
    func getDefaultConfig() -> [String: Any]? {
        do {
            if let file = Bundle.main.url(forResource: "config", withExtension: "json") {
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

// MARK: fetch settings default config
extension ConfigHandler {

    func getSettingsTitle() -> String {
        guard let config = config,
            let presentationTitle = config["settingsTitle"] as? String else { return "" }
        return presentationTitle
    }

}

// MARK: fetch presentation default config
extension ConfigHandler {

    func getPresentationTitle() -> String {
        guard let config = config,
            let presentationTitle = config["presentationTitle"] as? String else { return "" }
        return presentationTitle
    }

    func getPresentationInstructions() -> String {
        guard let config = config,
            let presentationInstructions = config["presentationInstructions"] as? String else { return "" }
        return presentationInstructions
    }

}

// MARK: Fetch main default config
extension ConfigHandler {

    func getMainMenuButtons() -> [MainMenuButton] {
        guard let config = config,
            let mainMenuButtonsOrder = config["mainMenuSequence"] as? [String],
            let mainMenuButtons = config["mainMenuButtons"] as? [String: String] else { return [] }
        var mainMenuButtonsArray: [MainMenuButton] = []
        var colorIndex = 0
        let colorArray = UIColor.getPastelColors()
        let colorCount = colorArray.count - 1
        for key in mainMenuButtonsOrder {
            if let value = mainMenuButtons[key] {
                let type = MainState(rawValue: key)
                mainMenuButtonsArray.append(MainMenuButton(id: key, title: value, color: colorArray[colorIndex], type: type))
                colorIndex = colorIndex >= colorCount ? 0 : colorIndex + 1
            }
        }
        return mainMenuButtonsArray
    }

}
