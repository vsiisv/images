//
//  TableCollectionViewController.swift
//  Images
//
//  Created by VASILY IKONNIKOV on 04.05.2024.
//

import UIKit

class FavoriteViewController: UIViewController {
	
	private var favoriteImages: [ImageUD] = []
	private let networkManager = NetworkManager()
	
	private let reuseIdentifier = "Cell"
	private let layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
		return layout
	}()
	
	lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		addSubViews()
		setupConstraints()
		setupDelegateAndDatasource()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getFavoriteImages()
		collectionView.reloadData()
	}
	
	override func viewWillLayoutSubviews() {
//		collectionView.reloadData()
	}
	
	private func getFavoriteImages() {
		let dataManager = DataManager()
		favoriteImages = dataManager.obtainImages()
	}
}

// MARK: - UICollectionViewDelegate and Datasource
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	private func setupDelegateAndDatasource() {
		collectionView.delegate = self
		collectionView.dataSource = self
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return favoriteImages.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoriteCell
		cell.authorNameLabel.text = favoriteImages[indexPath.row].authorName
		
		let url = favoriteImages[indexPath.row].url
		networkManager.loadImageKF(from: url, image: cell.imageView)
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.id = favoriteImages[indexPath.row].id
		vc.imageURL = favoriteImages[indexPath.row].url
		navigationController?.pushViewController(vc, animated: true)
	}
	
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = collectionView.frame.width - 50
		let size = CGSize(width: width, height: 100)
		return size
	}
}

// MARK: - Style and Layout
private extension FavoriteViewController {
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
	let vc = FavoriteViewController()
	return vc
}
