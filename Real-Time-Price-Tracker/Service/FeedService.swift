//
//  FeedService.swift
//  Real-Time-Price-Tracker
//
//  Created by Ujala on 05/03/26.
//

import Foundation


class FeedService {
    
    //dummy hardoded data
    
    let stockSymbols = [
            "AAPL": "Apple Inc. designs consumer electronics, software, and services including iPhone, Mac, and iCloud.",
              "GOOG": "Alphabet Inc., the parent company of Google, dominates search, advertising, and cloud computing.",
              "TSLA": "Tesla develops electric vehicles, battery technology, and autonomous driving software.",
              "AMZN": "Amazon operates the world's largest online marketplace and a massive cloud platform (AWS).",
              "MSFT": "Microsoft builds operating systems, enterprise software, and the Azure cloud platform.",
              "META": "Meta Platforms runs Facebook, Instagram, and develops virtual and augmented reality technologies.",
              "NVDA": "NVIDIA designs GPUs and AI computing hardware used in gaming, data centers, and machine learning.",
              "NFLX": "Netflix provides global streaming entertainment and produces original films and series.",
              "INTC": "Intel develops microprocessors and semiconductor technologies for computing devices.",
              "AMD": "AMD designs CPUs and GPUs used in PCs, servers, and gaming consoles.",
              "ORCL": "Oracle provides enterprise database software and cloud infrastructure.",
              "IBM": "IBM focuses on enterprise computing, hybrid cloud, and AI technologies.",
              "CRM": "Salesforce develops cloud-based customer relationship management software.",
              "ADBE": "Adobe builds creative tools like Photoshop, Illustrator, and digital marketing platforms.",
              "PYPL": "PayPal operates digital payment systems used for online money transfers.",
              "UBER": "Uber runs a global ride-hailing and delivery platform.",
              "SHOP": "Shopify provides e-commerce infrastructure for online businesses.",
              "SQ": "Block (formerly Square) builds financial services and payment systems.",
              "SPOT": "Spotify offers music streaming and audio content globally.",
              "TWTR": "Twitter (now X) provides a real-time social media communication platform.",
              "SNAP": "Snap develops the Snapchat social messaging platform.",
              "BABA": "Alibaba operates a major Chinese e-commerce and cloud computing ecosystem.",
              "T": "AT&T provides telecommunications services including wireless and broadband.",
              "V": "Visa operates a global electronic payment network.",
              "MA": "Mastercard runs a worldwide payment processing network."
    ]
    
    @MainActor
    func fetchFeed(_ store: FeedStore) {
        store.symbols = stockSymbols.map { Symbol(id: $0.key, currentPrice: Double.random(in: 100...1000), previousPrice: Double.random(in: 100...1000), description: $0.value)}.sorted {$0.currentPrice > $1.currentPrice}
    }
}
