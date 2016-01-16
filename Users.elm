import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)
import StartApp.Simple as StartApp
import String

type alias Customer = {name : String, message : String}
type alias Model = { customers : List Customer }

model : Model
model = { customers = [
                {name = "Daniel Gomez", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. "},
                {name =  "Emil Haugberg van Veen", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."},
                {name =  "Luca Verhees", message =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."}
            ]
       }

main =
  StartApp.start { model = model , update = update, view = view }

type alias Action = String

view : Signal.Address Action -> Model -> Html.Html
view x y =
  customers y.customers

update : Action -> Model -> Model
update x y = y

customers : List Customer -> Html
customers customers =
  div [] (List.map customer customers )

customer : Customer -> Html
customer customer =
    div []
      [div [] [text customer.name]
      , div [] [text customer.message]
      ]
