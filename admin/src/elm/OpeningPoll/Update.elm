module OpeningPoll.Update exposing (update)

import List

import Messages exposing (..)
import OpeningPoll.Messages exposing (..)
import Model exposing (..)


update : OpeningPollMsgType -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartQuestion question ->
            let
                q = { question | status = WaitingForAnswers }
                qs = List.map (updateQuestion q) model.questions
            in
                { model | 
                  status = Running question.id
                , questions = qs 
                } ! []

        EndQuestion question ->
           let
                q = { question | status = Closed }
                qs = List.map (updateQuestion q) model.questions
                finished = List.all (\q -> q.status == Closed) qs
            in
                { model | 
                  status = if finished then Finished else NotRunning
                , questions = qs 
                } ! []
        
        CancelQuestion question ->
           let
                q = { question | status = NotStarted }
                qs = List.map (updateQuestion q) model.questions
            in
                { model | 
                  status = NotRunning
                , questions = qs 
                } ! []

updateQuestion : PollQuestion -> PollQuestion -> PollQuestion
updateQuestion questionToUpdate question =
    if questionToUpdate.id == question.id then
        questionToUpdate
    else
        question