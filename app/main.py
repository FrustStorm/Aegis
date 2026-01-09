from flask import Flask, jsonify


app = Flask(__name__)


@app.route("/")
def home():
    return jsonify({"message": "Welcome to Aegis DevSecOps API"}), 200


@app.route("/health")
def health_check():
    return jsonify({"status": "healthy"}), 200


if __name__ == "__main__":
    # nosemgrep: python.flask.security.audit.app-run-param-config.avoid_app_run_with_bad_host
    app.run(host = "0.0.0.0", port = 5000)