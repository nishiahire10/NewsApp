//
//  NewsListViewController.swift
//  News App
//
//  Created by Nishigandha Bhushan Jadhav on 29/06/24.
//

import UIKit
import Combine

class NewsListViewController: UIViewController {
    
    var contentView = NewsListView()
    var newsListViewmodel = NewsViewModel()
    private var cancellables = Set<AnyCancellable>()
    private typealias DataSource = UITableViewDiffableDataSource<NewsViewModel.Section, News>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<NewsViewModel.Section, News>

    private var dataSource : DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = contentView
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupBinding()
        configureDataSource()
        newsListViewmodel.fetchNews()
    }
    
    
    private func setupBinding() {
        newsListViewmodel.$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.contentView.spinner.startAnimating()
                case .finished(let news):
                    self?.endRefreshing()
                    self?.updateUI(news)
                case .error(let error):
                    self?.endRefreshing()
                    self?.showError(error)
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func updateUI(_ value: [News]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.news])
        snapshot.appendItems(value)
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, news in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell
            cell?.newstitleLabel.text = news.title
            if let newsimageurl = news.image_url {
                if let url = URL(string: newsimageurl) {
                    cell?.imgView.load(url: url)
                }
            }
            return cell
        })
        
        
        
    }
    private func setupTableView() {
        contentView.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
   
    private func showError(_ error: Swift.Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func endRefreshing() {
        self.contentView.spinner.stopAnimating()
        self.contentView.refreshControl.endRefreshing()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
