from fastapi import FastAPI, HTTPException, Depends
from models import Person
from typing import List, Annotated
import database_model
from database import engine, SessionLocal
from sqlalchemy.orm import Session #session from database

app = FastAPI()
#create all of the tables in postgres
database_model.Base.metadata.create_all(bind=engine) 
#temporary database
people = []


#create connection to database
def get_db():
    db = SessionLocal()
    try:
        #try 
        yield db
    finally:
        db.close()

db_dependency = Annotated[Session, Depends(get_db)]
# db_dependency is of type Annotated[Session, Depends(get_db)], which means it's annotated with metadata. The metadata is that it's a dependency on the Session type, and the dependency is satisfied by the get_db function.
# In FastAPI, dependencies like Depends(get_db) can be used to manage the lifecycle of dependencies, such as opening and closing database connections. When a route or function that depends on db_dependency is called, FastAPI will automatically execute get_db to get a database session, and it will make sure that the session is properly closed when the request is finished. This helps in managing resources efficiently and avoiding potential issues related to unclosed database connections.

@app.post('/api/create_person')
async def create_person(person : Person, db : db_dependency):
    
    # Check if a person with the specified ID already exists
    existing_person = db.query(database_model.People).filter(database_model.People.id == person.id).first()

    if existing_person:
        raise HTTPException(status_code=400, detail='Person with the same ID already exists')
    

    db_person = database_model.People(id=person.id, name= person.name, age=person.age, sex= person.sex)
    db.add(db_person)
    db.commit()
    db.refresh(db_person)
    # Refreshing ensures that the db_person object in your application has the correct state as it exists in the database.
    
    # In summary, db.refresh(db_person) is a way to synchronize the state of the local object in your application with the state of the object as it exists in the database after a commit.


@app.get('/api/people')
async def get_people(db : db_dependency):
    people = db.query(database_model.People).all()
    return {"people" : people}


@app.get('/api/people/{person_id}')
async def get_person(person_id : int, db : db_dependency):
    result = db.query(database_model.People).filter(database_model.People.id == person_id).first() #first occurance
    #if result not found, raise an exception
    if not result:
        raise HTTPException(status_code=404, detail='Person not found')
    #if it found
    return {"person" : result}


#update person info
@app.put('/api/update_or_create_person/{person_id}')
async def update_person(person_id : int, person_obj : Person, db : db_dependency):
    db_person = db.query(database_model.People).filter(database_model.People.id == person_id).first()
    
    if not db_person:
        db_person = database_model.People(id=person_obj.id, name= person_obj.name, age=person_obj.age, sex= person_obj.sex)
        db.add(db_person)
    else:
        db_person.name = person_obj.name
        db_person.age = person_obj.age
        db_person.sex = person_obj.sex
    db.commit()
    db.refresh(db_person)
    return {"updated_person" : db_person}
        
#delete person
@app.delete('/api/people/{person_id}')
async def delete_person(person_id : int, db : db_dependency):
    person = db.query(database_model.People).filter(database_model.People.id == person_id).first()
    
    if not person:
        raise HTTPException(status_code=404, detail='Person not found')
    person_to_delete = person
    db.delete(person)
    db.commit()
    
    return {"person_deleted": person_to_delete}