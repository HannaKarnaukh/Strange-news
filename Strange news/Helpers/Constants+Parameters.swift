//
//  Constants+Parameters.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/18/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct QueryParameters: Hashable {
    static let category = "category"
    static let country = "country"
    static let sources = "sources"
    static let searchText = "q"
    static let page = "page"
}

struct ParamValues {
    static let category = ["Business": "business", "Entertainment": "entertainment", "General": "general", "Health": "health", "Science": "science", "Sports": "sports", "Technology": "technology"]
    
    static let country = ["Argentina": "ar", "Australia": "au", "Austria": "at", "Belgium": "be", "Brazil": "br", "Bulgaria": "bg", "Canada": "ca", "China": "cn", "Colombia": "co", "Cuba": "cu", "Czech Republic": "cz", "Egypt": "eg", "France": "fr", "Germany": "de", "Greece": "gr", "Hong Kong": "hk", "Hungary": "hu", "Indonesia": "id", "Ireland": "ie", "Israel": "il", "Italy": "it", "Japan": "jp", "Latvia": "lv", "Lithuania": "lt", "Malaysia": "my", "Mexico": "mx", "Morocco": "ma", "Netherlands": "nl", "New Zealand": "nz", "Nigeria": "ng", "Philippines": "ph", "Poland": "pl", "Portugal": "pt", "Romania": "ro", "Russia": "ru", "Saudi Arabia": "sa", "Serbia": "rs", "Singapore": "sg", "Slovakia": "sk", "Slovenia": "si", "South Africa": "za", "South Korea": "kr", "Sweden": "se", "Switzerland": "ch", "Taiwan": "tw", "Thailand": "th", "Turkey": "tr", "UAE": "ae", "Ukraine": "ua", "United Kingdom": "gb", "United States": "us"]
    
    static let source = ["ABC News": "abc-news", "Aftenposten": "aftenposten", "Argaam": "argaam", "Ars Technica": "ars-technica", "Associated Press": "associated-press", "Australian Financial Review": "australian-financial-review", "BBC News": "bbc-news", "BBC Sport": "bbc-sport", "Business Insider": "business-insider", "Buzzfeed": "buzzfeed", "CNN": "cnn", "CNN Spanish": "cnn-es", "Crypto Coins News": "crypto-coins-news", "Daily Mail": "daily-mail", "Die Zeit": "die-zeit", "El Mundo": "el-mundo", "ESPN Cric Info": "espn-cric-info", "Financial Times": "financial-times", "Focus": "focus", "FourFourTwo": "four-four-two", "Fox News": "fox-news", "Google News": "google-news", "Google News (UK)": "google-news-uk", "Gruenderszene": "gruenderszene", "Hacker News": "hacker-news", "Handelsblatt": "handelsblatt", "Il Sole 24 Ore": "il-sole-24-ore", "Independent": "independent", "La Gaceta": "la-gaceta", "La Repubblica": "la-repubblica", "Libération": "liberation", "Marca": "marca", "Medical News Today": "medical-news-today", "Mirror": "mirror", "National Geographic": "national-geographic", "New Scientist": "new-scientist", "Next Big Future": "next-big-future", "Recode": "recode", "RTL Nieuws": "rtl-nieuws", "SABQ": "sabq", "Svenska Dagbladet": "svenska-dagbladet", "TechRadar": "techradar", "The American Conservative": "the-american-conservative", "The Guardian (AU)": "the-guardian-au", "The Huffington Post": "the-huffington-post", "The Lad Bible": "the-lad-bible", "The New York Times": "the-new-york-times", "The Verge": "the-verge", "The Wall Street Journal": "the-wall-street-journal", "Time": "time", "Wired": "wired", "Wirtschafts Woche": "wirtschafts-woche", "Xinhua Net": "xinhua-net"]
}
        
    

