# Instructions for Data Base Set-Up

## Clone Repo and Set Up Data
* Clone Repo
* Create Database in PostgreSQL
* Create Base Tables in Database
* Import Data
* Run Addtional CREATE TABLE Queries

#### Steps
* Clone Repo onto machine
* Create Database in PostgreSQL
    * Open pgAdmin on local machine
        * Create database and name it "food_deserts"
* In Repo, open resources/schema directory
    1) Copy SQL query inside "data_food_deserts.sql"
    2) Open query tool in food_deserts database
    3) Paste code and run query
    * Repeat steps 1-3 for the query in "data_vulnerability_mult.sql" file
    * Repeat steps 1-3 for the query in "nat_map_json.sql" file
* After base tables have been created, right click on the "data_food_deserts" table and begin the Import data process
    1) In Import Wizard, slide Import/Export switch to "Import"
    2) Search for file: "YOUR REPO NAME/resources/data/data_food_deserts.csv"
    3) Under "Miscellaneous" in Wizard, slide "Header"switch to "Yes"
    4) Select "," as the Delimeter
    5) Click "OK"
    * Repeat steps 1-5 of import process for "data_vulnerability_multi" table using the file "YOUR REPO NAME/resources/data/data_vulnerability_mult.csv"
    * Repeat steps 1-5 of import process for "nat_map_json" table using the file "YOUR REPO NAME/resources/data/nat_map_data.csv"
* Navigate in Repo to resources/schema
    * Open "queries.sql" file and copy all (click into file and on keyboard, click ctrl + A, ctrl + C)
    * Open new query tool in "food_deserts" database, paste and run
* Your tables should now all be created and populated. You should have the following tables in your PostgreSQL - food_deserts database:
    * data_food_deserts
    * data_vulnerability_multi
    * multnomah_data
    * multnomah_summary_data
    * nat_stat_table
    * national_data


## Adding Config Files
* Add Config.js
* Add Config.py

#### Steps
* Navigate to static/js directory and create a new file called "config.js"
    * Inside the file, write the following: API_Key = ""
    * If you have a mapbox.com account, paste your token between the quotes
    * If you do not have a mapbox.com account, create one (it's free) and access your token on the account page and paste between the quotes
    * Save file
* Navigate back to your Repo root and create a new file called "config.py"
    * Inside the file, write the following: PW = ""
    * Within the quotes, enter your PostgreSQL password
    * Save file


## Launch App.py

#### Steps
* Navigate to the root of the directory
* Type "python app.py" into your terminal
* Hold Ctrl and click the URL in the terminal response that will look like this: "* Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)"
    * If that doesn't work, copy and paste the underlined portion into your browser to run
* After completing steps, you should land on our website