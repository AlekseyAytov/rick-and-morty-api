//
//  DetailView.swift
//  RickAndMorty
//
//  Created by Alex Aytov on 19.08.2023.
//

import UIKit
import SnapKit

protocol DetailViewDataSource: AnyObject {
    func numberOfEpisodes() -> Int
    func getEpisode(for index: Int) -> EpisodeNetworkModel
    func getCharacter() -> Character
    func getCharacterImage() -> UIImage
    func getOrigin() -> LocationNetworkModel
}

class DetailView: UIView {
    
    private(set) var tableView: UITableView!
    private(set) var headerForTable = DetailHeaderView()
    // view для отображения состояния загрузки
    private(set) var loadingState = LoadingStateView()
    
    weak var dataSource: DetailViewDataSource?

    init() {
        super.init(frame: .zero)
        backgroundColor = Constants.Colors.maindBG
        configureTableView()
        configureLoadingState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadingSeccess() {
        configureHeaderForTable()
        tableView.reloadData()
        loadingState.isHidden = true
    }
}

extension DetailView {
    
    func configureTableView() {
        tableView = UITableView()
        tableView.backgroundColor = Constants.Colors.maindBG
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerForTable
        tableView.allowsSelection = false
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.reuseId)
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.reuseId)
        tableView.register(LocationCell.self, forCellReuseIdentifier: LocationCell.reuseId)
        
        addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func configureLoadingState() {
        addSubview(loadingState)
        loadingState.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func configureHeaderForTable() {
        headerForTable.name = dataSource?.getCharacter().name
        headerForTable.image = dataSource?.getCharacterImage()
        headerForTable.status = dataSource?.getCharacter().status
    }
}

// MARK: - UITableViewDataSource

extension DetailView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return dataSource?.numberOfEpisodes() ?? 0
        default:
            return 0
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.reuseId, for: indexPath) as! InfoCell
            cell.species = dataSource?.getCharacter().species
            cell.type = dataSource?.getCharacter().type
            cell.gender = dataSource?.getCharacter().gender.rawValue
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseId, for: indexPath) as! LocationCell
            cell.name = dataSource?.getOrigin().name
            cell.type = dataSource?.getOrigin().type
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reuseId, for: indexPath) as! EpisodeCell
            cell.name = dataSource?.getEpisode(for: indexPath.row).name
            cell.number = parsNumberElements(number: dataSource?.getEpisode(for: indexPath.row).episode ?? "")
            cell.air = dataSource?.getEpisode(for: indexPath.row).air_date
            return cell
        default:
            break
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    func parsNumberElements(number: String) -> String {
        var matchedStrings: [String] = []
        
        let regex =  try! NSRegularExpression(pattern: "S([0-9]{1,})E([0-9]{1,})")
        let matches = regex.matches(in: number, range: NSRange(location: 0, length: number.count))
        for match in matches {
            for n in 0..<match.numberOfRanges {
                let range = match.range(at: n)
                let swiftRange = Range(range, in: number)
                matchedStrings.append(String(number[swiftRange!]))
            }
        }
        
        if !matchedStrings.isEmpty {
            return "Episode \(matchedStrings[2]), Season \(matchedStrings[1])"
        } else {
            return "Episode 0, Season 0"
        }
    }
}

// MARK: - UITableViewDelegate

extension DetailView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return HeaderForSection(text: "Info")
        case 1:
            return HeaderForSection(text: "Origin")
        case 2:
            return HeaderForSection(text: "Episodes")
        default:
            return HeaderForSection(text: "")
        }
    }
}
