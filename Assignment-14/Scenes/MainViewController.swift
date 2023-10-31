//
//  MainViewController.swift
//  Assignment-14
//
//  Created by Eka Kelenjeridze on 29.10.23.
//

import UIKit

final class MainViewController: UIViewController, AddNewSongDelegate {
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var songs = [
        Song(name: "My Way", image: UIImage(named: "MyWay")!),
        Song(name: "We Float", image: UIImage(named: "WeFloat")!),
        Song(name: "Electric Intercourse", image: UIImage(named: "ElectricIntercourse")!),
        Song(name: "Can't Get Out Off My Mind", image: UIImage(named: "Can'tGetOutOffMyMind")!),
        Song(name: "It's Only Christmas Once A Year", image: UIImage(named: "It'sOnlyChristmasOnceAYear")!)
    ]
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupNavigationBar()
        setupTableView()
        setupTableViewConstraints()
    }
    
    // MARK: - Private Methods
    private func setupBackground() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Music Playlist"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: (UIImage(systemName: "plus.circle")), style: .plain, target: self, action: #selector(navigateToAddNewItemToListVCPage))
    }
    
    @objc private func navigateToAddNewItemToListVCPage() {
        let addNewItemToListVCPage = AddNewItemToListViewController()
        addNewItemToListVCPage.delegate = self
        self.navigationController?.pushViewController(addNewItemToListVCPage, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: "songCell")
        
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func addNewSong(song: Song) {
        songs.append(song)
        tableView.reloadData()
    }
}

// MARK: - TableVIew DataSource Methods
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let song = songs[indexPath.row]
        cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        if let songCell = cell as? SongTableViewCell {
            songCell.configure(with: song)
        }
        return cell
    }
}

// MARK: - TableVIew Delegate Methods
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDetailsViewController = ItemDetailsViewController()
        itemDetailsViewController.song = songs[indexPath.row]
        navigationController?.pushViewController(itemDetailsViewController, animated: true)
    }
}
