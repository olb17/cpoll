module Poll.Messages exposing (..)

import Model exposing (..)

type PollMsgType
    = IncomingQuestion PollQuestion
    | SelectAnswer String
    | UpdatedAnswerNb Int
    | EndOfQuestion PollQuestion
