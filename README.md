# Real-Time-Price-Tracker
This repo is code base for an iOS application using SwiftUI that displays real-time price updates for multiple symbols (e.g., NVDA, AAPL, GOOG, etc.) and supports a second screen for symbol details.

## Features
- Live stock symbol feeds 
- Feeds can be on/off
- Feeds react to network connectivity

## Screens
 Feed view
 - Displays live symbol name, price and its variation indicator.
 - Shows Connectivity and a wway to  on/off the live feeds
   <img width="300" height="700" alt="Simulator Screenshot - iPhone 16 Pro - 2026-03-06 at 14 46 15" src="https://github.com/user-attachments/assets/ba65f447-955f-4f86-835c-844be2623699" />
 
 Symbol Detail View
 - Displays details of symbol along with live variation of price
   <img width="300" height="700" alt="Simulator Screenshot - iPhone 16 Pro - 2026-03-06 at 14 47 17" src="https://github.com/user-attachments/assets/9a5bf093-a866-4fc2-801c-d28d0e529b30" />

##Route
 A naviagtion stack over root view is establised as a central place for routing to different screens. It makes use of Route
 that stores the current path of navigation stack, and also helps to push pop views.

## Architecture
    MVVM 

## Model
###Symbol:

        1. name/id
        2. currentPrice
        3. previous Price 

## Dependencies
### FeedStore
    - Responsible for managing symbol information
    - Stores the symbol list 
    - Updates the symbol list with new Price value
### FeedService
    - Responsible to get the symbol list
    - In this project, dummy data is used to get the list.
### Reachability 
    - Fetches Real time updates of network connectivity.
### Web Socket
    - Service responsible for sending and receiving new price values.
        

