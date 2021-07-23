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
        
        func description() -> String {
            switch self {
            case .waitingChats:
                return "Waiting chats"
            case .activeChats:
                return "Active chats"
            }
        }
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
        searchC.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureCollectionView(){
        colView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        colView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        colView.backgroundColor = .systemBackground
        view.addSubview(colView)
        
        colView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.reuseId )
        
        colView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.reuseId )
        
        colView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: colView, cellProvider: { (collView, indexPath, chat) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("uknwon section error")
            }
            switch section {
            case .activeChats:
                return self.configure(cellType: ActiveChatCell.self, with: chat, for: indexPath)
                
            case .waitingChats:
                return self.configure(cellType: WaitingChatCell.self, with: chat, for: indexPath)
            }
        })
        //
        dataSource?.supplementaryViewProvider = {
            collectionView, kind , indexPath in
            guard  let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {
                fatalError("Cannot create new Section Header")
            }
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("ssdfsd")}
            sectionHeader.configure(text: section.description(), font: .laoSangamMn20() , textColor: .systemGray)
                return sectionHeader
        }
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
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    func createWaitingChats() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupsize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupsize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        //Хедеры
         let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
         
        return section
    }
    //---Хедеры
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        
        let headerLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerLayoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
    //----
    
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
        
        let sectionHeader = createSectionHeader()
       section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
   
    
    private func configure<T: SelfConfigureCell>(cellType: T.Type, with value: Mchat, for indexPath: IndexPath) -> T {
        guard let cell = colView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("EROOR")}
        
        cell.configure(with: value)
           return cell
    }
    
}

// MARK:  UICollectionViewDelegate & Data Sourse


extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
