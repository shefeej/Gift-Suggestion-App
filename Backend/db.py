from flask_sqlalchemy import SQLAlchemy
import base64
import boto3
import datetime
from io import BytesIO
from mimetypes import guess_extension, guess_type
import os
from PIL import Image
import random
import re
import string

db = SQLAlchemy()

EXTENSIONS = ["png", "gif", "jpg", "jpeg"]
BASE_DIR = os.getcwd()
S3_BUCKET = "gift-suggestion-app"
S3_BASE_URL = f"https://{S3_BUCKET}.s3.us-east-2.amazonaws.com"

association_table = db.Table(
  'association',
  db.Model.metadata,
  db.Column('gift_id', db.Integer, db.ForeignKey('gift.id')),
  db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
)

class Gift(db.Model):
  __tablename__ = 'gift'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  price = db.Column(db.Float, nullable=False)
  age_min = db.Column(db.Integer, nullable=False)
  age_max = db.Column(db.Integer, nullable=False)
  occasion = db.Column(db.String, nullable=False)
  image_url = db.Column(db.String, nullable=False)
  # the users column shows which users have favorited this gift
  users = db.relationship('User', secondary=association_table, back_populates='favorites')

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')
    self.price = kwargs.get('price')
    self.age_min = kwargs.get('age_min')
    self.age_max = kwargs.get('age_max')
    self.occasion = kwargs.get('occasion')
    self.image_url = kwargs.get('image_url')

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'price': self.price,
      'age_min': self.age_min,
      'age_max': self.age_max,
      'occasion': self.occasion,
      'image_url': self.image_url,
      'users': self.users
    }
  def serialize_no_users(self):
    return {
        'id': self.id,
        'name': self.name,
        'price': self.price,
        'age_min': self.age_min,
        'age_max': self.age_max,
        'occasion': self.occasion,
        'image_url': self.image_url,
        }

class User(db.Model):
  __tablename__ = 'user'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  favorites = db.relationship('Gift', secondary=association_table, back_populates='users')

  def get_favorites(self):
    cursor = self.conn.execute("SELECT * FROM association;")
    favs = []
    for row in cursor:
      favs.append(
        {
          'user_id': row[0],
          'gift_id': row[1]
        }
      )
      return favs

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'favorites': list(g.serialize_no_users() for g in self.favorites)
    }

class GiftImage(db.Model):
    __tablename__ = "giftimage"

    id = db.Column(db.Integer, primary_key=True)
    base_url = db.Column(db.String, nullable=True)
    salt = db.Column(db.String, nullable=False)
    extension = db.Column(db.String, nullable=False)
    width = db.Column(db.Integer, nullable=False)
    height = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, nullable=False)

    def __init__(self, **kwargs):
        self.create(kwargs.get("image_data"))

    def serialize(self):
        return {
            "url": f"{self.base_url}/{self.salt}.{self.extension}",
            "created_at": str(self.created_at),
        }

    def get_url(self):
        return f"{self.base_url}/{self.salt}.{self.extension}"

    def create(self, image_data):
        try:
            ext = guess_extension(guess_type(image_data)[0])[1:]
            if ext not in EXTENSIONS:
                raise Exception(f"Extension {ext} not supported!")
            salt = "".join(
                random.SystemRandom().choice(
                    string.ascii_uppercase + string.digits
                )
                for _ in range(16)
            )
            img_str = re.sub("^data:image/.+;base64,","", image_data)
            img_data = base64.b64decode(img_str)
            img = Image.open(BytesIO(img_data))
            self.base_url = S3_BASE_URL
            self.salt = salt
            self.extension = ext
            self.width = img.width
            self.height = img.height
            self.created_at = datetime.datetime.now()

            img_filename = f"{salt}.{ext}"
            self.upload(img, img_filename)
        except Exception as e:
            print(f"Unable to create image due to {e}")

    def upload(self, img, img_filename):
        try:
            img_temploc = f"{BASE_DIR}/{img_filename}"
            img.save(img_temploc)
            s3_client = boto3.client("s3")
            s3_client.upload_file(img_temploc, S3_BUCKET, img_filename)
            s3_resource = boto3.resource("s3")
            object_acl = s3_resource.ObjectAcl(S3_BUCKET, img_filename)
            object_acl.put(ACL="public-read")
            os.remove(img_temploc)
        except Exception as e:
            print(f"Unable to upload image due to {e}")
