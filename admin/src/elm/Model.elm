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
    , questions : Dict.Dict String PollQuestion
    , participants : Dict.Dict String ParticipantStatus
    , status : PollStatus
    }


type PollStatus
    = NotRunning
    | Running String -- questionId
    | Finished


type alias PollQuestion =
    { id : String
    , status : PollQuestionStatus
    , textMd : String
    , answers : Dict.Dict String String -- id, answer string
    , actualAnswers : Dict.Dict String String -- partipant name, answerId
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
        , questions = Dict.fromList []
        , participants = Dict.fromList []
        , status = NotRunning
        }
