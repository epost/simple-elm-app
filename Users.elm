import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)
import StartApp.Simple as StartApp
import String

type alias Model = { customers : List Customer }

model : Model
model = { customers = [
                {name = "Daniel Gomez", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros."},
                {name =  "Emil Haugberg van Veen", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros."},
                {name =  "Luca Verhees", message =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros."}
            ]
       }

type alias Customer =
  {
    name : String
    , message : String
  }

type alias Action = Int

myView : Signal.Address Action -> Model -> Html.Html
myView x y =
  ul [class "grocery-list"]
    [ li [] [text "Pamplemousse"]
    , li [] [text "Ananas"]
    , li [] [text "Jus d'orange"]
    , li [] [text "Boeuf"]
    , li [] [text "Soupe du jour"]
    , li [] [text "Camembert"]
    , li [] [text "Jacques Cousteau"]
    , li [] [text "Baguette"]
    ]

updateModel : Action -> Model -> Model
updateModel a m = m

main =
  StartApp.start { model = model, view = myView, update = updateModel }
