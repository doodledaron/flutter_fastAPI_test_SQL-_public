# project

A new Flutter project.

## Getting Started
RUN THE FASTAPI SERVER
1. make sure to install python on your PC
2. (in server file) activate virtual environment 'path\to\myenv\Scripts\activate.bat'
3. (in server file)install fastapi and server 'pip install fastapi' and 'pip install "uvicorn[standard]"'
4. (in server file) type 'uvicorn main:app --reload --host 0.0.0.0 --port 8000' to make it listen on all available network interfaces

in home_services.dart, REMEMBER to change ipAddress to your iPAddress

FILE STRUCTURE:
1. models -- Person object
2. screens -- forms for POST and PUT request
3. home_services -- a file to connect to our backend

While creating a user(either put or post request), rememeber that id int, name String, age int, sex String
