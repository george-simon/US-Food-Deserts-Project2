# Step 1: Import Flask
from flask import Flask

# Step 2: Create an app
app = Flask(__name__)


# Create engine
# Does it work to point the create_engine function at a .csv?
# engine = create_engine("static/data/data_food_deserts_lookup.csv")

# Step 3: Index route. This would be connected to the home page, I believe.
@app.route("/")
def home():

    return "App is running."

# This page would be a link on the home page that would take the user to the
# page displaying a heat map with state food desert data.
@app.route("/statedata")
def statedata():  
    
    return "I want to return JSON data... I think. I'm not sure how that then is made usable in a javascript file."

@app.route("/api/v1.0/multdata")
def multdata():
    # I know that for an API, a session needs to be created that is using the "engine",
    # but I don't know how to point that create_engine function to our .csv's...
    # session = Session(engine)

    # Is this all that's needed?
    return render_template('basic.html')

# Boiler plate flask app code
if __name__ == "__main__":
    app.run(debug=True)