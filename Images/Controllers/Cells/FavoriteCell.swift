//
//  FavoriteCell.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 05.05.2024.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
	
	var imageView = UIImageView()
	var authorNameLabel = UILabel()
	private let padding: CGFloat = 10
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubviews()
		setupConstraints()
		setupCell()
		setupImage()
		setupNameLabel()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Add subviews and Constraints
private extension FavoriteCell {
	func setupCell() {
		backgroundColor = .systemGray5
		layer.cornerRadius = 10
	}
	
	func setupImage() {
		imageView.backgroundColor = .blue
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 5
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(systemName: "photo")
	}
	
	func setupNameLabel() {
		authorNameLabel.text = "Author's name"
		authorNameLabel.numberOfLines = 0
	}
	
	func addSubviews() {
		addSubview(imageView)
		addSubview(authorNameLabel)
	}
	
	func setupConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
//			imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			imageView.widthAnchor.constraint(equalToConstant: 50),
			
			authorNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
			authorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			authorNameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
			
		])
	}
}
