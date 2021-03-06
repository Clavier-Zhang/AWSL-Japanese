<br />
<p align="center">
  <a href="https://github.com/Clavier-Zhang/AWSL-Japanese">
    <img src="./doc/logo/basic.jpg" alt="Logo" width="80" height="80">
  </a>
  <h3 align="center">AWSL Japanese</h3>
  <p align="center">
    A flash-card app that helps you to memorize Japanese vocabulary
    <br />
    <a href="https://apps.apple.com/us/app/awsl-japanese/id1492610472"><strong>Download at App Store - Apple</strong></a>
    <br />
    <br />
  </p>
</p>


## Table of Contents

- [Table of Contents](#table-of-contents)
- [About the Project](#about-the-project)
- [Previews](#previews)
  - [Dashboard](#dashboard)
  - [Study Steps (Handwriting / Keyboard)](#study-steps-handwriting--keyboard)
  - [Auth](#auth)
  - [Settings](#settings)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
    - [Set Up Server:](#set-up-server)
    - [Set Up Swift:](#set-up-swift)



<!-- ABOUT THE PROJECT -->
## About the Project

This app is made for me to learn Japanese. When I was learning English, many great apps are suitable for me. However, when it comes to Japanese, I can hardly find an ad-free, easy-to-use app to learn Japanese vocabularies. So I decided to make my app with following features.

* Support learning Japanese with both Chinese and English meanings. Include Japanese N1 to N5, over 5,000 core vocabularies with examples and audio.
  
* Based on your performance on each flashcard, the algorithm behind this app decides the best timing for the next review. Those challenging words will frequently appear until you are not forgetting anymore. With the help of Forgetting Curve, your learning efficiency is optimized.
  
* Multiple quiz modes to evaluate your learning. You can write done Hiragana using the Apple Pencil, and your handwriting will be compared with the correct solution for each flashcard. Also, you can use a keyboard and type Hiragana or Romaji as your answers.
  
* Your progress will be displayed on the dashboard.
  
* Support offline mode after fetching tasks.


## Previews

### Dashboard
<img src="./doc/preview/en_12.9/dashboard.png"  width="420" >

### Study Steps (Handwriting / Keyboard)
<p float="left">
    <img src="./doc/preview/en_12.9/learn_1.png"  width="420" >
</p>

<p float="left">
    <img src="./doc/preview/en_12.9/learn_2.1.png"  width="420" >
    <img src="./doc/preview/en_12.9/learn_2.2.png"  width="420" >
</p>

<img src="./doc/preview/en_12.9/learn_3.png"  width="420" >

### Auth
<p float="left">
    <img src="./doc/preview/en_12.9/signin.png"  width="420" >
    <img src="./doc/preview/en_12.9/signup.png"  width="420" >
</p>

### Settings
<p float="left">
    <img src="./doc/preview/en_12.9/settings.png"  width="420" >
    <img src="./doc/preview/en_12.9/plan.png"  width="420" >
</p>



## Getting Started

### Prerequisites
The following dependencies are necessary for iOS Development:
* Xcode 11.0+
* iOS 13.0+
* pod 3.0.1+

The following dependencies are necessary for server Development:
* Go 1.10+
* GoDotEnv

The following dependencies are necessary for machine learning:
* TensorFlow 1.14.0 (exactly)
* tfcoreml 1.1 (exactly)

### Install

#### Set Up Server:

<a href="https://github.com/joho/godotenv">
Install GoDotEnv to your command line
</a>

Change the .env.dev under server folder to your MongoDB address
```
DB_SERVER=<MONGO_DB ADDRESS>
DB_NAME=<DB_NAME>
```
Start Serverice
```sh
go build && godotenv -f ./.env.dev ./server
```



#### Set Up Swift:
```sh
cd swift
pod install
```
Open *awsl.xcworkspace* (not awsl.xcodeproj)

Replace the value of *baseURL* in awsl/utils/Data/RemoteData.swift to your server address (just set up)

```
// Address of your server
static let baseURL = "<Address of your server>/api"
```

Click run in swift