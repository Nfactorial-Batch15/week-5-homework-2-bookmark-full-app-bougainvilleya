//
//  AppDataStorage.swift
//  BookmarkUIKit
//
//  Created by Leyla Nyssanbayeva on 24.01.2022.
//

import UIKit

class DataStorage {
    enum Key: String {
        case firstLaunch
        case bookmark
    }
    
    var isFirstLaunch = true {
        didSet {
            UserDefaults.standard.set(isFirstLaunch, forKey: DataStorage.Key.firstLaunch.rawValue)
        }
    }
    
    var bookmarks: [Bookmark] = []  {
        didSet {
            let data = try? JSONEncoder().encode(bookmarks)
            UserDefaults.standard.set(data, forKey: DataStorage.Key.bookmark.rawValue)
        }
    }
    
    init() {
        UserDefaults.standard.register(
            defaults: [DataStorage.Key.firstLaunch.rawValue: true]
        )
        let data = try? JSONEncoder().encode(
            [Bookmark(title: "codeforces", url: "https://codeforces.com/")]
        )
        UserDefaults.standard.register(
            defaults: [DataStorage.Key.bookmark.rawValue: data ?? Data()]
        )
        isFirstLaunch = UserDefaults.standard.bool(forKey: DataStorage.Key.firstLaunch.rawValue)
        bookmarks = getBookmarksValue(key: DataStorage.Key.bookmark.rawValue)
    }
    
    private func getBookmarksValue(key: String) -> [Bookmark] {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else{
            return []
        }
        let value = try? JSONDecoder().decode([Bookmark].self, from: data)
        return value ?? []
    }
}
