import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)
import StartApp.Simple as StartApp
import String

type alias Customer = { id : Int, name : String, message : String}
type alias Uistate = {fieldName : String, fieldMessage : String }
type alias Model = { fieldName : String, fieldMessage : String, uid : Int, customers : List Customer}

model : Model
model = {
            fieldName = ""
            , fieldMessage = ""
            , uid = 0
            ,customers = [
                { id = 0 , name = "Daniel Gomez", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. "},
                { id = 1, name =  "Emil Haugberg van Veen", message = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."},
                { id = 2, name =  "Luca Verhees", message =  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."}
            ]

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


type Action = SetName String | SetMessage String | Delete Int | Add
update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      {model |
        fieldName = ""
        , fieldMessage = ""
        , uid = model.uid + 1
        , customers = model.customers ++ [newCustomer model.uid model.fieldName model.fieldMessage]
      }
    SetName str -> {model | fieldName = str}
    SetMessage str -> {model | fieldMessage = str}
    Delete id -> {model | customers = List.filter (\t -> t.id /= id) model.customers}

newCustomer : Int -> String -> String -> Customer
newCustomer id name message =
  { id = id
  ,name = name
  , message = message
  }

customers : Address Action -> List Customer -> Html
customers action customers =
  div [] (List.map customer action customers )

customer : Address Action -> Customer -> Html
customer action customer =
    div []
      [div [] [text customer.name]
      , div [] [text customer.message]
      , button
            [ class "destroy"
            , onClick action (Delete customer.id)
            ]
            [ text "Delete" ]
      ]
