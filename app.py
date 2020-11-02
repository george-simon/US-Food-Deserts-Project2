# Step 1: Import Libraries
from config import PW
import numpy as np
from flask import Flask, render_template, jsonify
from flask_cors import CORS
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session, sessionmaker
from sqlalchemy import create_engine

# Step 2: Create an app
app = Flask(__name__)

CORS(app)

password = PW
# Step 3: Create engine directed at PostGreSQL Database
engine = create_engine(f"postgresql://postgres:{password}@localhost:5432/food_deserts")


Base = automap_base()
Base.prepare(engine, reflect=True)

print(Base.classes.keys())


# Save references to the tables in the food_deserts database
national = Base.classes.national_data
# I'm pulling the data_food_deserts table because the national_data table does not have a primary key yet
multnomah = Base.classes.multnomah_data
# Adding table of summarized values for Multnomah county
multsum = Base.classes.multnomah_summary_data

# Step 4: Create routes including a root level and API call routes
@app.route("/")
def home():

    # In the root level route, link to API call routes
    # return (
    #     f"<a href='/api/v1.0/natdata'>National Data</a><br/>"
    #     f"<a href='/api/v1.0/multdata'>Multnomah County, Oregon Data</a><br/>"
    # )

    # Added render_template to root route
    return render_template('index.html')

@app.route("/api/v1.0/natdata")
def natdata():  
    
    session = Session(engine)

    results = session.query(national.state, national.county, national.total_population, national.percent_urban, national.percent_low_access).all()
    # , national.percent_urban, national.percent_low_access -- need to be integers

    session.close()

    nat_results = []

    for item in results:
        item_dict = {}
        item_dict["state"] = item[0]
        item_dict["county"] = item[1]
        item_dict["total_population"] = item[2]
        item_dict["percent_urban"] = item[3]
        item_dict["percent_low_access"] = item[4]
        nat_results.append(item_dict)

    return jsonify(nat_results)

@app.route("/api/v1.0/multdata")
def multdata():

    session = Session(engine)

    results = session.query(multnomah.census_tract, multnomah.population_2010, multnomah.population_low_income, 
                            multnomah.percent_poverty, multnomah.med_fam_income, multnomah.house_unit_no_vehicle, 
                            multnomah.population_low_access_half, multnomah.percent_low_access_half,
                            multnomah.population_low_access_1, multnomah.percent_low_access_1).all()
    # Was not able to load multnomah.percent_poverty it contains a decimal. Need to be integers.
    # , multnomah.population_low_access_half, multnomah.population_low_access_1

    session.close()

    mult_results = []

    for item in results:
        item_dict = {}
        item_dict["census_tract"] = item[0]
        item_dict["population_2010"] = item[1]
        item_dict["population_low_income"] = item[2]
        item_dict["percent_poverty"] = item[3]
        item_dict["med_fam_income"] = item[4]
        item_dict["house_unit_no_vehicle"] = item[5]
        item_dict["population_low_access_half"] = item[6]
        item_dict["percent_low_access_half"] = item[7]
        item_dict["population_low_access_1"] = item[8]
        item_dict["percent_low_access_1"] = item[9]
        mult_results.append(item_dict)

    return jsonify(mult_results)

@app.route("/api/v1.0/multsummarydata")
def multsumdata():

    session = Session(engine)

    results = session.query(
            multsum.county, 
            multsum.sum_population_2010, 
            multsum.sum_population_low_income, 
            multsum.median_percent_poverty, 
            multsum.median_family_income, 
            multsum.sum_house_unit_no_vehicle,
            multsum.sum_population_low_access_half,
            multsum.sum_population_low_access_1,
            multsum.percent_renters,
            multsum.percent_households_of_color,
            multsum.percent_no_bachlrs,
            multsum.percent_households_lessthan_80pcnt_of_mfi_score,
            multsum.mean_risk_renters,
            multsum.mean_risk_households_of_color,
            multsum.mean_risk_over_25_wo_bachlrs,
            multsum. mean_risk_with_lessthan_80pcnt_of_mfi_score,
            multsum.mean_risk_factor            
            ).all()
  
    session.close()

    multsum_results = []

    for item in results:
        item_dict = {}
        item_dict["county"] = item[0]
        item_dict["sum_population_2010"] = item[1]
        item_dict["sum_population_low_income"] = item[2]
        item_dict["median_percent_poverty"] = item[3]
        item_dict["median_family_income"] = item[4]
        item_dict["sum_house_unit_no_vehicle"] = item[5]
        item_dict["sum_population_low_access_half"] = item[6]
        item_dict["sum_population_low_access_1"] = item[7]
        item_dict["percent_renters"] = item[8]
        item_dict["percent_households_of_color"] = item[9]
        item_dict["percent_no_bachlrs"] = item[10]
        item_dict["percent_households_lessthan_80pcnt_of_mfi_score"] = item[11]
        item_dict["mean_risk_renters"] = item[12]
        item_dict["mean_risk_households_of_color"] = item[13]
        item_dict["mean_risk_over_25_wo_bachlrs"] = item[14]
        item_dict["mean_risk_with_lessthan_80pcnt_of_mfi_score"] = item[15]
        item_dict["mean_risk_factor"] = item[16]            
        multsum_results.append(item_dict)

    return jsonify(multsum_results)

# Boiler plate flask app code
if __name__ == "__main__":
    app.run(debug=True)