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
                {name = "Daniel Gomez", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros."},
                {name =  "Emil Haugberg van Veen", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros."},
                {name =  "Luca Verhees", message =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros."}
            ]
       }

main =
  StartApp.start { model = model , update = update, view = view }

type alias Action = Int

view : Signal.Address Action -> Model -> Html.Html
view x y =
  div []
    [div [] [text model.name]]


update : Action -> Model -> Model
update x y = y

customerToHtml : Customer -> List Html
customerToHtml customer =
  [div [] [text customer.name]]
