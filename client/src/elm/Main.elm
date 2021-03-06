module Main exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Navigation
import Routing exposing (parse)
import Update exposing (..)
import View exposing (view)

type alias Flags =
  { username : String
  }

init : Flags -> Navigation.Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            parse location

        model =
            initialModel currentRoute flags.username <| parserServerDesc flags
    in
        urlUpdate model


main : Program Flags Model Msg
main =
    Navigation.programWithFlags UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = always <| Sub.none
        }

parserServerDesc : Flags -> ServerDesc
parserServerDesc flags = 
    Mock -- only mock is implemented