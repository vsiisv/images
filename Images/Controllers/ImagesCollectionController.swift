//
//  ViewController.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 03.05.2024.
//

import UIKit

class ImagesCollectionController: UIViewController {
	
	private var images: [Image] = []
	
	private let reuseIdentifier = "Cell"
	private let layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
		return layout
	}()
	
	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(ImagesCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		addSubViews()
		setupConstraints()
		setupDelegateAndDatasource()
		
		NetworkManager.shared.getImages { data in
			DispatchQueue.main.async {
				self.images = data
				self.collectionView.reloadData()
			}
		}
	}
	
	override func viewWillLayoutSubviews() {
		collectionView.reloadData()
	}
}

// MARK: - UICollectionViewDelegate and Datasource
extension ImagesCollectionController: UICollectionViewDelegate, UICollectionViewDataSource {
	private func setupDelegateAndDatasource() {
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImagesCell
		let imageUrl = images[indexPath.item].urls.small
		
		NetworkManager.shared.loadImage(from: imageUrl) { image in
			DispatchQueue.main.async {
				cell.imageView.image = image
			}
		}
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.id = images[indexPath.row].id
		vc.imageURL = images[indexPath.row].urls.full
		navigationController?.pushViewController(vc, animated: true)
	}
	
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImagesCollectionController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat
		if UIDevice.current.orientation.isLandscape {
			width = collectionView.frame.width / 4
		} else {
			width = (collectionView.frame.width - 50) / 2
		}
		let size = CGSize(width: width, height: 200)
		return size
	}
}

// MARK: - Style and Layout
private extension ImagesCollectionController {
	func setupView() {
		view.backgroundColor = .white
	}
	
	func addSubViews() {
		view.addSubview(collectionView)
	}
	
	func setupConstraints() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}

// MARK: - Preview

#Preview {
	let vc = ImagesCollectionController()
	return vc
}
