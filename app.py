# Step 1: Import Flask
from flask import Flask

# Step 2: Create an app
app = Flask(__name__)


# Step 3: Index route. This would be connected to the home page, I believe.
@app.route("/")
def home():

    return "App is running."

# This page would be a link on the home page that would take the user to the
# page displaying a heat map with state food desert data.
@app.route("/statedata")
def statedata():  
    
    return "I want to return JSON data... I think. I'm not sure how that then is made usable in a javascript file."


# Boiler plate flask app code
if __name__ == "__main__":
    app.run(debug=True)