//
//  DetailViewController.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 19.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    private var detailView = DetailView()
    private var netWorkService: NetworkService
    private var character: Character
    private var characterImage: UIImage
    private var episodes: [EpisodeNetworkModel] = []
    private var origin: LocationNetworkModel = LocationNetworkModel()

    init(netWorkService: NetworkService, character: Character, image: UIImage) {
        self.netWorkService = netWorkService
        self.character = character
        self.characterImage = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupDetailView()
    }
    
    private func setupDetailView() {
        detailView.dataSource = self
        getEpisodeList()
        self.view = detailView
    }
    
    private func getEpisodeList() {
        let group = DispatchGroup()
        for episodeURL in character.episode {
            guard let episodeID = episodeURL.split(separator: "/").last else { continue }
            group.enter()
            netWorkService.getSearchResults(EpisodeNetworkModel.self, searchExpression: "episode/\(episodeID)") { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        strongSelf.episodes.append(data)
                    }
                case .failure(let error):
                    // TODO: - сделать визуальную обработку ошибок
                    print(error.localizedDescription)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            // вызов следующего метода получения данных
            self.getCharacterOrigin()
        }
    }
    
    private func getCharacterOrigin() {
        guard let originID = character.origin.url.split(separator: "/").last else {
            detailView.loadingSeccess()
            return
        }
        netWorkService.getSearchResults(LocationNetworkModel.self, searchExpression: "location/\(originID)") { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    strongSelf.origin = data
                    // оповещаем mainView, что загрузка закончилась
                    strongSelf.detailView.loadingSeccess()
                }
            case .failure(let error):
                // TODO: - сделать визуальную обработку ошибок
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - DetailViewDataSource

extension DetailViewController: DetailViewDataSource {
    func getOrigin() -> LocationNetworkModel {
        return origin
    }
    
    func getEpisode(for index: Int) -> EpisodeNetworkModel {
        episodes[index]
    }
    
    func numberOfEpisodes() -> Int {
        return episodes.count
    }
    
    func getCharacterImage() -> UIImage {
        return characterImage
    }
    
    func getCharacter() -> Character {
        return character
    }
}
