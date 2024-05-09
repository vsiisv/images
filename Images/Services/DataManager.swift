//
//  DataManager.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 06.05.2024.
//

import Foundation

struct ImageUD: Codable {
	let id: String
	let authorName: String
	let url: String
}

class DataManager {
	private let userDefaults = UserDefaults(suiteName: "ids")
	private let idKey = "id"
	
	func saveImage(_ image: ImageUD) {
		
		do {
			var dataArray = obtainImages()
			dataArray.append(image)
			
			let encoder = JSONEncoder()
			let data = try encoder.encode(dataArray)
			
			userDefaults?.setValue(data, forKey: idKey)
			
		} catch {
			print("Saving error: \(error)")
		}
	}
	
	func deleteImage(_ image: ImageUD) {
		var idArray = obtainImages()
		
		if let index = idArray.firstIndex(where: { $0.id == image.id }) {
			idArray.remove(at: index)
		}
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(idArray)
			
			userDefaults?.setValue(data, forKey: idKey)
		} catch {
			print("Delete error: \(error)")
		}
	}
	
	func obtainImages() -> [ImageUD] {
		
		guard let ids = userDefaults?.data(forKey: idKey) else { return [] }
		do {
			let decoder = JSONDecoder()
			let image = try decoder.decode([ImageUD].self, from: ids)
			return image
		} catch {
			print("Obtain error: \(error)")
		}
		return []
	}
	
}
