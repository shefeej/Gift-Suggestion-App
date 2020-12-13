from db import db
from db import Gift, User
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
@app.route("/api/gifts/")
def get_gifts():
    try:
        # Check if client has gift filters in body of request
        body = json.loads(request.data)
    except:
        # No filters on gifts
        return success_response([g.serialize() for g in Gift.query.all()])
    body_price_min = body.get('price_min', 0)
    body_price_max = body.get('price_max', 'all')
    body_occasion = body.get('occasion','all')
    body_age = body.get('age', 'all')
    # Check type of price filter
    if body_price_min != 0 and (not isinstance(body_price_min, float) and not isinstance(body_price_min, int)):
        return failure_response("price_min must be either a float, int, or 'all'.")
    if body_price_max != 'all' and (not isinstance(body_price_max, float) and not isinstance(body_price_max, int)):
        return failure_response("price_max must be either a float, int, or 'all'.")
    # Check type of occasion filter
    if body_occasion != 'all' and not isinstance(body_occasion, str):
        return failure_response("occasion must be a string or 'all'.")
    # Check type of age filter
    if body_age != 'all' and not isinstance(body_age, int):
        return failure_response("age must be an int or 'all'.")
    gift_list = [g.serialize() for g in Gift.query.all()]
    filtered_gift_list = []
    for gift in gift_list:
        gift_satisfies_filters = True
        # Check price filter
        if body_price_max != 'all' and (gift["price"] < body_price_min or gift["price"] > body_price_max):
            gift_satisfies_filters = False
        # Check occasion filter
        if body_occasion != 'all' and (not body_occasion in gift["occasion"]):
            gift_satisfies_filters = False
        # Check age filter
        if body_age != 'all' and (gift["age_min"] > body_age or gift["age_max"] < body_age):
            gift_satisfies_filters = False
        # If all filters are satisfied, add gift to filtered list
        if gift_satisfies_filters == True:
            filtered_gift_list.append(gift)
    # If list is empty, return failure_response
    if filtered_gift_list == []:
        return failure_response("No gifts found with those filters.")
    return success_response([g for g in filtered_gift_list])

# get a specific gift
@app.route("/api/gifts/<int:gift_id>/")
def get_gift(gift_id):
    gift = Gift.query.filter_by(id=gift_id).first()
    if gift is None:
        return failure_response('Gift not found!')
    return success_response(gift.serialize())

# create a new gift
@app.route("/api/gifts/", methods=["POST"])
def create_gift():
    body = json.loads(request.data)
    body_name = body.get('name')
    body_price = body.get('price')
    body_age_min = body.get('age_min')
    body_age_max = body.get('age_max')
    body_occasion = body.get('occasion')
    body_image_url = body.get('image_url', 'https://rushcountyfoundation.org/wp-content/uploads/2015/12/gift-06.jpg')
    if None in [body_name, body_price, body_age_min, body_age_max, body_occasion]:
        return failure_response("Please provide gift name, price, age_min, age_max, and occasion.", 400)
    new_gift = Gift(
        name=body_name,
        price=body_price,
        age_min=body_age_min,
        age_max=body_age_max,
        occasion=body_occasion,
        #image_url=body_image_url
    )
    db.session.add(new_gift)
    db.session.commit()
    return success_response(new_gift.serialize(), 201)

# delete a specific gift
@app.route("/api/gifts/<int:gift_id>/", methods=["DELETE"])
def delete_gift(gift_id):
    gift = Gift.query.filter_by(id=gift_id).first()
    if gift is None:
        return failure_response('Gift not found!')
    db.session.delete(gift)
    db.session.commit()
    return success_response(gift.serialize())

# create a new user
@app.route("/api/users/", methods=["POST"])
def create_user():
    body = json.loads(request.data)
    u = User(name=body.get("name"))
    db.session.add(u)
    db.session.commit()
    return success_response(u.serialize(), 201)

# get a specific user
@app.route("/api/users/<int:user_id>/")
def get_user(user_id):
    u = User.query.filter_by(id=user_id).first()
    if u is None:
        return failure_response("User not found!")
    return success_response(u.serialize())

# delete a specific user
@app.route("/api/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    u = User.query.filter_by(id=user_id).first()
    if u is None:
        return failure_response("User not found!")
    db.session.delete(u)
    db.session.commit()
    return success_response(u.serialize())

# get a user's favorite gifts
@app.route("/api/users/<int:user_id>/favorites/")
def get_favorites(user_id):
    u = User.query.filter_by(id=user_id).first()
    if u is None:
        return failure_response("User not found!")
    f = u.get("favorites")
    return success_response(f)

# add to a user's favorite gifts
@app.route("/api/users/<int:user_id>/favorites/<int:gift_id>/", methods=["POST"])
def add_favorite(user_id, gift_id):
    gift = Gift.query.filter_by(id=gift_id).first()
    if gift is None:
        return failure_response('Gift not found!')
    u = User.query.filter_by(id=user_id).first()
    if u is None:
        return failure_response("User not found!")
    u.favorites.append(gift)
    db.session.commit()
    return success_response(u)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
