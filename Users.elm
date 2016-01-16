import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)
import StartApp.Simple as StartApp
import String

type alias Customer = {name : String, message : String}
type alias Uistate = {fieldName : String, fieldMessage : String }
type alias Model = { customers : List Customer, fieldName : String, fieldMessage : String}

model : Model
model = { customers = [
                {name = "Daniel Gomez", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. "},
                {name =  "Emil Haugberg van Veen", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."},
                {name =  "Luca Verhees", message =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."}
            ]
          , fieldName = ""
          , fieldMessage = ""
       }

main =
  StartApp.start { model = model , update = update, view = view }

view : Signal.Address Action -> Model -> Html.Html
view action model =
  div []
    [customers model.customers
    , input
        [ placeholder "Name"
        , on "input" targetValue (Signal.message action << SetName)
        ]
        []
    ,input
        [ placeholder "Message"
        , on "input" targetValue (Signal.message action << SetMessage)
        ]
        []
    , button [ onClick action Add ] [ text "add" ]
    ]


type Action = SetName String | SetMessage String | Add
update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      {model |
        customers = model.customers ++ [newCustomer model.fieldName model.fieldMessage]
        , fieldName = ""
        , fieldMessage = ""
      }
    SetName str -> {model | fieldName = str}
    SetMessage str -> {model | fieldMessage = str}

newCustomer : String -> String -> Customer
newCustomer name message =
  { name = name
  , message = message
  }

customers : List Customer -> Html
customers customers =
  div [] (List.map customer customers )

customer : Customer -> Html
customer customer =
    div []
      [div [] [text customer.name]
      , div [] [text customer.message]
      ]
