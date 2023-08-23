//
//  MainView.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 18.08.2023.
//

import UIKit
import SnapKit

protocol MainViewProtocol where Self: UIView {
    var delegate: MainViewDelegate? { get set }
    var dataSource: MainViewDataSource? { get set }
    func loadingSeccess()
}

protocol MainViewDelegate: AnyObject {
    func selectedItem(index: Int)
}

protocol MainViewDataSource: AnyObject {
    func numberOfItems() -> Int
    func getCharacterInfo(for index: Int) -> Character
    func getCharacterImage(for index: Int) -> UIImage?
}

class MainView: UIView, MainViewProtocol {
    
    private var collectionViewLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    // view для отображения состояния загрузки
    private var loadingState = LoadingStateView()
    
    weak var delegate: MainViewDelegate?
    weak var dataSource: MainViewDataSource?

    init() {
        super.init(frame: .zero)
        backgroundColor = Constants.Colors.maindBG
        configureCollectionViewLayout()
        configureCollectionView()
        configureLoadingState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // метод вызывать при завершении загрузки данных для отображения
    func loadingSeccess() {
        collectionView.reloadData()
        loadingState.isHidden = true
    }
}

// MARK: - Configuration methods

extension MainView {
    func configureCollectionViewLayout() {
        collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 16
        collectionViewLayout.minimumLineSpacing = 16
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = Constants.Colors.maindBG
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "cell")
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(20)
        }
        
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 20),
//            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
//        ])
    }
    
    func configureLoadingState() {
        addSubview(loadingState)
        loadingState.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
//        loadingState.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            loadingState.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            loadingState.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            loadingState.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            loadingState.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
//        ])
        
    }
}

// MARK: - UICollectionViewDelegate

extension MainView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedItem(index: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource

extension MainView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCell
        cell.title = dataSource?.getCharacterInfo(for: indexPath.item).name ?? ""
        cell.image = dataSource?.getCharacterImage(for: indexPath.item) ?? UIImage(named: "Rick")
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

// метод возвращает размер отдельного item
extension MainView: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let noOfCellsInRow = 2 
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            // TODO: - переделать определение высоты item, сделать более гибким
            // 50 = высота titleLabel + отступы
            return CGSize(width: size, height: size+50)
        }
}
