module Poll.Update exposing (update)

import Messages exposing (..)
import Poll.Messages exposing (..)
import Model exposing (..)

import Server

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
            in
                Server.handleSelectAnswer { model | pollQuestion = pqUpdated }

        UpdatedAnswerNb nbAnswers ->
            let
                pq = model.pollQuestion
                pqUpdated = { pq | answerNb = nbAnswers }
            in
                { model | pollQuestion = pqUpdated } ! []
        
        EndOfQuestion pq ->
            Server.handleEndOfQuestion { model | pollQuestion = pq }
