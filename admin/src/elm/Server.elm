module Server exposing (..)

import Time
import Common.Delay exposing (..)

import Model exposing (..)
import Messages exposing (..)

handleCreatePoll: Model -> ( Model, Cmd Msg )
handleCreatePoll model = 
    model ! [ delay (Time.second * 0) <| PollCreated "pollid1" mockPollQuestions
            , delay (Time.second * 2) <| ParticipantChange "olivier" Model.Online
            , delay (Time.second * 4) <| ParticipantChange "dom" Model.Online
            , delay (Time.second * 6) <| ParticipantChange "xavier" Model.Online
            , delay (Time.second * 8) <| ParticipantChange "dom" Model.Offline
            ]


mockPollQuestions: List Model.PollQuestion
mockPollQuestions =
    [
        { id = "id1"
        , status = Model.NotStarted
        , textMd = "Question1"
        , answers = [ ("idq1", "Réponse 1"), ("idq2", "Réponse 2"), ("idq3", "Réponse 3"),("idq4", "Réponse 4") ]
        , actualAnswers = []
        }
    ,   { id = "id2"
        , status = Model.NotStarted
        , textMd = "Question2"
        , answers = [ ("idq1", "Réponse 1"), ("idq2", "Réponse 2"), ("idq3", "Réponse 3"),("idq4", "Réponse 4") ]
        , actualAnswers = []
        }

    ]