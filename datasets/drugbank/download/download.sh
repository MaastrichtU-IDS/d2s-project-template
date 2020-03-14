#!/bin/bash

# Use sample hosted on GitHub, faster for testing
wget -N https://github.com/MaastrichtU-IDS/d2s-scripts-repository/raw/master/resources/drugbank-sample/drugbank.zip

# See the uncompressed file here: 
# https://github.com/MaastrichtU-IDS/d2s-scripts-repository/blob/master/resources/drugbank-sample/drugbank.xml

# Download full DrugBank dataset providing user login and password
#curl -Lfv -o drugbank.zip -u $USERNAME:$PASSWORD https://www.drugbank.ca/releases/5-1-5/downloads/all-full-database

# Example:
#curl -Lfv -o drugbank.zip -u vincent.emonet@maastrichtuniversity.nl:my_password https://www.drugbank.ca/releases/5-1-5/downloads/all-full-database

unzip *.zip -d .

# Unzip all files in subdir with name of the zip file
# find . -name "*.zip" | while read filename; do unzip -o -d "`dirname "$filename"`/${filename%.*}" "$filename"; done;
echo "content of dir"
ls
#ls drugbank
#mv drugbank/* .
# rmdir drugbank

### Generate JSON test file for RML test:

rml_json_test = '{
  "persons": [
    {
      "firstname": "Kline",
      "lastname": "Chen"
    },
    {
      "firstname": "Marquita",
      "lastname": "Travis"
    },
    {
      "firstname": "Morin",
      "lastname": "Whitehead"
    },
    {
      "firstname": "Russo",
      "lastname": "Bird"
    },
    {
      "firstname": "Norman",
      "lastname": "Rogers"
    },
    {
      "firstname": "Ava",
      "lastname": "Stafford"
    },
    {
      "firstname": "Joyce",
      "lastname": "Anderson"
    },
    {
      "firstname": "Katina",
      "lastname": "Rollins"
    },
    {
      "firstname": "Cooper",
      "lastname": "Guthrie"
    },
    {
      "firstname": "Irene",
      "lastname": "Francis"
    },
    {
      "firstname": "Kelsey",
      "lastname": "Snyder"
    },
    {
      "firstname": "Angel",
      "lastname": "Holman"
    },
    {
      "firstname": "Muriel",
      "lastname": "Lambert"
    },
    {
      "firstname": "Gretchen",
      "lastname": "Weeks"
    },
    {
      "firstname": "Horton",
      "lastname": "Coleman"
    },
    {
      "firstname": "Shepherd",
      "lastname": "Ford"
    },
    {
      "firstname": "Sasha",
      "lastname": "Trujillo"
    },
    {
      "firstname": "Saundra",
      "lastname": "Harding"
    },
    {
      "firstname": "Mejia",
      "lastname": "Joyce"
    },
    {
      "firstname": "Guerrero",
      "lastname": "Foley"
    },
    {
      "firstname": "Vargas",
      "lastname": "Webster"
    },
    {
      "firstname": "Alford",
      "lastname": "Juarez"
    },
    {
      "firstname": "Maura",
      "lastname": "Wells"
    },
    {
      "firstname": "Mclaughlin",
      "lastname": "Rios"
    },
    {
      "firstname": "Leon",
      "lastname": "Mccullough"
    },
    {
      "firstname": "Chambers",
      "lastname": "Donaldson"
    },
    {
      "firstname": "Cherry",
      "lastname": "Gonzalez"
    },
    {
      "firstname": "Velasquez",
      "lastname": "Kennedy"
    },
    {
      "firstname": "Christi",
      "lastname": "Simpson"
    },
    {
      "firstname": "Doreen",
      "lastname": "Gibbs"
    },
    {
      "firstname": "Brock",
      "lastname": "Brooks"
    },
    {
      "firstname": "Everett",
      "lastname": "Kirkland"
    },
    {
      "firstname": "Small",
      "lastname": "Poole"
    },
    {
      "firstname": "Hebert",
      "lastname": "Hays"
    },
    {
      "firstname": "Mercado",
      "lastname": "Briggs"
    },
    {
      "firstname": "Ruthie",
      "lastname": "Morrow"
    },
    {
      "firstname": "Jan",
      "lastname": "Williamson"
    },
    {
      "firstname": "Leonor",
      "lastname": "Erickson"
    },
    {
      "firstname": "Mollie",
      "lastname": "Dillon"
    },
    {
      "firstname": "Curtis",
      "lastname": "Madden"
    },
    {
      "firstname": "Jeanne",
      "lastname": "Hines"
    },
    {
      "firstname": "Jacobs",
      "lastname": "Vance"
    },
    {
      "firstname": "Stokes",
      "lastname": "Stewart"
    },
    {
      "firstname": "Lorena",
      "lastname": "Cochran"
    },
    {
      "firstname": "Velez",
      "lastname": "Kirk"
    },
    {
      "firstname": "Patrice",
      "lastname": "Davidson"
    },
    {
      "firstname": "Cruz",
      "lastname": "Gallegos"
    },
    {
      "firstname": "Lora",
      "lastname": "Parsons"
    },
    {
      "firstname": "Felicia",
      "lastname": "Duke"
    },
    {
      "firstname": "Patricia",
      "lastname": "Fernandez"
    },
    {
      "firstname": "Conrad",
      "lastname": "Flynn"
    },
    {
      "firstname": "Cross",
      "lastname": "Clements"
    },
    {
      "firstname": "Vanessa",
      "lastname": "Dale"
    },
    {
      "firstname": "Bobbie",
      "lastname": "Oconnor"
    },
    {
      "firstname": "Nielsen",
      "lastname": "Morse"
    },
    {
      "firstname": "Aline",
      "lastname": "Noble"
    },
    {
      "firstname": "Tucker",
      "lastname": "Hogan"
    },
    {
      "firstname": "Tillman",
      "lastname": "Zimmerman"
    },
    {
      "firstname": "Rowland",
      "lastname": "Rich"
    },
    {
      "firstname": "Paula",
      "lastname": "Casey"
    },
    {
      "firstname": "Constance",
      "lastname": "Terrell"
    },
    {
      "firstname": "Katelyn",
      "lastname": "Adams"
    },
    {
      "firstname": "Susanne",
      "lastname": "Rodriguez"
    },
    {
      "firstname": "Brown",
      "lastname": "Pickett"
    },
    {
      "firstname": "Jacklyn",
      "lastname": "Cortez"
    },
    {
      "firstname": "Melinda",
      "lastname": "Mathews"
    },
    {
      "firstname": "Navarro",
      "lastname": "Maddox"
    },
    {
      "firstname": "Durham",
      "lastname": "Warner"
    },
    {
      "firstname": "Vickie",
      "lastname": "Sears"
    },
    {
      "firstname": "Schneider",
      "lastname": "Watts"
    },
    {
      "firstname": "Janelle",
      "lastname": "Reid"
    },
    {
      "firstname": "Hansen",
      "lastname": "Moon"
    },
    {
      "firstname": "Solis",
      "lastname": "Zamora"
    },
    {
      "firstname": "Pratt",
      "lastname": "Estes"
    },
    {
      "firstname": "Kathie",
      "lastname": "Levine"
    },
    {
      "firstname": "Monique",
      "lastname": "Montgomery"
    },
    {
      "firstname": "Polly",
      "lastname": "Long"
    },
    {
      "firstname": "Nichols",
      "lastname": "Rhodes"
    },
    {
      "firstname": "Odessa",
      "lastname": "Benton"
    },
    {
      "firstname": "Singleton",
      "lastname": "Mcknight"
    },
    {
      "firstname": "Cheryl",
      "lastname": "Quinn"
    },
    {
      "firstname": "Ericka",
      "lastname": "Marshall"
    },
    {
      "firstname": "Franco",
      "lastname": "Dudley"
    },
    {
      "firstname": "Adrian",
      "lastname": "Willis"
    },
    {
      "firstname": "Harrington",
      "lastname": "Burt"
    },
    {
      "firstname": "Lila",
      "lastname": "Gillespie"
    },
    {
      "firstname": "Emily",
      "lastname": "Ballard"
    },
    {
      "firstname": "Dianna",
      "lastname": "Prince"
    },
    {
      "firstname": "Lawson",
      "lastname": "Cotton"
    },
    {
      "firstname": "Deanne",
      "lastname": "Copeland"
    },
    {
      "firstname": "Rosario",
      "lastname": "Dean"
    },
    {
      "firstname": "Knapp",
      "lastname": "Orr"
    },
    {
      "firstname": "Page",
      "lastname": "Obrien"
    },
    {
      "firstname": "Andrews",
      "lastname": "Pena"
    },
    {
      "firstname": "Adela",
      "lastname": "Stanton"
    },
    {
      "firstname": "Bernadette",
      "lastname": "Davenport"
    },
    {
      "firstname": "Estela",
      "lastname": "Beard"
    },
    {
      "firstname": "Lott",
      "lastname": "Alston"
    },
    {
      "firstname": "Lorene",
      "lastname": "Gamble"
    },
    {
      "firstname": "Kellie",
      "lastname": "Tran"
    }
  ]
}'

echo rml_json_test > rml_test.json