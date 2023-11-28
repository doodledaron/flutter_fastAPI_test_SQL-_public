from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

#url to our database
#postgres is username could be found using SELECT * FROM pg_catalog.pg_user;in the query tool of our database
#daron2014 is user password
URL_database = 'postgresql://postgres:daron2014@localhost:5432/test_postgresql'
#The format of the URL is 'postgresql://username:password@host:port/database'

engine = create_engine(URL_database)

#provides a "workspace" for your objects to be loaded and persisted
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
#bind parameter is set to the engine, indicating that this session will use the specified database engine. autocommit and autoflush are set to False, which means that the session won't automatically commit changes to the database and won't automatically flush changes to the database, giving you more control over when these operations occur.

Base = declarative_base()

