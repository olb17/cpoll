module Messages exposing (..)

import Navigation
import Routing exposing (Route)

import Home.Messages exposing (..)
import AdminHome.Messages exposing (..)
import OpeningPoll.Messages exposing (..)
import Poll.Messages exposing (..)

type Msg
    = HomeMsg HomeMsgType
    | PollMsg PollMsgType
    | OpeningPollMsg OpeningPollMsgType
    | AdminHomeMsg AdminHomeMsgType
    | PollConnected
    | UrlChange Navigation.Location
    | NavigateTo Route