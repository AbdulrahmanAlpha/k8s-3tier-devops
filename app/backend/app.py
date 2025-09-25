from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)

DB_HOST = os.environ.get("DB_HOST", "postgres")
DB_NAME = os.environ.get("DB_NAME","appdb")
DB_USER = os.environ.get("DB_USER","appuser")
DB_PASS = os.environ.get("DB_PASS","password")

@app.route("/health")
def health():
    return jsonify(status="ok")

@app.route("/api")
def api_root():
    try:
        conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASS)
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        cur.close()
        conn.close()
        return jsonify(db="ok")
    except Exception as e:
        return jsonify(db="error", msg=str(e)), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
