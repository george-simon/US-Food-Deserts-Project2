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


# Project Write-Up

## Back-End Development
______________________________

#### Requirements
* PostgreSQL Database - PgAdmin4
  * [Download PgAdmin4](https://www.pgadmin.org/download/)
* Set-up working environment

#### Instructions for Database Set-Up
  * [Link to instructions.md](instructions.md)

#### Environment Set-Up Utilizing GitBash
Assuming you have already cloned the project repo, and are in repo folder (main) in gitbash. Run the following commands.
```
git pull origin main
conda create --name project2 python=3.6
conda activate project2
pip install -r requirements.txt
pip freeze  (to verify that what you have installed matches what's listed in requirements.txt)
```
Once the above is complete, just be sure you "conda activate project2" when working on this project.

## Front-End Development
______________________________

#### Requirements
* Downloaded free bootstrap template from *startbootstrap*
  * [Stylish-portfolio Download](https://startbootstrap.com/themes/stylish-portfolio/)
* Team section elements utilized from *bootstrapmade* 
  * [BizPage Demo Download](https://bootstrapmade.com/demo/BizPage/)

#### Description
For the creation of the front-end webpage the focus was to keep the visitors gaze on the story + questions. To do this a responsive bootstrap webpage was chosen along with elements and design inspiration were taken from a variety of webpages. Below is a list of the goals:
* Simplicity
* Professional
* Focus Kept on the Visualizations + Data Insights
* Gorgeous Design & Theme

#### Inspiration
The below image is a show case of some of the webpages that inspired the final design.
![Inspiration Canvas](/resources/images/web-inspiration.png)

#### Final Product
The below image is show casing the simple landing page with the navigation 'burger' in the top right selected to see the different sections.
Again the goal was to draw in the vistor and that was to be with the question "What is a Food Desert?" and a possible button to push to 'find out more' or scroll.
* Note: The website is just a single webpage. the navigation options to the right allow the user to jump to each section
![Landing Page](/resources/images/webpage-1.png)

The image below highlights the defination of a food desert. Again still drawing in the user as they scroll more towards the interactive visualizations and graphs.
* *See Visualization section for addtional info on the graphs utilized*
![Defination](/resources/images/webpage-2.PNG)
* Additional data insights as analyzed by Brock
![US Food Desert Facts](/resources/images/webpage-3.PNG)
* Team section complete with hover capability that pops up links to the teammates Github & Linkedin profile.
![Team Highlight](/resources/images/webpage-4.png)



## Visualizations
______________________________
<!-- if you plan on multiple sections -->
### Highcharts - US County Map

#### Requirements
* Template taken from:
  * [Highcharts US Counties](https://www.highcharts.com/demo/maps/us-counties)
* Data inputted needs to be formatted correctly
  * Jupyter Notebook
  * Postgres Query Tool

#### Description
The highcharts code allows the user to plug in a responsive chart the has many built in capabilities.
* Hover ability with popup insights
* Outlines for state & counties as taken from highchart
* Color key 
* Zoom feature
* Export an image, svg
* Etc.

#### Implementation
Now although this comes with a lot of features there were a lot of issues to have the map show up and figure out how to utilize it.
The scripts taken for the index.html and their placement on the page are *KEY*. Another constraint the user should pay attention to us how to plug in your own data to the map. The map is set up in a way that it needs to be fed a format of json. Below is an explantion overview of how this was completed in our project.

#### Highcharts Data Formatting
After some intensive road blocks and hours spent analyzing how the highcharts county map ingested data the following highcharts forum [Highcharts US Counties](https://www.highcharts.com/forum/viewtopic.php?t=34910).

This forum outlines that the high chart US County Map needs to take data in a specific json array. With the data the only edit item I wanted to change was the value column. Editing from unemployment percent to food desert percent. See code block:
```
{
        "code": "us-id-067",
        "name": "Minidoka County, ID",
        "value": XXXX  <=============================== Copy your data
    }, 
```
* Note: An alternative would be deep diving into editing highcharts.

To accomplish this Brock lending some skills in running a massive SQL querry to format the food desert data set to mirror the format structure highcharts needed.
This mirrored food desert data was than brought into a jupyter notebook (*nat.map.ipynb*). The data was than merged with a working set taken from highcharts unemployment rate json file. The data was than cleaned, exported, and uploaded to the postgres database.

#### Final Product
Below is a image of the final product *color scheme* edited.
* Note: Alaska and Louisiana didn't flow in
![Highcharts Map](/resources/images/highchart.PNG)


### National Facts and State Scatterplot

#### Description
* For national facts, a Postgres database was used to query and analyize data from data_food_deserts.csv file containing 2010 US Census Data
  * Hard-coded facts into HTML file and styled using CSS
* Using Postgres, I grouped census tracts by state, added CASE statements to include State abbreviations to dataset, set a flask app route to call the nat_stat_table from Postgres
  * Using D3, created a scatterplot comparing percent of state's consituents living in food fesert census tract by state median income

#### Findings
At the national level, in 2010, nearly 40M people in the US were considered to be living in a food desert. That is about 13% of the 2010 US population. White constituents were 10% less likely than average to be living in a food desert, Black constituents were 10% more likely, Hispanic constituents were 4% more likely and Asian constituents were 3% less likely to be living in a food desert. At the state level, as displayed in the scatterplot chart, there was an inverse relationship between the % of constiuents living in food desert census tracts and the state's median income.

![State Scatterplot](/resources/images/statescatterplot.png)

#### Final Thoughts
* There was a substaintial amount of effort expended to get the flask app up and running. It took almost a week and a half to make progress enough to get data flowing from the SQL tables we had built in Postgres into our Javascript staging area. By the time we were able to console.log the data into the HTML, there was a realization that the tables we had originally set up to feed charts were not exactly providing the correct data. Each person in the group ended up having to create additional SQL tables (as evidenced by the long list of instructions to set up our final Postgres environment), that the final analysis and visualization, for the "National Facts and State Scatterplot" section were not exactly what I would have wanted to display.
* It felt like we were having some success with Git, but by our final series of pull requests, some of the HTML code had been overwritten and the final product was not exatly what we had intended it to be.


### Leaflet Map - Mult Co. Census Tracts Map

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

### Plotly Plots - Multnomah County Population and Risk Demographics (2 plots)

#### Requirements
* Postgres database with data imported from CSVs
* SQL queries used to summarize data from base tables and store in a summary table for quick access.
* Flask app route dedicated to the Postres database for summary data.
* Data accessed by plots.js to generate both charts. 

#### Description

#### Plot on Left - "Summary statistics of population impacted by reduced access to healthy food in Multnomah county":
The data in this plot is based on:
* Data from the Economic Research Service (ERS) 
* The U.S Department of Agriculture (USDA).   
* Census Data from 2010 with updates occurring as recently as May 2020.

#### Findings
* First Bar: Represents the total population represented in the census.
* Second Bar: Represents the population count that is beyond 1 mile from a supermarket.
* Third Bar: Represents the population count that is beyond ½ a mile from a supermarket.
* Fourth Bar: Red: Represents the number of homes with no vehicles.
* Fifth Bar: Red: Represents number of homes with no vehicle.

So, the second and third bars reveal that in Multnomah county, close to half the population is beyond a half mile from a supermarket, but  less than 10% of the population is beyond 1 mile from a supermarket. So, overall there is a high level of avvess to spermarkets for the majority of the population, which is what we would expect for a urban county.

#### Plot on Right - "Groups vulnerable to changing economic conditions for Multnomah county"

The data in this plot is based on:
* Data from the Bureau of Planning and Sustainability
* Published in 2014

#### Findings

The data used for this plot is is referred to as “Vulnerability Risk Analysis” and is a tool that identifies census tracts that are vulnerable to changing economic conditions.  These are tracts that have higher than citywide average populations with risk factors for vulnerability to economic changing conditions.  These risk factors include:
* Renters rather than homeowners
* Communities of color.
* Populations that lack a college degree.
* Populations with lower incomes.

In summary, based on the data, the percentages of populations in census tracts that have higher than citywide average populations with risk factors for vulnerability to economic changing conditions is quite high in Multnomah county with some census tracts at the maximum risk levels.  Overall mean risk levels are at 2 out of 4 for each risk category, as this plot summarizes all census tracts.  The overall mean risk score at 8 out of 12 is 66% of the way to the maximum risk level (12).

#### Final Product
Below in an image of both plots that appear in the section titled "More Visualizations Multnomah County".  

![Plotly plots](/resources/images/barplots.PNG)

