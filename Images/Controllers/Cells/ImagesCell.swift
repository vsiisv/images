//
//  ImagesCell.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 05.05.2024.
//

import UIKit

class ImagesCell: UICollectionViewCell {
	
	var imageView = UIImageView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		setupConstraints()
		setupCell()
		setupImage()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Add subviews and Constraints
private extension ImagesCell {
	func setupCell() {
		backgroundColor = .blue
		layer.cornerRadius = 10
	}
	
	func setupImage() {
		imageView.image = UIImage(systemName: "photo")
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10
		imageView.contentMode = .scaleToFill
	}
	
	func addSubviews() {
		addSubview(imageView)
	}
	
	func setupConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
}
