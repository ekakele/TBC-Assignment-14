//
//  SongTableViewCell.swift
//  Assignment-14
//
//  Created by Eka Kelenjeridze on 30.10.23.
//

import UIKit

final class SongTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        stackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .systemIndigo
        return label
    }()
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named:"")
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
        assembleCellStackView()
        setupCellStackViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CleanUp Content & PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        songNameLabel.text = nil
        songImageView.image = nil
    }
    
    //MARK: - Configure
    func configure(with model: Song) {
        songNameLabel.text = model.name
        songImageView.image = model.image
    }
    
    // MARK: - Private Methods
    private func setupView() {
        layer.shadowColor = UIColor.systemIndigo.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    private func assembleCellStackView() {
        addSubview(cellStackView)
        cellStackView.addArrangedSubview(songNameLabel)
        cellStackView.addArrangedSubview(songImageView)
    }
    
    private func setupCellStackViewConstraints() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: self.topAnchor),
            cellStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            cellStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
