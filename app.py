from db import db
from db import Course, User, Assignment
from flask import Flask
from flask import request
import os
import json

app = Flask(__name__)
db_filename = "giftsusers.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code

# your routes here

# get all gifts by filters
@app.route("/gifts/")
def get_gifts():
    pass

# get a specific gift
@app.route("/gifts/<int:gift_id>")
def get_gift(gift_id):
    pass

# create a new gift
@app.route("/gifts/", methods=["POST"])
def create_gift():
    pass

# delete a specific gift
@app.route("/gifts/<int:gift_id>", methods=["DELETE"])
def delete_gift(gift_id):
    pass

# create a new user
@app.route("/api/users/", methods=["POST"])
def create_user():
    pass

# get a specific user
@app.route("/api/users/<int:user_id>")
def get_user(user_id):
    pass

# delete a specific user
@app.route("/api/users/<int:user_id>", methods=["DELETE"])
def delete_user(user_id):
    pass

# get a user's favorite gifts
@app.route("/api/users/<int:user_id>/favorites/")
def get_favorites(user_id):
    pass

# add to a user's favorite gifts
@app.route("/api/users/<int:user_id>/favorites/<int:gift_id>/", methods=["POST"])
def add_favorite(user_id, gift_id):
    pass

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
