import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)
import StartApp.Simple as StartApp
import String

main =
  StartApp.start { model = "", view = myView, update = updateModel }

type alias Action = String
type alias Model = String

updateModel : Action -> Model -> Model
updateModel newStr oldStr =
  newStr

myView : Address String -> Model -> Html
myView address string =
  div []
    [input
     [ placeholder "test"
        , value string
        , on "input" targetValue (Signal.message address)
        ]
        []
      , div [] [text (string)]
      ]
