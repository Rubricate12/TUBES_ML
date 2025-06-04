import json
import numpy as np
from flask import Flask, request, jsonify
import tensorflow as tf

# --- 1. Initialization ---

app = Flask(__name__)

# Load the vocabulary from vocab.json
try:
    with open('word_index.json', 'r') as f:
        vocab = json.load(f)
    print("Vocabulary loaded successfully.")
except FileNotFoundError:
    print("Error: vocab.json not found. Make sure the file is in the same directory.")
    exit()

# Load the TFLite model and allocate tensors
try:
    interpreter = tf.lite.Interpreter(model_path="sentiment_model_fixed.tflite")
    interpreter.allocate_tensors()
    print("TFLite model loaded successfully.")
except Exception as e:
    print(f"Error loading model: {e}")
    exit()

# Get input and output tensor details
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Get the model's expected input length from its shape
MAX_SEQUENCE_LENGTH = input_details[0]['shape'][1]
PAD_TOKEN_ID = vocab.get("[PAD]", 0)  # Get padding token ID, default to 0
UNK_TOKEN_ID = vocab.get("[UNK]", 1)  # Get unknown token ID, default to 1


# --- 2. Preprocessing Function ---

def preprocess_text(text, vocabulary, max_len):
    """
    Converts raw text into a numerical sequence for the TFLite model.
    """
    # Simple whitespace tokenization and lowercase
    tokens = text.lower().split()

    # Convert tokens to their integer IDs using the vocabulary
    token_ids = [vocabulary.get(token, UNK_TOKEN_ID) for token in tokens]

    # Pad or truncate the sequence to the fixed length
    if len(token_ids) < max_len:
        # Pad with the PAD token ID
        token_ids.extend([PAD_TOKEN_ID] * (max_len - len(token_ids)))
    else:
        # Truncate to the max length
        token_ids = token_ids[:max_len]

    # The model expects a batch of inputs, so we wrap it in an extra list
    return np.array([token_ids], dtype=np.float32)


# --- 3. Flask API Endpoint ---

@app.route('/predict_text', methods=['POST'])
def predict_text():
    # Get the JSON data from the request
    try:
        data = request.get_json(force=True)
        input_text = data['text']
        if not input_text:
            return jsonify({'error': 'No text provided'}), 400
    except Exception as e:
        return jsonify({'error': f'Invalid request format: {e}'}), 400

    # Preprocess the text to create the model input
    input_data = preprocess_text(input_text, vocab, MAX_SEQUENCE_LENGTH)

    # Run inference with the TFLite model
    interpreter.set_tensor(input_details[0]['index'], input_data)
    interpreter.invoke()
    output_data = interpreter.get_tensor(output_details[0]['index'])

    # Format the prediction as a JSON response
    # The output format depends on your model. This is an example for
    # a model returning a single sentiment score.
    prediction_score = output_data[0][0]

    return jsonify({
        'prediction': float(prediction_score),
        'input_text': input_text
    })


# --- 4. Run the Server ---

if __name__ == '__main__':
    # Use host='0.0.0.0' to make the server accessible from your local network
    app.run(host='0.0.0.0', port=8000, debug=True)