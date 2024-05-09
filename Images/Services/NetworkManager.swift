//
//  NetworkManager.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 05.05.2024.
//

import UIKit

class NetworkManager {
	
	static let shared = NetworkManager()
	
	private let apiKey = "aWbA1rwHDmuNPOy-_vocTT8IeILqb-zhtDwy1n3lPN4"
	
	func getImages(completion: @escaping ([Image]) -> ()) {
		let api = "https://api.unsplash.com/photos/?client_id=\(apiKey)"
		
		guard let apiURL = URL(string: api) else { print("No data or response"); return }
		
		let session = URLSession(configuration: .default)
		
		let task = session.dataTask(with: apiURL) { data, response, error in
			guard let data, error == nil else { return }
			self.parse(json: data, completion: completion)
		}
		task.resume()
	}
	
	// Load image(picture)
	func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
		guard let url = URL(string: urlString) else {
			completion(nil)
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else {
				completion(nil)
				return
			}
			
			let image = UIImage(data: data)
			
			DispatchQueue.main.async {
				completion(image)
			}
		}
		task.resume()
	}
	
	
	// get current Image data
	func getImage(with imageId: String, completion: @escaping (Image) -> ()) {
		let api = "https://api.unsplash.com/photos/\(imageId)?client_id=\(apiKey))"
		
		guard let apiURL = URL(string: api) else { print("No data or response"); return }
		
		let session = URLSession(configuration: .default)
		
		let task = session.dataTask(with: apiURL) { data, response, error in
			guard let data, error == nil else { return }
			self.parse(json: data, completion: completion)
		}
		task.resume()
	}
	
	// parse json
	private func parse<T: Decodable>(json: Data, completion: @escaping (T) -> Void) {
		do {
			let decodedObject = try JSONDecoder().decode(T.self, from: json)
			completion(decodedObject)
		} catch {
			print("Failed to decode JSON:", error.localizedDescription)
		}
	}
}
