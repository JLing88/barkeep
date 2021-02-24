![alt text](https://img.shields.io/badge/Ruby-2.5.8-red "Ruby Version: 2.5.8")
![alt text](https://img.shields.io/badge/Rails-5.2.4.5-red "Ruby on Rails Version: 5.2.4.5")
![alt text](https://img.shields.io/badge/PostgreSQL-13.1-blue "PostgreSQL Version: 13.1")
![alt text](https://img.shields.io/badge/Bundler-2.1.4-lightgrey "Bundler Version: 2.1.4")
# Barkeep

This is an API for professional and amatuer bartenders alike! The API allows for a user to search for a drink term and returns a list of related cocktails and recipes. The user can fetch an individual search from the history or search for new recipes. The user is able to see all of the historical searches.


## Getting the project running locally
This section assumes you have an installation of the Ruby and Rails versions indicated by the badges at the top of this page, have an installation of Postgresql, and are running on MacOS. The system dependencies are also listed in the next section

* clone the repository
* `bundle install` - bundles all gems and associated dependencies
* `rails db:create` - create the database
* `rails db:migrate` - run the database migrations
* `rails s` - start the application on port 3000 by default
* `rails c` - start the rails database console
* `rspec` - runs full test suite

## System dependencies

* Ruby 2.5.8
* Ruby on Rails 5.2.4.5
* PostgreSQL 13.1
* Bundler 2.1.4

## Live Application

The living API documentation can be viewed at: https://polar-crag-06475.herokuapp.com/apipie

### Base URL
```
https://polar-crag-06475.herokuapp.com
```

### API endpoints
***
```
GET /api/v1/searches

Optional Query Parameters:
order=asc - #sort in ascending order of the updated_at attribute
order=desc #sort in descending order of the updated_at attribute (this is the default behavior if no parameter is provided)
order=alpha-asc #sort alphabetically based on the query name
order=alpha-desc  #sort alphabetically based on the query name
filter=<string> #filters the results based on the query string of the searches
```
DESCRIPTION: Returns a list of all previous searches and their associated cocktail recipes. If a query parameter is provided, the response will be sorted OR filtered.

[Example Request](#index)
***

```
GET /api/v1/searches/:id

Required parameters:
:id - must be a number
```
DESCRIPTION: Returns a single search and its associated cocktail recipes.

[Example Request](#show)
***
```
DELETE /api/v1/searches/:id
Required parameters:
:id - must be a number
```
DESCRIPTION: Deletes the search object with the corresponing id or if it is not found, a 404 not found response.

[Example Request](#destroy)
***
```
POST /api/v1/searches

Required Body Parameters:
cocktail[:query]
```
DESCRIPTION: Creates a new search OR returns an existing search of the same query parameter.

[Example Request](#create)
***
## Technologies Used

[apipie-rails](https://github.com/Apipie/apipie-rails): Used for living api documentation. This was the first time I've used it, but found it to be pretty neat! It does muddy up the controller code a bit, however. \
\
[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers): Used for simple, one line model validations.  \
\
[fast_jsonapi](https://github.com/Netflix/fast_jsonapi): Used for generating json api responses. I used it once before a long time ago. Seems very opinionated and I'm not sure I like the structure of the responses. It is very fast though!  \
\
[database-cleaner](https://github.com/DatabaseCleaner/database_cleaner): Used for cleaning up test data in between or during runs.  \
\
[factory-bot](factory_bot_rails): Used for quickly creating test objects. \
\
[rspec-rails](https://github.com/rspec/rspec-rails): Test framework that plays really nicely with Rails

***
## Future Upgrades

* Implement the ability to search by ingredients and find cocktail recipes which use that ingredient.
* Build out the recipes controller with an UPDATE action for users to add their own recipes.
* Add authentication so that users don't share recipes with the entire world.
* I intentionally left out the UPDATE action on the `searches_controller`. It didn't seem that updating the search objects made sense in this scenario as the information is static.
* Build out the front end (which I plan to do!) so that the application is friendlier for non-tech users.

## Example Responses
#### Index
`GET /api/v1/searches` 
```
{
    "data": [
        {
            "id": "2",
            "type": "search",
            "attributes": {
                "id": 2,
                "query": "margarita",
                "url": "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
            },
            "relationships": {
                "cocktails": {
                    "data": [
                        {
                            "id": "2",
                            "type": "cocktail"
                        },
                        {
                            "id": "3",
                            "type": "cocktail"
                        },
                        {
                            "id": "4",
                            "type": "cocktail"
                        },
                        {
                            "id": "5",
                            "type": "cocktail"
                        },
                        {
                            "id": "6",
                            "type": "cocktail"
                        },
                        {
                            "id": "7",
                            "type": "cocktail"
                        }
                    ]
                }
            }
        },
        {
            "id": "1",
            "type": "search",
            "attributes": {
                "id": 1,
                "query": "rusty nail",
                "url": "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rusty nail"
            },
            "relationships": {
                "cocktails": {
                    "data": [
                        {
                            "id": "1",
                            "type": "cocktail"
                        }
                    ]
                }
            }
        }
    ],
    "included": [
        {
            "id": "2",
            "type": "cocktail",
            "attributes": {
                "id": 2,
                "recipe": {
                    "strIBA": "Contemporary Classics",
                    "idDrink": "11007",
                    "strTags": "IBA,ContemporaryClassic",
                    "strDrink": "Margarita",
                    "strGlass": "Cocktail glass",
                    "strVideo": null,
                    "strCategory": "Ordinary Drink",
                    "strMeasure1": "1 1/2 oz ",
                    "strMeasure2": "1/2 oz ",
                    "strMeasure3": "1 oz ",
                    "strMeasure4": null,
                    "strMeasure5": null,
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": "2015-08-18 14:42:59",
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg",
                    "strImageSource": "https://commons.wikimedia.org/wiki/File:Klassiche_Margarita.jpg",
                    "strIngredient1": "Tequila",
                    "strIngredient2": "Triple sec",
                    "strIngredient3": "Lime juice",
                    "strIngredient4": "Salt",
                    "strIngredient5": null,
                    "strIngredient6": null,
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": "Reiben Sie den Rand des Glases mit der Limettenscheibe, damit das Salz daran haftet. Achten Sie darauf, dass nur der äußere Rand angefeuchtet wird und streuen Sie das Salz darauf. Das Salz sollte sich auf den Lippen des Genießers befinden und niemals in den Cocktail einmischen. Die anderen Zutaten mit Eis schütteln und vorsichtig in das Glas geben.",
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": "Strofina il bordo del bicchiere con la fetta di lime per far aderire il sale.\r\nAvere cura di inumidire solo il bordo esterno e cospargere di sale.\r\nIl sale dovrebbe presentarsi alle labbra del bevitore e non mescolarsi mai al cocktail.\r\nShakerare gli altri ingredienti con ghiaccio, quindi versarli delicatamente nel bicchiere.",
                    "strImageAttribution": "Cocktailmarler",
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "Yes"
                }
            }
        },
        {
            "id": "3",
            "type": "cocktail",
            "attributes": {
                "id": 3,
                "recipe": {
                    "strIBA": null,
                    "idDrink": "11118",
                    "strTags": null,
                    "strDrink": "Blue Margarita",
                    "strGlass": "Cocktail glass",
                    "strVideo": null,
                    "strCategory": "Ordinary Drink",
                    "strMeasure1": "1 1/2 oz ",
                    "strMeasure2": "1 oz ",
                    "strMeasure3": "1 oz ",
                    "strMeasure4": "Coarse ",
                    "strMeasure5": null,
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": "2015-08-18 14:51:53",
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/bry4qh1582751040.jpg",
                    "strImageSource": null,
                    "strIngredient1": "Tequila",
                    "strIngredient2": "Blue Curacao",
                    "strIngredient3": "Lime juice",
                    "strIngredient4": "Salt",
                    "strIngredient5": null,
                    "strIngredient6": null,
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "Rub rim of cocktail glass with lime juice. Dip rim in coarse salt. Shake tequila, blue curacao, and lime juice with ice, strain into the salt-rimmed glass, and serve.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": "Den Rand des Cocktailglases mit Limettensaft einreiben. Den Rand in grobes Salz tauchen. Tequila, blauen Curacao und Limettensaft mit Eis schütteln, in das mit Salz umhüllte Glas abseihen und servieren.",
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": "Strofinare il bordo del bicchiere da cocktail con succo di lime. Immergere il bordo nel sale grosso. Shakerare tequila, blue curacao e succo di lime con ghiaccio, filtrare nel bicchiere bordato di sale e servire.",
                    "strImageAttribution": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "Yes"
                }
            }
        },
        {
            "id": "4",
            "type": "cocktail",
            "attributes": {
                "id": 4,
                "recipe": {
                    "strIBA": "New Era Drinks",
                    "idDrink": "17216",
                    "strTags": "IBA,NewEra",
                    "strDrink": "Tommy's Margarita",
                    "strGlass": "Old-Fashioned glass",
                    "strVideo": null,
                    "strCategory": "Ordinary Drink",
                    "strMeasure1": "4.5 cl",
                    "strMeasure2": "1.5 cl",
                    "strMeasure3": "2 spoons",
                    "strMeasure4": null,
                    "strMeasure5": null,
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": "2017-09-02 18:37:54",
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/loezxn1504373874.jpg",
                    "strImageSource": null,
                    "strIngredient1": "Tequila",
                    "strIngredient2": "Lime Juice",
                    "strIngredient3": "Agave syrup",
                    "strIngredient4": null,
                    "strIngredient5": null,
                    "strIngredient6": null,
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "Shake and strain into a chilled cocktail glass.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": "Schütteln und in ein gekühltes Cocktailglas abseihen.",
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": "Shakerare e filtrare in una coppetta da cocktail ghiacciata.",
                    "strImageAttribution": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "No"
                }
            }
        },
        {
            "id": "5",
            "type": "cocktail",
            "attributes": {
                "id": 5,
                "recipe": {
                    "strIBA": null,
                    "idDrink": "16158",
                    "strTags": null,
                    "strDrink": "Whitecap Margarita",
                    "strGlass": "Margarita/Coupette glass",
                    "strVideo": null,
                    "strCategory": "Other/Unknown",
                    "strMeasure1": "1 cup ",
                    "strMeasure2": "2 oz ",
                    "strMeasure3": "1/4 cup ",
                    "strMeasure4": "3 tblsp fresh ",
                    "strMeasure5": null,
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": "2015-09-02 17:00:22",
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/srpxxp1441209622.jpg",
                    "strImageSource": null,
                    "strIngredient1": "Ice",
                    "strIngredient2": "Tequila",
                    "strIngredient3": "Cream of coconut",
                    "strIngredient4": "Lime juice",
                    "strIngredient5": null,
                    "strIngredient6": null,
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "Place all ingredients in a blender and blend until smooth. This makes one drink.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": "Alle Zutaten in einen Mixer geben und mischen.",
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": "Metti tutti gli ingredienti in un frullatore e frulla fino a che non diventa liscio.",
                    "strImageAttribution": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "No"
                }
            }
        },
        {
            "id": "6",
            "type": "cocktail",
            "attributes": {
                "id": 6,
                "recipe": {
                    "strIBA": null,
                    "idDrink": "12322",
                    "strTags": null,
                    "strDrink": "Strawberry Margarita",
                    "strGlass": "Cocktail glass",
                    "strVideo": null,
                    "strCategory": "Ordinary Drink",
                    "strMeasure1": "1/2 oz ",
                    "strMeasure2": "1 oz ",
                    "strMeasure3": "1/2 oz ",
                    "strMeasure4": "1 oz ",
                    "strMeasure5": "1 oz ",
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": "2015-08-18 14:41:51",
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/tqyrpw1439905311.jpg",
                    "strImageSource": null,
                    "strIngredient1": "Strawberry schnapps",
                    "strIngredient2": "Tequila",
                    "strIngredient3": "Triple sec",
                    "strIngredient4": "Lemon juice",
                    "strIngredient5": "Strawberries",
                    "strIngredient6": "Salt",
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "Rub rim of cocktail glass with lemon juice and dip rim in salt. Shake schnapps, tequila, triple sec, lemon juice, and strawberries with ice, strain into the salt-rimmed glass, and serve.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": "Cocktailglasrand mit Zitronensaft und Tauchrand in Salz wenden. Schnaps, Tequila, Triple-Sec, Zitronensaft und Erdbeeren mit Eis schütteln, in das salzige Glas sieben und servieren.",
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": "Strofinare il bordo del bicchiere da cocktail con succo di limone e immergerlo nel sale. Shakerare grappa, tequila, triple sec, succo di limone e fragole con ghiaccio, filtrare nel bicchiere bordato di sale e servire.",
                    "strImageAttribution": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "No"
                }
            }
        },
        {
            "id": "7",
            "type": "cocktail",
            "attributes": {
                "id": 7,
                "recipe": {
                    "strIBA": null,
                    "idDrink": "178332",
                    "strTags": null,
                    "strDrink": "Smashed Watermelon Margarita",
                    "strGlass": "Collins glass",
                    "strVideo": null,
                    "strCategory": "Cocktail",
                    "strMeasure1": "1/2 cup",
                    "strMeasure2": "5",
                    "strMeasure3": "1/3 Cup",
                    "strMeasure4": "Juice of 1/2",
                    "strMeasure5": "1 shot",
                    "strMeasure6": "Garnish with",
                    "strMeasure7": "Garnish with",
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": null,
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/dztcv51598717861.jpg",
                    "strImageSource": null,
                    "strIngredient1": "Watermelon",
                    "strIngredient2": "Mint",
                    "strIngredient3": "Grapefruit Juice",
                    "strIngredient4": "Lime",
                    "strIngredient5": "Tequila",
                    "strIngredient6": "Watermelon",
                    "strIngredient7": "Mint",
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "In a mason jar muddle the watermelon and 5 mint leaves together into a puree and strain. Next add the grapefruit juice, juice of half a lime and the tequila as well as some ice. Put a lid on the jar and shake. Pour into a glass and add more ice. Garnish with fresh mint and a small slice of watermelon.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": null,
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": null,
                    "strImageAttribution": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "No"
                }
            }
        },
        {
            "id": "1",
            "type": "cocktail",
            "attributes": {
                "id": 1,
                "recipe": {
                    "strIBA": "Unforgettables",
                    "idDrink": "12101",
                    "strTags": "IBA,Classic",
                    "strDrink": "Rusty Nail",
                    "strGlass": "Old-fashioned glass",
                    "strVideo": "https://www.youtube.com/watch?v=3po6GT4Te64",
                    "strCategory": "Ordinary Drink",
                    "strMeasure1": "1 1/2 oz ",
                    "strMeasure2": "1/2 oz ",
                    "strMeasure3": "1 twist of ",
                    "strMeasure4": null,
                    "strMeasure5": null,
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": "2016-11-04 09:49:42",
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/yqsvtw1478252982.jpg",
                    "strImageSource": null,
                    "strIngredient1": "Scotch",
                    "strIngredient2": "Drambuie",
                    "strIngredient3": "Lemon peel",
                    "strIngredient4": null,
                    "strIngredient5": null,
                    "strIngredient6": null,
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "Pour the Scotch and Drambuie into an old-fashioned glass almost filled with ice cubes. Stir well. Garnish with the lemon twist.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": "Gießen Sie den Scotch und die Drambuie in ein old-fashioned Glas, das fast mit Eiswürfeln gefüllt ist. Gut umrühren. Mit der Zitronenscheibe garnieren.",
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": "Versare lo Scotch e il Drambuie in un bicchiere vecchio stile quasi riempito di cubetti di ghiaccio. Guarnire con la scorza di limone. Mescolare bene.",
                    "strImageAttribution": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "No"
                }
            }
        }
    ]
}
```
#### Show
`GET /api/v1/searches/1
```
{
    "data": {
        "id": "1",
        "type": "search",
        "attributes": {
            "id": 1,
            "query": "rusty nail",
            "url": "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=rusty nail"
        },
        "relationships": {
            "cocktails": {
                "data": [
                    {
                        "id": "1",
                        "type": "cocktail"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "id": "1",
            "type": "cocktail",
            "attributes": {
                "id": 1,
                "recipe": {
                    "strIBA": "Unforgettables",
                    "idDrink": "12101",
                    "strTags": "IBA,Classic",
                    "strDrink": "Rusty Nail",
                    "strGlass": "Old-fashioned glass",
                    "strVideo": "https://www.youtube.com/watch?v=3po6GT4Te64",
                    "strCategory": "Ordinary Drink",
                    "strMeasure1": "1 1/2 oz ",
                    "strMeasure2": "1/2 oz ",
                    "strMeasure3": "1 twist of ",
                    "strMeasure4": null,
                    "strMeasure5": null,
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "dateModified": "2016-11-04 09:49:42",
                    "strAlcoholic": "Alcoholic",
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/yqsvtw1478252982.jpg",
                    "strImageSource": null,
                    "strIngredient1": "Scotch",
                    "strIngredient2": "Drambuie",
                    "strIngredient3": "Lemon peel",
                    "strIngredient4": null,
                    "strIngredient5": null,
                    "strIngredient6": null,
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strInstructions": "Pour the Scotch and Drambuie into an old-fashioned glass almost filled with ice cubes. Stir well. Garnish with the lemon twist.",
                    "strDrinkAlternate": null,
                    "strInstructionsDE": "Gießen Sie den Scotch und die Drambuie in ein old-fashioned Glas, das fast mit Eiswürfeln gefüllt ist. Gut umrühren. Mit der Zitronenscheibe garnieren.",
                    "strInstructionsES": null,
                    "strInstructionsFR": null,
                    "strInstructionsIT": "Versare lo Scotch e il Drambuie in un bicchiere vecchio stile quasi riempito di cubetti di ghiaccio. Guarnire con la scorza di limone. Mescolare bene.",
                    "strImageAttribution": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strCreativeCommonsConfirmed": "No"
                }
            }
        }
    ]
}
```
#### Destroy
`DELETE /api/v1/searches/1`
```
DELETE /api/v1/searches/1 HTTP/1.1
Host: polar-crag-06475.herokuapp.com
cache-control: no-cache
Postman-Token: 54baf775-fe88-46ec-809f-b6d072d92efa
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW

```
#### Create
`POST /api/v1/searches`\
`body: cocktail[:query]=whiskey%20sour`
```
POST /api/v1/searches HTTP/1.1
Host: polar-crag-06475.herokuapp.com
cache-control: no-cache
Postman-Token: 2b8df54e-572c-4558-b739-6cd0d26b5b9c
Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW

Content-Disposition: form-data; name="cocktail[query]"

whiskey sour
------WebKitFormBoundary7MA4YWxkTrZu0gW--
```