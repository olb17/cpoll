module Poll.Update exposing (update)

import Time

import Messages exposing (..)
import Poll.Messages exposing (..)
import Model exposing (..)
import Common.Delay exposing (..)

update : PollMsgType -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        IncomingQuestion pq ->
            { model | pollQuestion = pq } ! []
        
        SelectAnswer idAnswer ->
            let
                pq = model.pollQuestion
                pqUpdated = { pq | answerId = Just idAnswer
                                 , status = WaitingForAllAnswers
                            }
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
                { model | pollQuestion = pqUpdated } ! 
                    [
                    delay (Time.second * 1) <| PollMsg (UpdatedAnswerNb 2)
                    , delay (Time.second * 2) <| PollMsg (UpdatedAnswerNb 4)
                    , delay (Time.second * 4) <| PollMsg (UpdatedAnswerNb 9)
                    , delay (Time.second * 6) <| PollMsg (EndOfQuestion pqFinal)
                ]

        UpdatedAnswerNb nbAnswers ->
            let
                pq = model.pollQuestion
                pqUpdated = { pq | answerNb = nbAnswers }
            in
                { model | pollQuestion = pqUpdated } ! []
        
        EndOfQuestion pq ->
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
                { model | pollQuestion = pq } ! 
                    [ delay (Time.second * 2) <| PollMsg (IncomingQuestion pqNextQuestion) ]
