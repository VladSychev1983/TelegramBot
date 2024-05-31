import sqlalchemy as sq
from sqlalchemy.orm import declarative_base, relationship
import datetime

Base = declarative_base()

class English_Words(Base):
    __tablename__ = "english_words"
    word_id = sq.Column(sq.Integer, primary_key=True, autoincrement="auto")
    word = sq.Column(sq.String(length=255), unique=True, nullable=False)

class Russian_Words(Base):
    __tablename__ = "russian_words"
    word_id = sq.Column(sq.Integer, primary_key=True, autoincrement="auto")
    word = sq.Column(sq.String(length=255), unique=True, nullable=False)

class Translation(Base):
    __tablename__ = "translation"
    id = sq.Column(sq.Integer, primary_key=True, autoincrement="auto")
    en_word_id = sq.Column(sq.Integer, sq.ForeignKey(English_Words.word_id), nullable=False)
    ru_word_id = sq.Column(sq.Integer, sq.ForeignKey(Russian_Words.word_id), nullable=False)
    engilsh_words = relationship(English_Words, backref="translations")
    russian_words = relationship(Russian_Words, backref="translations")

class Chats(Base):
    __tablename__ = "chats"
    id = sq.Column(sq.Integer, primary_key=True, autoincrement="auto")
    chat_id = sq.Column(sq.Integer, unique=True, nullable=False)

class History(Base):
    __tablename__ = "history"
    id = sq.Column(sq.Integer, primary_key=True, autoincrement="auto")
    word_id = sq.Column(sq.Integer, sq.ForeignKey(Russian_Words.word_id), nullable=False)
    chat_id = sq.Column(sq.Integer, sq.ForeignKey(Chats.chat_id), nullable=False)
    answer = sq.Column(sq.Boolean, default=False)
    count_times = sq.Column(sq.Integer, nullable=True)
    created_at = sq.Column(sq.DateTime, nullable=False, default=datetime.datetime.now)
    russian_words = relationship(Russian_Words, backref="history")
    chats = relationship(Chats, backref="history")

class User_Words(Base):
    __tablename__ = "user_words"
    id = sq.Column(sq.Integer, primary_key=True, autoincrement="auto")
    chat_id = sq.Column(sq.Integer, sq.ForeignKey(Chats.chat_id), nullable=False)
    ru_word = sq.Column(sq.String(length=255), unique=True, nullable=False)
    en_word = sq.Column(sq.String(length=255), unique=True, nullable=False)
    created_at = sq.Column(sq.DateTime, nullable=False, default=datetime.datetime.now)
    chats = relationship(Chats, backref="user_words")

def create_talbes(engine):
    Base.metadata.create_all(engine)
