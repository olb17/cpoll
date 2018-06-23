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
    [ h1 [] [text "Admin Poll"]
    ,  ul []
        (List.map viewQuestionMenu model.questions)
    , h1 [] [text "Participants"]
    ,  ul []
        (List.map viewParticipants (Dict.toList model.participants))
    
    ]

viewQuestionMenu: PollQuestion -> Html Msg
viewQuestionMenu question =
    li []
    [ span [] 
        [ text (question.textMd ++ "[ " ++ (viewQuestionStatus question.status) ++ " ]")
        , input [ type_ "button", value "Run Question" ] []-- , onClick <| AdminHomeMsg HandleCreatePollSubmit ] []
        , input [ type_ "button", value "Cancel Question" ] []
        , input [ type_ "button", value "Finish Question" ] []
        , input [ type_ "button", value "Display Answers" ] []
        ]
    ]


viewQuestionStatus: PollQuestionStatus -> String
viewQuestionStatus status =
    case status of
        NotStarted -> "Not Started"
        WaitingForAnswers -> "Running"
        Closed -> "Closed"


viewParticipants: (String, ParticipantStatus) -> Html Msg
viewParticipants (participant, status) =
    li []
    [ text (participant ++ " [ STATUS ]") ]


raiseLocalInputMsg: (String -> OpeningPollMsgType) -> (String -> Msg)
raiseLocalInputMsg msg =
    \x -> OpeningPollMsg (msg x)
