# Data Analisis for Meal Recommendation

## Commands:
```
cabal run
```

## Output
```
Current Temperature: 22.2
Preferred cuisines: Asian, Mediterranean
Preferred Foods: [Soup,Stew,Hot Drinks]
```
> Note: Check `data/GoogleLLM.json` for final predicted foods.
```
{
  "candidates": [
    {
      "content": {
        "parts": [
          {
            "text": "**Asian**\n\n**Soup:**\n* Tom Yum Goon (Thai coconut soup with shrimp)\n* Pho (Vietnamese beef noodle soup)\n* Miso Shiru (Japanese soybean paste soup)\n* Hot and Sour Soup (Chinese soup with tofu and pork)\n\n**Stew:**\n* Beef Rendang (Indonesian beef stew)\n* Korean Beef Bulgogi Stew\n* Thai Red Curry Stew\n* Massaman Chicken Curry (Thai stew)\n\n**Hot Drinks:**\n* Masala Chai (Indian spiced tea)\n* Ginger Tea (Chinese tea with ginger)\n* Turmeric Milk (Indian bedtime beverage)\n* Vietnamese Egg Coffee\n\n**Mediterranean**\n\n**Soup:**\n* Avgolemono (Greek egg-lemon soup)\n* Gazpacho (Spanish cold tomato soup)\n* Bouillabaisse (French fish stew)\n* Ribollita (Italian Tuscan bread and vegetable soup)\n\n**Stew:**\n* Moussaka (Greek eggplant and ground beef casserole)\n* Paella (Spanish rice dish with seafood and vegetables)\n* Tagine (North African slow-cooked stew)\n* Italian Beef Stew with Polenta\n\n**Hot Drinks:**\n* Turkish Coffee (strong, unfiltered coffee)\n* Moroccan Mint Tea\n* Arabic Coffee (spiced with cardamom)\n* Salep (Turkish hot drink made with orchid root)"
          }
        ],
        "role": "model"
      },
      "finishReason": "STOP",
      "index": 0,
      "safetyRatings": [
        {
          "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HATE_SPEECH",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_HARASSMENT",
          "probability": "NEGLIGIBLE"
        },
        {
          "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
          "probability": "NEGLIGIBLE"
        }
      ]
    }
  ],
  "usageMetadata": {
    "promptTokenCount": 15,
    "candidatesTokenCount": 281,
    "totalTokenCount": 296
  }
}

```

> The complete project has been written in Haskell.
```
Basic Overview

Haskell

Haskell is a general-purpose, statically typed, purely functional programming
language with type inference and lazy evaluation.
Haskell&#39;s main implementation is the Glasgow Haskell Compiler (GHC).

Setting up the Haskell development environment

GHCup is the main installer for the general purpose language Haskell.
Can be installed here
Also refer, the tool for build here
Select cabal from the build tool options (latest version)

Once installation is done. We will create our working directory as :

Then we go inside the created directory:

For starting our project we will use cabal to create the project structure

.cabal file will have the same name as provided to the project directory.

In the beginning we will get the project structure will look as follows:

We have 4 files in here.

## CHANGELOG.md logs changes and updates

`Main.hs` is the main project file for execution of our project. All the functions will be
referred from here.

.cabal file = this is the file that provides details on versions used, libraries, packages
etc.
For any updates added in the project cabal refers our file from here.

Visual Studio Code ( VSCode ) is a popular choice with well-supported Haskell
integration.
So, for our development we have used VSCode for further development

We will discuss the current project and the aspects:
```
User data
User Age
Daily Calorie
Counter
Allergies
Food
preferences,
ingredients &amp;
kitchen
ingredients

Get api data
Weather api
Time &amp;
temperature
Billboard API
Top 10 Billboard
Artists

Build logic for
food
Rule application
from module –
cuisines,preferred
foods,kitchen
ingredients
Data aggregation
Real time
processing
–based on temp

Decision making
&amp; prediction
GoogleLLM
Api(Gemini)
Feed Data &gt; Get
output for
recommended
Meal
Further Action
Push to database
```
The Project Directory Looks like :

Understanding to directories and their contents:

app : It has all the Haskell code for our app
Files in it:

`GetWeather.hs`
Here we are using the GetWeather API to fetch the temperature data and the current
time. And from that we store that data into the JSON file.
After we have imported all the relevant libraries,
Following library imports, we configure `FromJSON` instances to parse JSON into
Haskell types (`Weather`, `Location`, `Current`). These instances define
`parseJSON` functions, mapping JSON to Haskell types using `aeson` combinators
like `A.withObject` and `AT..:` for field extraction. Employing record syntax, our data
types mirror JSON keys, enabling construction of these types with parsed JSON
fields to represent weather information.

Thereafter we have :
`getWeather`: Fetches weather data for New York from the WeatherAPI and returns
it as a lazy `ByteString`.
`storeWeatherData`: Uses `getWeather` to fetch weather data and stores it in
&quot;data/weather_data.json&quot; for later retrieval.
`getWeatherData`: Reads weather data from &quot;data/weather_data.json&quot; and attempts
to decode it into a `Weather` type, returning a `Maybe Weather`.

`GoogleLLM.hs`
Her we have an API connection to LLM (Language Learning Model) from our
structure we will provide the data to this API and get the output for the Meal
recommendations.
Also, we’re using this to get the cuisines inspired from the hometowns of our
billboard top 10 artists.

We will firstly import the relevant libraries &amp; packages. Thereafter required variables
will be declared.

`generateContent` function generates content by making a POST request to the
Google Language Models API.
It takes a prompt as input, creates an HTTP manager using `newManager
tlsManagerSettings`, and parses the request URL. The content to be generated is
constructed as a JSON object containing the prompt. This JSON object is then
encoded into a lazy bytestring and sent as the request body. The request is set to
use the POST method with appropriate headers. The response from the API is
captured, and the generated content is extracted from the response body and
returned as a strict bytestring.

`Main.hs`
In Haskell, `main.hs` acts as the entry point for an application, containing the primary
program logic, typically the `main` function. The `main` function has a type signature
of `IO ()`, indicating it performs input/output actions or interacts with the outside
world.
It serves as the starting point for program execution, orchestrating tasks such as
user interaction, file operations, network requests, and other IO actions essential for
the program&#39;s functionality.
The clarity provided by `main.hs` aids in understanding the program&#39;s structure and
behavior, facilitating code navigation and maintenance.

We will import the relevant libraries and packages.
Here in our Main file we have coded many other functions and created actions for
compilation in there itself. Understanding to the same is as below:
Starting with:
Functions getPreferredCuisines retrieves preferred cuisine and
getFoodPreferences retreives food preferences from JSON files.
`getPreferredCuisines`reads the content of &quot;data/meal_preferences.json&quot;. It
attempts to decode the JSON content into `[MealPreference]`.Returns a list of
preferred cuisines for the given time, extracted from the decoded JSON data.
`getFoodPreferences` Reads the content of &quot;data/food_preferences.json&quot;. It
attempts to decode the JSON content into `[FoodPreferences]`.Returns the food
preferences for temperatures below 10°C, extracted from the decoded JSON data.

`jsonFile` represents the file path &quot;data/meal_preferences.json&quot;.
`getJSON` reads the content of the JSON file specified by `jsonFile` using
`BL.readFile`. It returns the content as a lazy `ByteString` in the `IO` monad.
`splitDateAndTime` takes a `String` representing a date and time as input and splits
it based on the space character. It returns the last element of the resulting list, which
typically represents the time component of the input string.

Thereafter we have the Main function .We first need to understand the importance of
main :: IO ()
The `main :: IO ()` function in Haskell serves as the starting point for program
execution. It coordinates input/output actions and interactions with the external
world, defining the program&#39;s behavior and sequence of operations.

Now we will process all the required functions for successful completion towards our
project.
Using the `getWeatherData` function, binding the result to the `weather` variable
within a `do` block. This construct enables sequencing of IO actions, ensuring the
subsequent operations occur only if weather data is successfully obtained.

Upon obtaining the weather data (`Just w`), the code proceeds to extract pertinent
information such as the current time, temperature, and date-time. Utilizing functions
like `localtime` and `splitDateAndTime`, it accurately retrieves these details from the
weather data.
`timeRange` based on specified conditions. Subsequently, the
`getPreferredCuisines` function is invoked with the determined time range to fetch
the corresponding preferred cuisines.
`getFoodPreferences` function is then called with the determined temperature
range (&quot;Below 10°C&quot;) to fetch the preferred foods corresponding to that temperature
range. If preferred foods are found (`Just p`), they are printed.

Read the contents of the file &quot;data/billboard_top_artists.json&quot; using `BL.readFile`.The
JSON content is then decoded into a `Maybe Aeson.Value`, represented by
`topArtists`.
If the decoding is successful (`Just v`), the code converts the decoded value into a
string `myJSON`.then convert `myJSON` into a bytestring and subsequently into a
lazy bytestring for further processing.From this lazy bytestring, it decodes a JSON
object, `myJSONObject`, and extracts its relevant text value.
Request for content generation by Google LLM, incorporating information about
preferred cuisines.The generated content is then written to &quot;data/GoogleLLM.json&quot;.
Another request is made to Google LLM to generate content regarding Billboard&#39;s
top 10 artists and their hometown&#39;s famous food.Resulting
json&quot;data/billboard_top_artists.json&quot; using `BL.writeFile`.

There are JSON Files, In the directory data, that we have created based on the
criteria mentioned in project:
food_preferences.json : preferred_foods based on the current temperature of the
region user is in
kitchen_ingredients.json: the available ingredients in the kitchen.
meal_preferences.json : Based on the current time we have the preferred_cuisines
and the calories limit as max_calories.

The tests directory has tests written for the project

data-analysis.cabal

`data-analysis.cabal` serves to specify project metadata, dependencies, build
instructions, and configurations for tests.
It facilitates consistent project management, automates dependency installation,
ensures correct project building, defines executables and libraries, and configures
test suites.
Overall, it&#39;s crucial for managing, building, and testing Haskell projects effectively.
