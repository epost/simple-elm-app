import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (..)
import StartApp.Simple as StartApp

type alias Customer = { id : Int, name : String, message : String }

type alias Model    = { fieldName : String, fieldMessage : String, uid : Int, customers : List Customer}

type Action = SetName String | SetMessage String | Delete Int | Add

model : Model
model = { fieldName = ""
        , fieldMessage = ""
        , uid = 0
        , customers = [ { id = 0, name = "Daniel Gomez"          , message = "UI nerd" }
                      , { id = 1, name = "Emil Haugberg van Veen", message = "UI + FP nerd" }
                      , { id = 2, name = "Luca Verhees"          , message = "UI nerd" }
                      ]
        }

main : Signal Html
main = StartApp.start { model = model, update = update, view = view }

view : Signal.Address Action -> Model -> Html.Html
view adr model =
  div []
    [ customersHtml model.customers adr
    , input [placeholder "Name"   , on "input" targetValue (Signal.message adr << SetName   )] []
    , input [placeholder "Message", on "input" targetValue (Signal.message adr << SetMessage)] []
    , button [onClick adr Add] [text "add"]
    ]

update : Action -> Model -> Model
update action model = case action of
  Add -> { model | fieldName = ""
                 , fieldMessage = ""
                 , uid = model.uid + 1
                 , customers = model.customers ++ [newCustomer model.uid model.fieldName model.fieldMessage]
         }
  SetName str    -> { model | fieldName = str }
  SetMessage str -> { model | fieldMessage = str }
  Delete id      -> { model | customers = List.filter (\t -> t.id /= id) model.customers }

mkCustomer : Int -> String -> String -> Customer
mkCustomer id name message = { id = id, name = name, message = message }

customersHtml : List Customer -> Address Action -> Html
customersHtml customers adr =
  div [] (List.map ((flip customerHtml) adr) customers)

customerHtml : Customer -> Address Action -> Html
customerHtml customer adr =
    div [] [ div [] [text customer.name]
           , div [] [text customer.message]
           , button [class "destroy", onClick adr (Delete customer.id)] [text "Delete"]
           ]
