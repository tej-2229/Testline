Quiz App - Flutter

Project Overview:

Purpose:
This project is a simple quiz application developed using the Flutter framework. The app fetches quiz data from a remote API (https://api.jsonserve.com/Uw5CrX), displays multiple-choice questions to the user, and shows the results after the user completes the quiz. The app also provides robust error handling for a seamless experience in case of network failures or issues with the data.

Core Features:
 Start Quiz: A button on the home screen allows the user to start the quiz.
 Multiple-Choice Questions: The user can answer multiple-choice questions with a set of options provided for each question.
 Results Summary: After completing the quiz, a summary screen will display the total points scored based on correct answers.
 Responsive UI: The app adapts well to various device screen sizes and orientations (portrait and landscape).
 API Integration: The app fetches quiz data from an external API endpoint and populates the quiz questions dynamically.
 Error Handling: If there’s an issue with the API request or data parsing, the app will display an appropriate error message.

Setup Instructions:
 Prerequisites:
  Before you can run the app, make sure you have the following prerequisites installed:
    Flutter SDK: Make sure you have Flutter installed. If not, follow the official installation guide.
    IDE: Use an IDE such as Visual Studio Code or Android Studio for Flutter development.
    Device/Emulator: You can run the app on a physical device or an Android/iOS emulator.

 Steps to Run the Project:
   1. Clone the Repository: First, clone the repository to your local machine using Git. Run the following command in your terminal: git clone <repository_url>
   2. Install Dependencies: Navigate into the project folder: cd <project_directory>
      Then, install all the necessary dependencies by running: flutter pub get
   3. Run the App: Ensure that you have a connected device or an emulator running. Use the following command to run the app: flutter run

Features and Screens
1. Home Screen:
The home screen includes a Start Quiz button. When clicked, it navigates the user to the quiz screen.

UI Components: A simple layout with a centered button to start the quiz.
Navigation: Clicking the "Start Quiz" button navigates to the QuizScreen.
2. Quiz Screen:
On this screen, the user is presented with multiple-choice questions fetched from the API. The user can select an answer, and upon clicking "Next", the next question is displayed.

Multiple-Choice Questions: Each question has a set of options, and only one answer can be selected at a time.
Navigation: After answering a question, the user clicks "Next" to move to the next question.
3. Results Screen:
After completing the quiz, the user is shown a results screen with the total points scored based on correct answers.

Summary: Displays the number of questions answered correctly and the total points.
UI Components: A simple layout displaying the score and a button to go back to the home screen.

Libraries and Packages Used
http: For making HTTP requests to the API endpoint to fetch quiz data.
dependencies:
  http: ^0.13.3
flutter: Core Flutter framework for building the app.

