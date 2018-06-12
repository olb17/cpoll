module Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = HomeIndexRoute
    | AdminHomeRoute
    | OpeningPollRoute String
    | AdminPollRoute String
    | ParticipateToPollRoute String
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        HomeIndexRoute ->
            "/"

        AdminHomeRoute ->
            "/#admin"

        OpeningPollRoute id ->
            "/#openingPoll/" ++ id
        
        AdminPollRoute id ->
            "/#adminPoll/" ++ id
        
        ParticipateToPollRoute id ->
            "/#poll/" ++ id

        NotFoundRoute ->
            "/#not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeIndexRoute <| s ""
        , map AdminHomeRoute <| s "admin"
        , map OpeningPollRoute <| s "openingPoll" </> string
        , map AdminPollRoute <| s "adminPoll" </> string
        , map ParticipateToPollRoute <| s "poll" </> string
        ]


parse : Navigation.Location -> Route
parse location =
    let
      locationHash =
        if String.isEmpty(location.hash)
        then { location | hash = "#/" }
        else location
    in        
        case UrlParser.parseHash matchers locationHash of
            Just route ->
                route

            Nothing ->
                NotFoundRoute
