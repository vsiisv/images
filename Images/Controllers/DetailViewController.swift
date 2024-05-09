//
//  DetailViewController.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 05.05.2024.
//

import UIKit

class DetailViewController: UIViewController {
	
	var id: String?
	var imageURL: String?

	private var dataManager = DataManager()

	private var imageView = UIImageView()
	private var authorNameLabel = UILabel()
	private var dateOfCreationLabel = UILabel()
	private var locationLabel = UILabel()
	private var downloadsLabel = UILabel()
	
	private lazy var verticalStackView: UIStackView =  {
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
		let button = UIButton(type: .system)
		let image = UIImage(systemName: "heart")
		button.setBackgroundImage(image, for: .normal)
		button.tintColor = .red
		button.addTarget(self, action: #selector(addToFavorite), for: .touchUpInside)
		return button
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		setupView()
		addSubviews()
		setupConstraints()
		setupImage()
		setupNameLabel()
		setupCreationLabel()
		setupLocationLabel()
		setupDownloadsLabel()
		
		getImageData()
		loadImage(with: imageURL)
    }
	
	// Get Data
	private func getImageData() {
		guard let id else { return }
		NetworkManager.shared.getImage(with: id) { image in
			DispatchQueue.main.async {
				self.updateUI(with: image)
			}
		}
	}
	
	private func loadImage(with url: String?) {
		guard let url else { return }
		NetworkManager.shared.loadImage(from: url) { image in
			DispatchQueue.main.async {
				self.imageView.image = image				
			}
		}
	}
	
	// Setup data to UI
	private func updateUI(with data: Image) {
		self.authorNameLabel.text = data.user?.name
		self.locationLabel.text = "Location: \(data.location?.country ?? "none county"), \(data.location?.city ?? "none city")"
		self.dateOfCreationLabel.text = "Creation date: \(data.createdDate)"
		
		if let downloads = data.downloads {
			self.downloadsLabel.text = "Count of Downloads: \(String(downloads))"
		}
		
		guard let id else { return }
		
		if dataManager.obtainImages().contains(where: { $0.id == id }) {
			addFavoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
		}
	}
	
	// Button Action
	@objc private func addToFavorite() {
		
		guard let id, let name = authorNameLabel.text, let url = imageURL else { return }
		let imageUD = ImageUD(id: id, authorName: name, url: url)

		if !dataManager.obtainImages().contains(where: { $0.id == id }) {
			dataManager.saveImage(imageUD)
			addFavoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
		} else {
			dataManager.deleteImage(imageUD)
			addFavoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
		}
	}
}

// MARK: - Style and Constraints
private extension DetailViewController {
	func setupView() {
		view.backgroundColor = .white
	}
	
	func setupImage() {
		imageView.image = UIImage(systemName: "photo")
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.cornerRadius = 10
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
		view.addSubview(addFavoriteButton)
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
			addFavoriteButton.widthAnchor.constraint(equalToConstant: 60),
		])
	}
}


// MARK: - Preview
#Preview {
	return DetailViewController()
}
