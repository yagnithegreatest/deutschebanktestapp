{\rtf1\ansi\ansicpg1251\cocoartf2639
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fnil\fcharset0 Monaco;}
{\colortbl;\red255\green255\blue255;\red255\green255\blue255;\red0\green0\blue0;\red20\green152\blue106;
\red235\green16\blue47;\red20\green152\blue106;\red235\green16\blue47;}
{\*\expandedcolortbl;;\cssrgb\c100000\c100000\c100000;\cssrgb\c0\c0\c0;\cssrgb\c0\c65098\c49020;
\cssrgb\c94902\c17255\c23922;\cssrgb\c0\c65098\c49020;\cssrgb\c94902\c17255\c23922;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs28 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 # DeutscheBankTestApp\
\
DeutscheBankTestApp is an iOS app that allows users to log in with their UserID and fetch their posts from [\cf4 \strokec4 JSONPlaceholder API\cf2 \strokec2 ](\cf5 \strokec5 https://jsonplaceholder.typicode.com\cf2 \strokec2 ). Users can mark any post as a favorite, and these favorites are stored locally for later viewing. Users can easily switch between viewing all posts or only their favorite ones.\
\
## Tech Stack\
The app is developed using Swift and utilizes the following technologies and libraries:\
\
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 -\cf2 \strokec2  **SwiftUI** for building the user interface.\
\cf5 \strokec5 -\cf2 \strokec2  **Alamofire** for networking tasks, fetching posts from the JSONPlaceholder API.\
\cf5 \strokec5 -\cf2 \strokec2  **CoreData** for local persistence of favorite posts.\
\cf5 \strokec5 -\cf2 \strokec2  **XCTest** framework for unit tests.\
\cf5 \strokec5 -\cf2 \strokec2  **Git** for version control.\
\
## Screenshots\
\
\pard\pardeftab720\partightenfactor0
\cf2 ![\cf4 \strokec4 Login\cf2 \strokec2 ](\cf5 \strokec5 ./screenshots/login.png\cf2 \strokec2 )\
![\cf4 \strokec4 My posts\cf2 \strokec2 ](\cf5 \strokec5 ./screenshots/myposts.png\cf2 \strokec2 )\
\pard\pardeftab720\partightenfactor0
\cf2 \cb3 \outl0\strokewidth0 ![\cf6 Comments\cf2 ](\cf7 ./screenshots/comments.png\cf2 )\
\pard\pardeftab720\partightenfactor0
\cf2 ![\cf6 Empty/error states\cf2 ](\cf7 ./screenshots/empty\cf2 )\cf2 \cb3 \outl0\strokewidth0 \strokec2 \
\pard\pardeftab720\partightenfactor0
\cf2 \
## Setup\
Follow these steps to get the app running on your local machine:\
\
\pard\pardeftab720\partightenfactor0
\cf5 \strokec5 1.\cf2 \strokec2  Clone this repository: `git clone https://github.com/yagnithegreatest/deutschebanktestapp.git`\
\cf5 \strokec5 2.\cf2 \strokec2  Navigate to the project directory: `cd DeutscheBankTestApp`\
\cf5 \strokec5 3.\cf2 \strokec2  Open the project in Xcode: `open DeutscheBankTestApp.xcodeproj`\
\cf5 \strokec5 4.\cf2 \strokec2  Build and run the project in the iOS Simulator or on a physical device.\
\
## Testing\
To run the unit tests, press `Command + U` in Xcode.}