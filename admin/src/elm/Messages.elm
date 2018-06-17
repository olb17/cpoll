module Messages exposing (..)

import Navigation
import Routing exposing (Route)

import AdminHome.Messages exposing (..)
import OpeningPoll.Messages exposing (..)

type Msg
    = OpeningPollMsg OpeningPollMsgType
    | AdminHomeMsg AdminHomeMsgType
    | UrlChange Navigation.Location
    | NavigateTo Route