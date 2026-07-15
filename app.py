from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import datetime

app = Flask(__name__, static_folder='static')
CORS(app)

def bot_response(message: str) -> str:
    m = (message or '').lower().strip()
    if any(g in m for g in ('hi', 'hello', 'hey')):
        return 'Hello! How can I help you today?'
    if 'time' in m:
        return 'Current server time is ' + datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    if 'help' in m:
        return "You can ask about the time, say 'hello', or type anything to echo."
    if m == '':
        return 'Please type a message.'
    return 'You said: ' + message

@app.route('/chat', methods=['POST'])
def chat():
    data = request.get_json(silent=True) or {}
    message = data.get('message', '')
    reply = bot_response(message)
    return jsonify({'reply': reply})

@app.route('/')
def index():
    return send_from_directory('static', 'index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
