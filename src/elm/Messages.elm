module Messages exposing (..)

import Navigation
import Routing exposing (Route)

import Model exposing (..)
import Home.Messages exposing (..)
import Poll.Messages exposing (..)

type Msg
    = HomeMsg HomeMsgType
    | PollMsg PollMsgType
    | PollConnected
    | UrlChange Navigation.Location
    | NavigateTo Route