# US-Food-Deserts
## *TEAM: Paul Hardy, John Levear, Brock Vriesman, and George Simon*

## Project Summary
This project seek to share knowledge to vistors through visualizations and data insights on food deserts. The hope is to answer the following series of questions:
* What are food deserts?
* Where are food deserts located in the US?
* Who lives in food deserts?
 
After giving the visitor a brief overview of food deserts, we will guide them to explore the topic of food deserts in an urban setting close to home in Oregon. One of our goals is to illustrate to the visitor that food deserts are not limited to rural areas and may be closer to home in an urban environment (specifically Multnomah County in Oregon) than they previously thought. At this point, the questions we want to be able to communicate to the visitor the answers to the following questions and display visualizations of possible highlights of *risk factors* in Multnomah County.
* What does a food desert look like in Multnomah County (Oregon)?
* Are there any data insights of interest that exist in Multnomah County?

### DATASETS
* [Food Desert Data](https://www.kaggle.com/tcrammond/food-access-and-food-deserts)
* [Vulnerability Risk Data - Portland, OR](https://gis-pdx.opendata.arcgis.com/datasets/vulnerability?geometry=-123.978%2C45.376%2C-121.365%2C45.713)

### DATA/PROJECT CONSTRAINTS
* 2010 Census Data

### PROJECT TASKS
* Data Sourcing/Research - TEAM
  * Identify files
* Data Cleaning (ETL) - JOHN, PAUL
  * Extract
  * Transform
  * Load (PostGreSQL)
* Preliminary Analysis - TEAM
  * US Data Insights - BROCK
  * Demographic Data in Multnomah - PAUL
  * Summary Tables at Multnomah - PAUL
* Front-End Website - GEORGE
  * HTML/CSS
  * Bootstrap 
* Back-End Website
  * Python Flask API - BROCK, JOHN
      * Flask CORS Module
      * Call data element
* Visualizations
  * Leaflet Map - JOHN
  * D3 State Chart - BROCK
  * US HighChart - GEORGE
  * Plotly Data Insights - PAUL
* Github Merge Manager - George
  * Environment/.txt Set-Up - PAUL
* Presentation - Team
* Final Analysis/Write Up - TEAM


#### Leaflet Map - Mult Co. Census Tracts Map

#### Requirements
* Postgres database with data imported from CSVs
* SQL query creating new table with pertinant information
* Flask app connecting to the Postres database
* GeoJSON file for Multnomah County census tract polygons
* Leaflet and Mapbox configuration for visualization

#### Description
This Leaflet map shows the prevalence of food deserts within Multnomah County, Oregon based on the percentage of the census tract population that is more than half of a mile away from a supermarket. 

#### Findings
Food deserts appeared to be further from the city center, but there were some census tracts with a higher percentage than the census tracts around it. Further analysis is required to understand what factors correlate with food deserts. 
One unexpected finding was that for some of the census tracts with a large percent of the population in a food desert, the median family income was significantly higher than other census tracts with a small percent of the population in a food desert. 

#### Final Product
Below is an image of the Leaflet map. It uses the Mapbox satelite street layer, which allows the user to zoom in far enough to see individual homes. Clicking on a census tract shows a popup with information about that census tract. 

![Leaflet Map](/resources/images/leaflet.png)




