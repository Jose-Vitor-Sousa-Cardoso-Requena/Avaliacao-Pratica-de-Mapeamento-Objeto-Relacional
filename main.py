from sqlalchemy.orm import declarative_base, relationship
from sqlalchemy import Column, Integer, String, create_engine, ForeignKey, Table
from sqlalchemy_utils import database_exists, create_database
URL="mysql+mysqlconnector://root:root@127.0.0.1:3306/Jose3Info"
engine = create_engine(url=URL)
Base = declarative_base()
if not database_exists(engine.url):
    create_database(engine.url)
    print('Database Criado;')

segue = Table('segue',
    Base.metadata,
    Column('id_user', Integer, ForeignKey('user.id_user'), primary_key=True),
    Column('id_friend', Integer, ForeignKey('user.id_user'), primary_key=True)
)
membro = Table('membro_time',
    Base.metadata,
    Column('id_user', Integer, ForeignKey('user.id_user'), primary_key=True),
    Column('id_time', Integer, ForeignKey('time.id_time'), primary_key=True)
)
time_campeonato = Table('time_campeonato',
    Base.metadata,
    Column('id_campeonato', Integer, ForeignKey('campeonato.id_campeonato'), primary_key=True),
    Column('id_time', Integer, ForeignKey('time.id_time'), primary_key=True)
)
mensagem = Table('mensagem',
    Base.metadata,
    Column('id_mensagem', Integer, primary_key=True),
    Column('id_mandou', Integer, ForeignKey('user.id_user')),
    Column('id_recebe', Integer, ForeignKey('user.id_user')),
    Column('mensagem', String(200), nullable= False)
)
mensagem_time = Table('mensagem_time',
    Base.metadata,
    Column('id_mensagem', Integer, primary_key=True),
    Column('id_mandou', Integer, ForeignKey('user.id_user')),
    Column('id_time', Integer, ForeignKey('time.id_time')),
    Column('mensagem', String(200), nullable= False)
)
role = Table('role_jogadas',
    Base.metadata,
    Column('id_conta', Integer, ForeignKey('conta_valorant.id_conta'), primary_key=True),
    Column('id_role', Integer, ForeignKey('role_valorant.id_role'), primary_key=True)
)
class User(Base):
    __tablename__ = "user"
    id_user = Column(Integer, primary_key=True)
    login = Column(String(150), nullable=False)
    senha = Column(String(150), nullable=False)
    seguindo = relationship('user', secondary=segue, backref='seguidores')
    mandou = relationship('user', secondary=mensagem, backref='recebeu')
    time_mandou = relationship('time', secondary=mensagem_time, backref='time_recebeu')
    info = relationship('info_user', backref='user', uselist=False)

class info_user(Base):
    __tablename__='info_user'
    id_user = Column(Integer, ForeignKey('user.id_user'), primary_key=True)
    nome = Column(String(150), nullable=False)
    idade = Column(Integer, nullable=False)
    email = Column(String(150), nullable=False)
    bio = Column(String(200), nullable=True)
    user = relationship(Integer, ForeignKey('user.id_user'), uselist=False)

class Conta_valorant(Base):
    __tablename__='conta_valorant'
    id_conta = Column(Integer, primary_key=True)
    id_user = Column(Integer, ForeignKey('user.id_user'))
    nome = Column(String(150), nullable=False)
    tag = Column(String(150), nullable=False)
    roles = relationship('role_valorant', secondary=role, backref='joga')

class role_valorant(Base):
    __tablename__='role_valorant'
    id_role = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=False)

class Time(Base):
    __tablename__ = 'time'
    id_time = Column(Integer, primary_key=True)
    id_criador = Column(Integer, ForeignKey('user.id_user'))
    nome = Column(String(150), nullable=False)

class Campeonato(Base):
    __tablename__= 'campeonato'
    id_campeonato = Column(Integer, primary_key=True)
    id_creator = Column(Integer, ForeignKey('user.id_user'))
    id_nome = Column(String(150), nullable=False)
 
Base.metadata.create_all(engine)