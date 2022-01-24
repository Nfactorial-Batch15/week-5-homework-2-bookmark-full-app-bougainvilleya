//
//  MainPageController.swift
//  BookmarkUIKit
//
//  Created by Leyla Nyssanbayeva on 23.01.2022.
//

import UIKit
import SnapKit

class MainPageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let dataStorage = DataStorage()
    
    private let bookmarksTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private var navigationBarTitle: UILabel = {
        let labelText = UILabel()
        labelText.text = "Bookmark App"
        labelText.textColor = .black
        labelText.font = .systemFont(ofSize: 17, weight: .semibold)
        return labelText
    }()
    
    private var emptyTitle: UILabel = {
        let labelText = UILabel()
        labelText.text = "Save your first\nbookmark"
        labelText.textColor = .black
        labelText.textAlignment = .center
        labelText.numberOfLines = 2
        labelText.font = .systemFont(ofSize: 36, weight: .bold)
        return labelText
    }()
    
    private var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add bookmark", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        if dataStorage.isFirstLaunch {
            let onboarding = OnboardingViewController()
            onboarding.modalPresentationStyle = .fullScreen
            navigationController?.present(onboarding, animated: true, completion: nil)
            dataStorage.isFirstLaunch = false
        }
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(navigationBarTitle)
        navigationBarTitle.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-20)
        }
        
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        
        bookmarksTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "bookmarks")
        
        view.addSubview(emptyTitle)
        emptyTitle.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        
        view.addSubview(bookmarksTableView)
        bookmarksTableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.leading.trailing.equalToSuperview()
        }

        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.height.equalTo(58)
            make.width.equalTo(view).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        addButton.addTarget(self, action: #selector(handlerAddButton), for: .touchUpInside)
        
        showEmptyView(dataStorage.bookmarks.isEmpty, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    @objc func handlerAddButton() {
        let ac = UIAlertController(title: "New bookmark", message: nil, preferredStyle: .alert)
        
        ac.addTextField()
        ac.textFields?[0].placeholder = "Bookmark title"
        
        ac.addTextField()
        ac.textFields?[1].placeholder = "Bookmark link"
        
        ac.textFields?.forEach { item in
            item.snp.makeConstraints({ make in
                make.height.equalTo(34)
            })
        }
        
        let submitAction = UIAlertAction(title: "Save", style: .cancel) { [unowned ac] _ in
            let titleBookmark = ac.textFields?[0].text ?? ""
            let urlBookmark = ac.textFields?[1].text ?? ""
            
            if self.verifyURL(urlString: urlBookmark) && !titleBookmark.isEmpty {
                self.dataStorage.bookmarks.append(Bookmark(title: titleBookmark, url: urlBookmark))
                self.bookmarksTableView.reloadData()
                self.showEmptyView(self.dataStorage.bookmarks.isEmpty)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        [cancel, submitAction].forEach { item in
            ac.addAction(item)
        }
        present(ac, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStorage.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookmarksTableView.dequeueReusableCell(
            withIdentifier: "bookmarks",
            for: indexPath
        ) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(title: dataStorage.bookmarks[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = URL(string: dataStorage.bookmarks[indexPath.row].url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataStorage.bookmarks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            showEmptyView(dataStorage.bookmarks.isEmpty)
        }
        print("DEBUG: ", dataStorage.bookmarks.count)
    }
    
    func verifyURL(urlString: String) -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    func showEmptyView(_ isEmptyViewShown: Bool, animated: Bool = true) {
        let titleAlpha: CGFloat = isEmptyViewShown ? 1 : 0
        let tableViewAlpha: CGFloat = isEmptyViewShown ? 0 : 1
        UIView.animate(withDuration: 0.2) {
            self.emptyTitle.alpha = titleAlpha
            self.bookmarksTableView.alpha = tableViewAlpha
        }
    }
}
