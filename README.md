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

## Title-as taken from the project tasks
______________________________
<!-- if you plan on multiple sections -->
#### Sub-Title

#### Requirements
* None
* For example: config.py
* Download blah blah

#### Description
<!-- Try to keep this highlevel and short -->
blah blah

-content-goes-here-
<!-- Below is code for inputting a image. All images will be saved in resources/images folder -->
![Images Link Example](/resources/images/<file>)


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
#### Highcharts - US County Map

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



