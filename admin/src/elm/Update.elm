module Update exposing (..)

-- import Debug

import Routing exposing (Route(..), parse, toPath)
import Messages exposing (..)
import Model exposing (..)
import Navigation
import Dict

import AdminHome.Update
import OpeningPoll.Update

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdminHomeMsg adminHomeMsgType ->
            AdminHome.Update.update adminHomeMsgType model
        
        OpeningPollMsg openingPollMsgType ->
            OpeningPoll.Update.update openingPollMsgType model

        PollCreated pollid questionList ->
            let
                updateQuestions =
                    questionList
                    |> List.map (\question -> (question.id, question)) 
                    |> Dict.fromList
            in
                update (NavigateTo (OpeningPollRoute pollid)) 
                    { model | questions = updateQuestions, poll = Just pollid }

        ParticipantAnswer participant questionid answerid ->
            updateAnswer model participant questionid answerid ! []
        
        ParticipantChange participant status ->
            let 
                participantDict =
                    Dict.insert participant status model.participants
            in
                { model | participants = participantDict } ! []

        UrlChange location ->
            let
                currentRoute = parse location
            in
                urlUpdate { model | route = currentRoute }

        NavigateTo route ->
            model ! [ Navigation.newUrl <| toPath route ]


urlUpdate : Model -> ( Model, Cmd Msg )
urlUpdate model =
    case model.route of
        AdminHomeRoute ->
            model ! []

        _ ->
            model ! []

updateAnswer : Model -> String -> String -> String -> Model
updateAnswer model participant questionid answerid =
    let
        foundParticipant = Dict.member participant model.participants
        foundQuestion = Dict.get questionid model.questions
        foundAnswer = case foundQuestion of
            Nothing -> False
            Just question -> 
                Dict.member answerid question.answers
        alreadyAnswered = case foundQuestion of
            Nothing -> False
            Just question -> 
                Dict.member answerid question.actualAnswers
        questionBeingAnswered = case foundQuestion of
            Nothing -> False
            Just question -> 
                question.status == WaitingForAnswers
        updatedAnswers = case foundQuestion of
            Nothing -> Dict.empty -- Cannot happen
            Just question -> 
                if Dict.member answerid question.actualAnswers
                then
                    question.actualAnswers
                else
                    Dict.insert participant answerid question.actualAnswers
        updatedQuestions = case foundQuestion of
            Nothing -> Nothing
            Just question -> 
                Just { question | actualAnswers = updatedAnswers }
    in
        if  foundParticipant && 
            foundQuestion /= Nothing &&
            foundAnswer &&
            questionBeingAnswered &&
            not alreadyAnswered
        then
            case updatedQuestions of
            Nothing -> model
            Just question -> 
                { model | questions = Dict.insert question.id question model.questions } 
        else
            model
