#create table in postgresql

from sqlalchemy import Boolean, Column, ForeignKey, Integer,String
from database import Base

#create table

class People(Base):
    __tablename__ = "people"
    
    #id is PK, increase performances in postgreSQL when we r querying for an specific id
    id = Column(Integer,primary_key=True, index=True)
    name = Column(String, index=True)
    age = Column(Integer)
    sex = Column(String)