module Model exposing (..)

import Routing exposing (Route)
import Dict

type RemoteData e a
    = NotRequested
    | Requesting
    | Failure e
    | Success a


type alias Model =
    { poll : Maybe String
    , username : Maybe String
    , route : Route
    , jsonDescription : String
    , questions : List PollQuestion
    , participants : Dict.Dict String ParticipantStatus
    }


type alias PollQuestion =
    { id : String
    , status : PollQuestionStatus
    , textMd : String
    , answers : List (String, String) -- id, answer string
    , actualAnswers : List (String, String) -- partipant name, answerId
    }


type PollQuestionStatus
    = NotStarted
    | WaitingForAnswers
    | Closed


type ParticipantStatus
    = Online
    | Disabled
    | DisabledOffline
    | Offline


initialModel : Route -> String -> Model
initialModel route username =
    let
        usernameMaybe = if String.isEmpty(username) then Nothing else Just username
    in
        { poll = Nothing
        , username = usernameMaybe
        , route = route
        , jsonDescription = ""
        , questions = []
        , participants = Dict.fromList []
        }
