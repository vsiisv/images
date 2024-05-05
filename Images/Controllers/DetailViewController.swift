//
//  DetailViewController.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 05.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
	
	var imageView = UIImageView()
	var authorNameLabel = UILabel()
	var dateOfCreationLabel = UILabel()
	var locationLabel = UILabel()
	var downloadsLabel = UILabel()
	
	lazy var verticalStackView: UIStackView =  {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = 5
		stackView.contentMode = .scaleToFill
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()
	
	private lazy var addFavoriteButton: UIButton = {
		let button = UIButton()
		let image = UIImage(systemName: "heart")
		button.setBackgroundImage(image, for: .normal)
		button.tintColor = .red
		return button
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		addSubviews()
		setupConstraints()
		setupImage()
		setupNameLabel()
		setupCreationLabel()
		setupLocationLabel()
		setupDownloadsLabel()
    }
}

// MARK: - Style and Constraints
private extension DetailViewController {
	func setupImage() {
		imageView.backgroundColor = .blue
	}
	
	func setupNameLabel() {
		authorNameLabel.text = "Author's name"
		authorNameLabel.textAlignment = .center
		authorNameLabel.font = UIFont(name: "Zapfino", size: 15)
	}
	
	func setupCreationLabel() {
		dateOfCreationLabel.text = "Date of creation"
		dateOfCreationLabel.textAlignment = .left
	}
	
	func setupLocationLabel() {
		locationLabel.text = "Location"
		locationLabel.textAlignment = .left
	}
	
	func setupDownloadsLabel() {
		downloadsLabel.text = "Count of Downloads"
		downloadsLabel.textAlignment = .left
	}
	
	// Add Subviews
	func addSubviews() {
		view.addSubview(imageView)
		imageView.addSubview(addFavoriteButton)
		view.addSubview(verticalStackView)
		verticalStackView.addArrangedSubview(authorNameLabel)
		verticalStackView.addArrangedSubview(locationLabel)
		verticalStackView.addArrangedSubview(dateOfCreationLabel)
		verticalStackView.addArrangedSubview(downloadsLabel)
		
	}
	
	// Constraints
	func setupConstraints() {
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		verticalStackView.translatesAutoresizingMaskIntoConstraints = false
		addFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: verticalStackView.topAnchor),
			
			verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			verticalStackView.heightAnchor.constraint(equalToConstant: 200),
			
			addFavoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
			addFavoriteButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
			addFavoriteButton.heightAnchor.constraint(equalToConstant: 50),
			addFavoriteButton.widthAnchor.constraint(equalToConstant: 50),
		])
	}
}


// MARK: - Preview
#Preview {
	return DetailViewController()
}
