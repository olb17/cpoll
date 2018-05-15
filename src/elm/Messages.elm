module Messages exposing (..)

import Navigation
import Routing exposing (Route)

import Model exposing (..)

type Msg
    = HandlePollInput String
    | HandleUsernameInput String
    | HandlePollSubmit
    | PollConnected
    | IncomingQuestion PollQuestion
    | SelectAnswer String
    | UpdatedAnswerNb Int
    | UrlChange Navigation.Location
    | NavigateTo Route
