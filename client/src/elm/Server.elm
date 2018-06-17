module Server exposing (..)

import Time
import Common.Delay exposing (..)

import Model exposing (..)
import Messages exposing (..)
import Poll.Messages

handlePollSubmit : Model -> ( Model, Cmd Msg )
handlePollSubmit model = 
    let
        pq =
            { id = "id1"
            , status = WaitingForAnswer
            , textMd = "Mais quelle est la question ?"
            , answers = [ 
                        ("id1", "Question 1", 0)
                        , ("id2", "Question 2", 0)
                        , ("id3", "Question 3", 0)
                        , ("id4", "Question 4", 0)
                        ]
            , answerId = Nothing
            , participantNb = 10
            , answerNb = 0
            }
    in
        case model.poll of
            Just pollid -> model ! 
                [ delay (Time.second * 0) <| PollConnected
                , delay (Time.second * 2) <| PollMsg (Poll.Messages.IncomingQuestion pq) ]
            Nothing -> model ! []


handleEndOfQuestion : Model -> ( Model, Cmd Msg )
handleEndOfQuestion model =
    let
        pqNextQuestion = { id = "id2"
            , status = WaitingForAnswer
            , textMd = "Mais quelle est la question ?"
            , answers = [ 
                        ("id21", "Question 21", 0)
                        , ("id22", "Question 22", 0)
                        , ("id23", "Question 23", 0)
                        , ("id24", "Question 24", 0)
                        ]
            , answerId = Nothing
            , participantNb = 10
            , answerNb = 0
            }
    in
        model ! 
            [ delay (Time.second * 2) <| PollMsg (Poll.Messages.IncomingQuestion pqNextQuestion) ]


handleSelectAnswer : Model -> ( Model, Cmd Msg )
handleSelectAnswer model =
    let
        pqFinal = { id = "id1"
            , status = DisplayResult
            , textMd = "Mais quelle est la question ?"
            , answers = [ 
                        ("id1", "Question 1", 2)
                        , ("id2", "Question 2", 1)
                        , ("id3", "Question 3", 0)
                        , ("id4", "Question 4", 7)
                        ]
            , answerId = Nothing
            , participantNb = 10
            , answerNb = 10
            }
    in
        model ! 
            [
            delay (Time.second * 1) <| PollMsg (Poll.Messages.UpdatedAnswerNb 2)
            , delay (Time.second * 2) <| PollMsg (Poll.Messages.UpdatedAnswerNb 4)
            , delay (Time.second * 4) <| PollMsg (Poll.Messages.UpdatedAnswerNb 9)
            , delay (Time.second * 6) <| PollMsg (Poll.Messages.EndOfQuestion pqFinal)
        ]   