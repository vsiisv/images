//
//  Image.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 05.05.2024.
//

import Foundation

struct Image: Codable {
	let id: String
	let createdDate: String
	let urls: Urls
	let downloads: Int?
	let user: User?
	let location: Location?
	
	enum CodingKeys: String, CodingKey {
		case id
		case createdDate = "created_at"
		case urls
		case downloads
		case user
		case location
	}
}

struct Urls: Codable {
	let full: String
	let small: String
}

struct User: Codable {
	let name: String
}

struct Location: Codable {
	let name: String?
	let city: String?
	let country: String?
}
