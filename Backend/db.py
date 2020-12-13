from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

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
  #image_url = db.Column(db.String, nullable=False)
  # the users column shows which users have favorited this gift
  users = db.relationship('User', secondary=association_table, back_populates='favorites')

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')
    self.price = kwargs.get('price')
    self.age_min = kwargs.get('age_min')
    self.age_max = kwargs.get('age_max')
    self.occasion = kwargs.get('occasion')
    #self.image_url = kwargs.get('image_url')

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'price': self.price,
      'age_min': self.age_min,
      'age_max': self.age_max,
      'occasion': self.occasion,
      #'image_url': self.image_url,
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
        #'image_url': self.image_url,
        }

class User(db.Model):
  __tablename__ = 'user'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  favorites = db.relationship('Gift', secondary=association_table, back_populates='users')

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'favorites': list(g.serialize_no_users() for g in self.favorites)
    }
