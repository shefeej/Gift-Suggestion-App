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
  occasion = db.Column(db.String, nullable=False)
  # the users column shows which users have favorited this gift
  users = db.relationship('User', secondary=association_table, back_populates='favorites')

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')
    self.price = kwargs.get('price')
    self.occasion = kwargs.get('occasion')

  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      'price': self.price,
      'occasion': self.occasion,
      'users': self.users
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
      'favorites': self.favorites
    }
