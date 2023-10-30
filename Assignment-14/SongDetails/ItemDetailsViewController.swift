//
//  ItemDetailsViewController.swift
//  Assignment-14
//
//  Created by Eka Kelenjeridze on 30.10.23.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var song: Song?
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var itemDetailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [songImageView, songNameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        stackView.backgroundColor = .systemGroupedBackground
        stackView.backgroundColor = .systemIndigo.withAlphaComponent(0.5)
        stackView.layer.cornerRadius = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return stackView
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupImage()
        setupSubviews()
        setupConstraints()
        configureViews()
    }
    
    // MARK: - Configure
    func configureViews() {
        guard let song else { return }
        songNameLabel.text = song.name
        songImageView.image = song.image
    }
    
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupImage() {
        NSLayoutConstraint.activate([
            songImageView.heightAnchor.constraint(equalToConstant: 1000),
            songImageView.widthAnchor.constraint(equalTo: itemDetailsStackView.widthAnchor)
        ])
    }
    
    private func setupSubviews() {
        view.addSubview(itemDetailsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemDetailsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            itemDetailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemDetailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemDetailsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
}
