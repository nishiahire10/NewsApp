//
//  NewsViewModel.swift
//  News App
//
//  Created by Nishigandha Bhushan Jadhav on 01/07/24.
//

import Foundation
import Combine


enum ListViewModelState {
    case loading
    case finished([News])
    case error(Swift.Error)
}
class NewsViewModel {
    
    @Published var news = [News]()
    private var cancellables = Set<AnyCancellable>() // (1)
    @Published var state: ListViewModelState = .loading
    
    enum Section { case news }
    
    func fetchNews() {
        WebService.shared.getData(endpoint: "https://newsdata.io/api/1/latest?apikey=pub_475913578b987858da1497d23091478158c53&country=au,us", type: NewsData.self )
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] newsData in
                self?.state = .finished(newsData.results)
                self?.news = newsData.results
                print(self?.news ?? "jhg")
            } .store(in: &cancellables)
    }
}

