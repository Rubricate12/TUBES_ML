# Steam Game Review Sentiment Analysis using LSTM and CNN1D

## Project Description

This project aims to perform sentiment analysis on Steam game review texts. A machine learning model is trained to classify reviews as positive or negative. The project covers stages from data preprocessing, model training using Long Short-Term Memory (LSTM) and 1D Convolutional Neural Network (CNN1D), to model implementation in a client-server architecture with a Flask backend and a Flutter frontend.

## Table of Contents

* [Dataset](#dataset)
* [Project Architecture](#project-architecture)
* [Data Preprocessing and Model Training](#data-preprocessing-and-model-training)
* [Models Used](#models-used)
* [Main Results](#main-results)
* [Installation](#installation)
* [How to Run](#how-to-run)
* [Directory Structure](#directory-structure)
* [Contributors](#contributors)

## Dataset

The dataset used in this project is "Steam Reviews" sourced from Kaggle.
* **Source:** [Steam Reviews on Kaggle](https://www.kaggle.com/datasets/filipkin/steam-reviews)
* **Description:** This dataset contains columns of Steam game reviews along with their sentiment labels (positive/negative). The main features used are the review text and the sentiment label.

## Project Architecture

This project consists of three main components:

1.  **Model Training (Jupyter Notebook):**
    * File: `tubes-ML_terakhir.ipynb`
    * Task: Performs preprocessing of review text data, trains LSTM and CNN1D models, evaluates them, and saves the best model in TensorFlow Lite (`.tflite`) format and `wordIndex.json` for word-to-index mapping.

2.  **Backend Server (Flask):**
    * Directory: `tflite_server/`
    * Main File: `server.py`
    * Task: Provides an API endpoint using Flask to receive new review texts, preprocess them, and provide sentiment predictions using the trained `.tflite` model.

3.  **Frontend Client (Flutter):**
    * Directory: `steam_review_analyst/`
    * Task: A mobile or desktop application that allows users to input Steam game review texts and get sentiment analysis results from the backend.

## Data Preprocessing and Model Training

The data preprocessing and model training stages performed in `tubes-ML_terakhir.ipynb` include:
* Loading the dataset.
* Text cleaning (removing special characters, stopwords, etc.).
* Language detection (using `langdetect`) to ensure reviews are in the desired language (e.g., English).
* Tokenizing review texts.
* Creating a vocabulary and `wordIndex.json` using Word2Vec or Keras tokenizer.
* Padding sequences to have uniform length.
* Splitting data into training and testing sets.
* Training LSTM and CNN1D models.
* Evaluating models and selecting the best one based on performance metrics.
* Converting the Keras model to TensorFlow Lite (`.tflite`) format.

## Models Used

Two main Deep Learning model architectures were explored for this sentiment classification task:
1.  **Long Short-Term Memory (LSTM):** A type of Recurrent Neural Network (RNN) effective at capturing long-term dependencies in sequential data like text.
2.  **1D Convolutional Neural Network (CNN1D):** Effective at extracting local features from sequences, such as important n-grams in text.

## Main Results

Based on the hyperparameter tuning process, it was found that the **CNN1D model performed better than the LSTM model** for the dataset and configuration used in this project. Detailed evaluation metrics (accuracy, precision, recall, F1-score) can be found in the `tubes-ML_terakhir.ipynb` notebook.

## Installation

### Backend (Flask) & Model Training
Ensure you have Python 3.x installed. It is recommended to use a virtual environment.

1.  **Clone this repository:**
    ```bash
    git clone https://github.com/Rubricate12/TUBES_ML.git
    cd TUBES_ML
    ```

2.  **Install the required Python libraries:**
    Create a `requirements.txt` file with the following content or install them one by one:
    ```
    pandas
    numpy
    scikit-learn
    tensorflow
    matplotlib
    json5 # or json if wordIndex.json does not use json5 features
    gensim #for word2vec
    langdetect
    Flask
    nltk # If used for stopwords or other tokenization
    # Add other libraries if any
    ```
    Then run:
    ```bash
    pip install -r requirements.txt
    ```
    You might need to download specific NLTK resources if using them for the first time (e.g., `stopwords`):
    ```python
    import nltk
    nltk.download('stopwords')
    nltk.download('punkt') # If using NLTK tokenizer
    ```

### Frontend (Flutter)

1.  Ensure you have installed the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2.  Navigate to the frontend directory:
    ```bash
    cd steam_review_analyst
    ```
3.  Install Flutter dependencies:
    ```bash
    flutter pub get
    ```

## How to Run

1.  **Train Model and Generate Artifacts:**
    * Open and run all cells in the Jupyter Notebook `tubes-ML_terakhir.ipynb`.
    * This will generate the `.tflite` model file (e.g., `sentiment_model.tflite`) and `wordIndex.json`. Ensure these files are saved in a location accessible by the Flask server (e.g., within the `tflite_server/model/` directory). Adjust paths in `server.py` if necessary.

2.  **Run Backend Flask Server:**
    * Navigate to the server directory:
        ```bash
        cd tflite_server
        ```
    * Run the Flask server:
        ```bash
        python server.py
        ```
    * The server will run (default usually at `http://127.0.0.1:5000/`). Note the IP address and port if you are running the frontend on a different device or emulator.

3.  **Run Frontend Flutter Application:**
    * Ensure the Flask backend server is running.
    * Navigate to the frontend directory:
        ```bash
        cd ../steam_review_analyst
        ```
    * Ensure the API endpoint URL in the Flutter code (usually in a service or network handler file) matches your Flask server's IP address and port.
    * Run the Flutter application on an emulator or physical device:
        ```bash
        flutter run
        ```

## Directory Structure


TUBES_ML/
│
├── tubes-ML_terakhir.ipynb     # Notebook for preprocessing, training, and model creation
├── tflite_server/              # Flask backend directory
│   ├── server.py               # Main Flask server script
│   ├── model/                  # (Recommended) Place to store .tflite model and wordIndex.json
│   │   ├── sentiment_model.tflite  # Example model name
│   │   └── wordIndex.json          # Example word index file name
│   └── ...                     # Other backend support files
│
├── steam_review_analyst/       # Flutter project directory (frontend)
│   ├── lib/
│   │   └── main.dart           # Main entry point for the Flutter application
│   ├── pubspec.yaml
│   └── ...                     # Standard Flutter project directory structure
│
└── README.md                   # This file


## Contributors

* **Arnoldus Bryan Hendry** - 1301220409 - [github profile](https://github.com/Rubricate12)
* **Muhammad Ma'ruf Firdaus** - 1301223001 - [github profile](https://github.com/maruffirdaus)
* **Riyan Syaputra** - 130122 - 
