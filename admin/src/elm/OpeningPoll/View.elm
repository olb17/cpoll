module OpeningPoll.View exposing (indexView)

-- import Common.View exposing (warningMessage)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
-- import Html.Keyed exposing (..)
import Dict

import Messages exposing (..)
import OpeningPoll.Messages exposing (..)
import Model exposing (..)

indexView : Model -> Html Msg
indexView model =
    div
        [ id "admin_index" ]
        (viewContent model)


viewContent : Model -> List (Html Msg)
viewContent model =
    [ h1 [] [text ("Admin Poll - [ " ++ (viewPollStatus model.status) ++ " ]")]
    ,  ul []
        (List.map (viewQuestionMenu model.status) (Dict.values model.questions))
    , h1 [] [text "Participants"]
    ,  ul []
        (List.map viewParticipants (Dict.toList model.participants))
    
    ]

viewPollStatus : PollStatus -> String
viewPollStatus status =
    case status of
        NotRunning -> "Not Running"
        Running _ -> "Running"
        Finished -> "Finished"


viewQuestionMenu: PollStatus -> PollQuestion -> Html Msg
viewQuestionMenu status question =
    li []
    [ span [] 
        [ text (question.textMd ++ "[ " ++ (viewQuestionStatus question.status) ++ " ]")
        , viewRunButton question status
        , viewCancelButton question status
        , viewFinishButton question status
        , viewAnswerButton question
        ]
    ]


viewRunButton : PollQuestion -> PollStatus -> Html Msg 
viewRunButton question status = 
    if status == NotRunning && question.status == NotStarted then 
        button [ onClick <| OpeningPollMsg (StartQuestion question) ] [ text "Run Question" ]
    else
        text ""


viewCancelButton : PollQuestion -> PollStatus -> Html Msg 
viewCancelButton question status = 
    case status of
        Running runningId ->
            if question.id == runningId then
                button [ onClick <| OpeningPollMsg (CancelQuestion question) ] [ text "Cancel Question" ]
            else
                text ""
        _ ->
            text ""


viewFinishButton : PollQuestion -> PollStatus -> Html Msg 
viewFinishButton question status  = 
    case status of
        Running runningId ->
            if question.id == runningId then
                button [ onClick <| OpeningPollMsg (EndQuestion question) ] [ text "Finish Question" ]
            else
                text ""
        _ ->
            text ""

viewAnswerButton : PollQuestion -> Html Msg 
viewAnswerButton question = 
    case question.status of
        Closed ->
            button [] [ text "Display Answers" ]
        _ ->
            text ""


viewQuestionStatus: PollQuestionStatus -> String
viewQuestionStatus status =
    case status of
        NotStarted -> "Not Started"
        WaitingForAnswers -> "Running"
        Closed -> "Closed"


viewParticipants: (String, ParticipantStatus) -> Html Msg
viewParticipants (participant, status) =
    li []
    [ text (participant ++ " [ " ++ (viewParticipantStatus status) ++ " ]") ]

viewParticipantStatus: ParticipantStatus -> String
viewParticipantStatus status =
    case status of
        Online -> "Online"
        Offline -> "Offline"
        Disabled -> "Disabled"
        DisabledOffline -> "DisabledOffline"

raiseLocalInputMsg: (String -> OpeningPollMsgType) -> (String -> Msg)
raiseLocalInputMsg msg =
    \x -> OpeningPollMsg (msg x)
