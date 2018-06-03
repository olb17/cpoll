module Model exposing (..)

import Routing exposing (Route)


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

initialModel : Route -> String -> Model
initialModel route username =
    let
        usernameMaybe = if String.isEmpty(username) then Nothing else Just username
    in
        { poll = Nothing
        , username = usernameMaybe
        , route = route
        , question = NotRequested
        , pollQuestion = initPollQuestion
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