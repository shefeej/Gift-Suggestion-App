from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

#association_table = db.Table(
#  'association',
#  db.Model.metadata,
#  db.Column('course_id', db.Integer, db.ForeignKey('course.id')),
#  db.Column('user_id', db.Integer, db.ForeignKey('user.id'))
#)

class Gift(db.Model):
  pass

class User(db.Model):
  __tablename__ = 'user'
  id = db.Column(db.Integer, primary_key=True)
  name = db.Column(db.String, nullable=False)
  #favorites = db.relationship('Gift', secondary=association_table, back_populates='users')

  def __init__(self, **kwargs):
    self.name = kwargs.get('name')
  
  def serialize(self):
    return {
      'id': self.id,
      'name': self.name,
      #'favorites': self.favorites
    }
