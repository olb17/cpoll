module View exposing (..)

import Common.View exposing (warningMessage, backToHomeLink)
import Home.View exposing (indexView)
import AdminHome.View exposing (indexView)
import Poll.View exposing (indexView)
import Html exposing (..)
import Html.Attributes exposing (..)
--import Html.Events exposing (onClick)
import Messages exposing (..)
import Model exposing (..)
import Routing exposing (Route(..))


view : Model -> Html Msg
view model =
    section
        []
        [ headerView
        , div []
            [ page model ]
        ]


headerView : Html Msg
headerView =
    header
        [ class "main-header" ]
        [ h1
            []
            [ text "CPoll : a polling application" ]
        ]


page : Model -> Html Msg
page model =
    case model.route of
        HomeIndexRoute ->
            Home.View.indexView model

        AdminHomeRoute ->
            AdminHome.View.indexView model

        ParticipateToPollRoute pollid ->
            Poll.View.indexView model.pollQuestion
            
        _ ->
            notFoundView


notFoundView : Html Msg
notFoundView =
    warningMessage
        "fa fa-meh-o fa-stack-2x"
        "Page not found"
        backToHomeLink
