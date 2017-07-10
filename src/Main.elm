module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src)
import Dict exposing (..)


-- Quest dialog


type alias TextData =
    { speaker : String
    , text : String
    , nextId : String
    }


type alias SingleChoice =
    { text : String
    , nextId : String
    }


type alias ChoiceData =
    { speaker : String
    , text : String
    , choices : List SingleChoice
    }


type Dialog
    = Text TextData
    | Choice ChoiceData
    | Action (List Event)


type alias Conversation =
    List ( String, Dialog )


fetchQuestConversationProlog : Conversation
fetchQuestConversationProlog =
    [ ( "key0"
      , Choice
            (ChoiceData "QuestReceiver"
                "Can you help me find XX"
                [ SingleChoice "yes" "key1"
                , SingleChoice "no" "key2"
                ]
            )
      )
    , ( "key0", Text (TextData "QuestGiver" "Great" "key3") )
    , ( "key2", Text (TextData "QuestGiver" "ok later then" "key0") )
    , ( "key3", Action ([]) )
    ]


type alias Event =
    { from : String
    , to : String
    , what : String
    , action : String
    }


dialogDb : Dict.Dict String Dialog
dialogDb =
    Dict.fromList
        fetchQuestConversationProlog


test : Maybe Dialog
test =
    Debug.log "yea" (Dict.get "key0" dialogDb)


type alias Quest =
    { prolog : Conversation
    , active : Conversation
    , success : Conversation
    , failure : Conversation
    , rewardActions : List Event
    }



-- QuestGiver : does something : with/using : to someone
-- QuestGiver_gives_reward_player


type alias Npc =
    { name : String
    , quests : List Quest
    }


type ItemType
    = Weapon
    | Gadget
    | Armour
    | Resource
    | Nothing


type alias Item =
    { name : String
    , itemType : ItemType
    }



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div [] [ text "Your Elm App is working!" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
