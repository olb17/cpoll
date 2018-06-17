module Model exposing (..)

import Routing exposing (Route)
-- import Server

type RemoteData e a
    = NotRequested
    | Requesting
    | Failure e
    | Success a


type alias Model =
    { poll : Maybe String
    , username : Maybe String
    , route : Route
    , question : RemoteData String String
    , pollQuestion : PollQuestion
    , serverDesc : ServerDesc
    }

type alias PollQuestion =
    { id : String
    , status : PollQuestionStatus
    , textMd : String
    , answers : List (String, String, Int)
    , answerId : Maybe String
    , participantNb : Int
    , answerNb : Int
    }

type PollQuestionStatus
    = WaitingForQuestion
    | WaitingForAnswer
    | WaitingForAllAnswers
    | DisplayResult

type ServerDesc = Mock

initialModel : Route -> String -> ServerDesc -> Model
initialModel route username serverDesc =
    let
        usernameMaybe = if String.isEmpty(username) then Nothing else Just username
    in
        { poll = Nothing
        , username = usernameMaybe
        , route = route
        , question = NotRequested
        , pollQuestion = initPollQuestion
        , serverDesc = serverDesc
        }

initPollQuestion : PollQuestion
initPollQuestion = 
    { id = ""
    , status = WaitingForQuestion
    , textMd = ""
    , answers = []
    , answerId = Nothing
    , participantNb = 0
    , answerNb = 0
    }