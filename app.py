# Step 1: Import Libraries
import numpy as np
from flask import Flask, render_template, jsonify
from flask_cors import CORS
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine

# Step 2: Create an app
app = Flask(__name__)

CORS(app)

# mult_vul_data = [{
#     "OBJECTID": 1,
#     "STATE": 41,
#     "COUNTY": "051",
#     "TRACT": "003100"
# },
# {
#     "OBJECTID": 2,
#     "STATE": 41,
#     "COUNTY": "051",
#     "TRACT": "004602"
# }]

# Step 3: Create engine directed at PostGreSQL Database
engine = create_engine("postgresql://localhost/food_deserts")

Base = automap_base()
Base.prepare(engine, reflect=True)

nationaldata = Base.classes.national_data
mult_data = Base.classes.multnomah_data

# Step 4: Create routes including a root level and API call routes
@app.route("/")
def home():

    # In the root level route, link to API call routes
    return (
        f"<a href='/api/v1.0/nationaldata'>National Data</a><br/>"
        f"<a href='/api/v1.0/multdata'>Multnomah County, Oregon Data</a><br/>"
    )

    # Added render_template to root route
    # return render_template('basic.html')

@app.route("/api/v1.0/nationaldata")
def statedata():  
    
    session = Session(engine)

    results = session.query(nationaldata)

    session.close()

    all_results = list(np.ravel(results))

    return jsonify(all_results)

@app.route("/api/v1.0/multdata")
def multdata():

    session = Session(engine)

    results = session.query(mult_data)

    session.close()

    all_results = list(np.ravel(results))

    return jsonify(all_results)


# Boiler plate flask app code
if __name__ == "__main__":
    app.run(debug=True)