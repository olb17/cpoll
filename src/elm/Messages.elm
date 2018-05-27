module Messages exposing (..)

import Navigation
import Routing exposing (Route)

import Model exposing (..)
import Home.Messages exposing (..)

type Msg
    = HomeMsg HomeMsgType
    | PollConnected
    | IncomingQuestion PollQuestion
    | SelectAnswer String
    | UpdatedAnswerNb Int
    | UrlChange Navigation.Location
    | NavigateTo Route