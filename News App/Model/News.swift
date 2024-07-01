//
//  News.swift
//  News App
//
//  Created by Nishigandha Bhushan Jadhav on 01/07/24.
//

import Foundation

struct NewsData : Decodable {
    let status : String
    let totalResults : Int
    let results : [News]
}

struct News : Decodable {
    let article_id : String
    let title : String
    let link : String
    let keywords : [String]
    let creator : [String]
    let video_url : String?
    let description : String
    let content : String
    let pubDate : String
    let image_url : String
    let source_id : String
    let source_priority : Int
    let source_url : String
    let source_icon : String?
    let language : String
    let country : [String]
    let category : [String]
    let ai_tag : [String]
    let ai_region : [String]?
    let ai_org : [String]?
    let sentiment : String
    let sentiment_status : SentimentStatus

}

struct SentimentStatus : Decodable {
    let positive : Double
    let neutral : Double
    let egative : Double
}



//https://newsdata.io/api/1/latest?apikey=pub_475913578b987858da1497d23091478158c53&country=au,us
