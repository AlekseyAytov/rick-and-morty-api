//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 18.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // главное view для отображения контента
    private var mainView: MainViewProtocol = MainView()
    private var mainViewNavigationTitle: MainViewNavigationTitle = MainViewNavigationTitle(text: "Characters")
    private var netWorkService: NetworkService
    // данные для отображения
    private var imagesCache: [Int: UIImage] = [:]
    private var characterList: [Character] = []

    init(netWorkService: NetworkService) {
        self.netWorkService = netWorkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupMainView()
    }
    
    private func setupMainView() {
        mainView.delegate = self
        mainView.dataSource = self
        getCharacterList()
        self.view = mainView
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainViewNavigationTitle)
        navigationItem.backBarButtonItem = UIBarButtonItem()
        navigationItem.backBarButtonItem?.tintColor = .white
    }
}

extension MainViewController {
    
    func getCharacterList() {
        netWorkService.getSearchResults(CharactersNetworkModel.self, searchExpression: "character") { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let data):
                // если получили данные, сохранить в глобальную переменную
                let results = data.results
                strongSelf.characterList = results
                // создаем группу задачь
                let group = DispatchGroup()
                for result in results {
                    group.enter()
                    // для каждой картинки запускаем асинхронную загрузку в группе
                    strongSelf.netWorkService.loadImageAsync(urlString: result.image) { imageData in
                        // так как result.id начинается с 1, то делаем -1 для удобства обращения
                        // момент спорный, но пока так
                        // TODO: - пересмотреть сохранение картинок
                        DispatchQueue.main.async {
                            strongSelf.imagesCache[result.id-1] = UIImage(data: imageData!)
                        }
                        group.leave()
                    }
                    // netWorkService.loadImageAsync обрабатывается в другой очереди, поэтому нужен notify в главной очереди
                    group.notify(queue: .main) {
                        // оповещаем mainView, что загрузка закончилась
                        strongSelf.mainView.loadingSeccess()
                    }
                }
            case .failure(let error):
                // TODO: - сделать визуальную обработку ошибок
                print(error.localizedDescription)
            }
        }
    }
}


extension MainViewController: MainViewDelegate {
    func selectedItem(index: Int) {
        let detailVC = DetailViewController(netWorkService: self.netWorkService, character: characterList[index], image: imagesCache[index]!)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: MainViewDataSource {
    func numberOfItems() -> Int {
        return characterList.count
    }
    
    func getCharacterInfo(for index: Int) -> Character {
        return characterList[index]
    }
    
    func getCharacterImage(for index: Int) -> UIImage? {
        return imagesCache[index]
    }
}
