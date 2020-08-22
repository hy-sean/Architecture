//
//  RepoListController.swift
//  mvvm
//
//  Created by hy_sean on 2020/08/22.
//  Copyright © 2020 siwon. All rights reserved.
//

import UIKit
import SafariServices

class RepoListController: UIViewController {
	
	lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		return tableView
	}()
	
	let viewModel: RepoListViewModel!
	
	init(viewModel: RepoListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureUI()
		bindViewModel()
	}
	
	func configureUI() {
		view.backgroundColor = .white
		
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	func bindViewModel() {
		navigationItem.title = "\(viewModel.userID)'s repositories"
	}
}

extension RepoListController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.repoList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
		let repo = viewModel.repoList[indexPath.row]
		
		cell.titleLabel.text = repo.name
		
		if let desc = repo.description {
			cell.descriptionLabel.text = desc
		} else {
			cell.stackView.removeArrangedSubview(cell.descriptionLabel)
		}
		
		if let language = repo.language {
			cell.languageLabel.text = language
		} else {
			cell.hashTagImageView.image = nil
			cell.stackView.removeArrangedSubview(cell.horizontalStackView)
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		let repo = viewModel.repoList[indexPath.row]
		
		if let _ = repo.description, let _ = repo.language {
			return 120
		}
		
		if repo.description != nil || repo.language != nil {
			return 90
		} else {
			return 60
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: false)
		
		let htmlURL = viewModel.repoList[indexPath.row].htmlURL ?? ""
		print(htmlURL)
		
		guard let url = URL(string: htmlURL) else { return }
		
		let safari = SFSafariViewController(url: url)
		safari.modalPresentationStyle = .popover
		
		present(safari, animated: true)
	}
}