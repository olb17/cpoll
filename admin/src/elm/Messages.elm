module Messages exposing (..)

import Navigation
import Routing exposing (Route)

import AdminHome.Messages exposing (..)
import OpeningPoll.Messages exposing (..)
import Model

type Msg
    = OpeningPollMsg OpeningPollMsgType
    | AdminHomeMsg AdminHomeMsgType
    | PollCreated String (List Model.PollQuestion) -- pollid , questions
    | ParticipantChange String Model.ParticipantStatus
    | UrlChange Navigation.Location
    | NavigateTo Route