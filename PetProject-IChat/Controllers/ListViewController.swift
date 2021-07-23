//
//  ListViewController.swift
//  PetProject-IChat
//
//  Created by максим  кондратьев  on 23.07.2021.
//

import UIKit

//Для датасоурс
struct Mchat: Hashable, Decodable {
    var username:String
    var userImageString: String
    var lastMessage:String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


class ListViewController: UIViewController {
    
    var colView : UICollectionView!
    let activeChatsElements = Bundle.main.decode([Mchat].self, from: "activeChats.json")
    let waitingChatsElements = Bundle.main.decode([Mchat].self, from: "waitingChats.json")
    
    
    enum Section: Int, CaseIterable {
        case   waitingChats,activeChats
    }
    
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Mchat>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchBar()
        createDataSource()
        reloadData()
    }

    func configureSearchBar(){
        let searchC = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchC
        searchC.obscuresBackgroundDuringPresentation = false
        searchC.hidesNavigationBarDuringPresentation = false
        searchC.searchBar.delegate = self
    }
    
    private func configureCollectionView(){
        colView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        colView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        colView.backgroundColor = .systemBackground
        view.addSubview(colView)
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        colView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid2")
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: colView, cellProvider: { (collView, indexPath, chat) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("uknwon section error")
            }
            switch section {
            case .activeChats:
                let cell = collView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
                cell.backgroundColor = .gray
                return cell
            case .waitingChats:
                let cell = collView.dequeueReusableCell(withReuseIdentifier: "cellid2", for: indexPath)
                cell.backgroundColor = .red
                return cell
            }
        })
    }
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Mchat>()
        snapshot.appendSections([.waitingChats, .activeChats])
        snapshot.appendItems(waitingChatsElements, toSection: .waitingChats)
        snapshot.appendItems(activeChatsElements, toSection: .activeChats)
        dataSource?.apply(snapshot)
         
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, enviroment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("uknwon section error")
            }
            switch section {
            
            case .activeChats:
                return self.createActiveChats()
            case .waitingChats:
                return self.createWaitingChats()
            }
        }
        return layout
    }
    
    func createWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupsize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupsize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    func createActiveChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension:
                                                .fractionalWidth(1),
                                              heightDimension:
                                                .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupsize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(78))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:groupsize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 8, trailing: 20)
       
        return section
    }
   
}

// MARK:  UICollectionViewDelegate & Data Sourse


extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
