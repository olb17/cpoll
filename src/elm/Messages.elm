module Messages exposing (..)

import Navigation
import Routing exposing (Route)

import Home.Messages exposing (..)
import AdminHome.Messages exposing (..)
import Poll.Messages exposing (..)

type Msg
    = HomeMsg HomeMsgType
    | PollMsg PollMsgType
    | AdminHomeMsg AdminHomeMsgType
    | PollConnected
    | UrlChange Navigation.Location
    | NavigateTo Route