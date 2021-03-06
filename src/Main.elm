module Main exposing (..)

import Html exposing (Html, text, div, img)
import Html.Attributes exposing (src, href, style, class)
import Dict exposing (..)
import Material
import Material.Scheme
import Material.Button as Button


-- Quest dialog


type alias Choice =
    { text : String
    , nextId : String
    }


type alias SpeechData =
    { speaker : String
    , text : String
    , choices : List Choice
    }


type Dialog
    = Speech SpeechData
    | DoEvents (List Event)


type alias Conversation =
    List ( String, Dialog )



-- standard move to next speech


nextSpeech : String -> List Choice
nextSpeech key =
    [ Choice "ok" key ]


fetchQuestConversationProlog : Conversation
fetchQuestConversationProlog =
    [ ( "key0"
      , Speech
            (SpeechData "QuestReceiver"
                "Can you help me find XX"
                [ Choice "yes" "key1"
                , Choice "no" "key2"
                ]
            )
      )
    , ( "key0", Speech (SpeechData "QuestGiver" "Great" (nextSpeech "key3")) )
    , ( "key0", Speech (SpeechData "QuestGiver" "ok later then" (nextSpeech "key0")) )
    , ( "key3", DoEvents ([]) )
    ]



-- subjects can be items, players, npc, quests etc, any thing
-- animal : start_attack : player
-- player : TriggerEvent : event
-- works both directions
-- player : receive : reward
-- sometimes parameters are omitted or not used
-- current_quest : step_quest : current_quest


type alias Event =
    { subject1 : String
    , verb : VerbType
    , subject2 : String
    }



-- VerbTypes need proper and valid subjects
-- StepQuest can't be run on anything that is not a quest


type VerbType
    = StartAttack
    | Attack
    | Receive
    | StepQuest
    | TriggerEvent


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
    , rewardActions : List Int
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
    { mdl :
        Material.Model
        -- Boilerplate: model store for any and all Mdl components you use.
    }


model : Model
model =
    { mdl =
        Material.model
        -- Boilerplate: Always use this initial Mdl model store.
    }


type alias Mdl =
    Material.Model


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )



---- UPDATE ----


type Msg
    = Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model



--    ( model, Cmd.none )
---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ]
            []
        , Button.render Mdl
            [ 9, 0, 0, 1 ]
            model.mdl
            [ Button.ripple
            , Button.colored
            , Button.raised
              --, Button.link "#grid"
            ]
            [ text "Link" ]
        , div [] [ text "Your Elm App is working!" ]
        ]
        |> Material.Scheme.top



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
