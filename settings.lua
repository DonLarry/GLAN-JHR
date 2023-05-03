Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Camera'
require 'src/Animation'
require 'src/Entity'
require 'src/Hitbox'
require 'src/Player'
require 'src/StateMachine'

require 'src/definitions/entity'

require 'src/states/BaseState'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityPunchState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerSlapState'
require 'src/states/entity/player/PlayerKneeHitState'

require 'src/states/game/GameOverState'
require 'src/states/game/WinState'
require 'src/states/game/PlayState'
require 'src/states/game/PauseState'
require 'src/states/game/StartState'

require 'src/utilities/quads'

require 'src/gui/Dialog'
require 'src/gui/ProgressBar'

VIRTUAL_WIDTH = 576
VIRTUAL_HEIGHT = 324

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

GAME_TITLE = 'Jitsugyouka: Home Road'
TILE_SIZE = 16

CATCALLING_MESSAGES = {
    "So many curves and me with no brakes",
    "I could stare at you all day",
    "Nice legs, what time do they open?",
    "Hey baby, why don't you come over and show me a good time?",
    "Hey sweetheart, I bet you'd look even better without those clothes on",
    "I'd like to mop you up, baby",
    "Hey baby, you got a boyfriend?",
    "What's your hurry, babe?",
    "*Wolf whistle*",
}

-- map constants

MAP_WIDTH = VIRTUAL_WIDTH*4
MAP_HEIGHT = VIRTUAL_HEIGHT

TEXTURES = {
    --Hero
    ['character-walk'] = love.graphics.newImage('graphics/Hero/Walk-Hero.png'),
    ['character-slap'] = love.graphics.newImage('graphics/Hero/Slap-Hero.png'),
    ['character-knee-hit'] = love.graphics.newImage('graphics/Hero/KneeHit-Hero.png'),
    --Npc0
    ['enemy-walk'] = love.graphics.newImage('graphics/Npc0/Walk-Npc0.png'),
    ['Npc0-punch'] = love.graphics.newImage('graphics/Npc0/Punch-Npc0.png'),

    --Background1
    ['background'] = love.graphics.newImage('graphics/background.png'),

    --Scenary
    ['scenary'] = love.graphics.newImage('graphics/Scenary-testing.png'),

    --Adding the NPC0 Versions
    ['npc0-blackskin-blond-walk'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond/Walk-Npc0-BlackSkin-Blond.png'),
    ['npc0-blackskin-blond-punch'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond/Punch-Npc0-BlackSkin-Blond.png'),
    ['npc0-blackskin-blond-noglasses-walk'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond-NoGlasses/Walk-Npc0-BlackSkin-Blond-NoGlasses.png'),
    ['npc0-blackskin-blond-noglasses-punch'] = love.graphics.newImage('graphics/Npc0-BlackSkin-Blond-NoGlasses/Punch-Npc0-BlackSkin-Blond-NoGlasses.png'),
    ['npc0-blackskin-whiteclothes-walk'] = love.graphics.newImage('graphics/Npc0-BlackSkin-WhiteClothes/Walk-Npc0-BlackSkin-WhiteClothes.png'),
    ['npc0-blackskin-whiteclothes-punch'] = love.graphics.newImage('graphics/Npc0-BlackSkin-WhiteClothes/Punch-Npc0-BlackSkin-WhiteClothes.png'),
    ['npc0-blond-walk'] = love.graphics.newImage('graphics/Npc0-Blond/Walk-Npc0-Blond.png'),
    ['npc0-blond-punch'] = love.graphics.newImage('graphics/Npc0-Blond/Punch-Npc0-Blond.png'),
    ['npc0-blond-chinese-walk'] = love.graphics.newImage('graphics/Npc0-Blond-Chinese/Walk-Npc0-Blond-Chinese.png'),
    ['npc0-blond-chinese-punch'] = love.graphics.newImage('graphics/Npc0-Blond-Chinese/Punch-Npc0-Blond-Chinese.png'),
    ['npc0-blond-noglasses-walk'] = love.graphics.newImage('graphics/Npc0-Blond-NoGlasses/Walk-Npc0-Blond-NoGlasses.png'),
    ['npc0-blond-noglasses-punch'] = love.graphics.newImage('graphics/Npc0-Blond-NoGlasses/Punch-Npc0-Blond-NoGlasses.png'),
    ['npc0-blond-otherclothes-walk'] = love.graphics.newImage('graphics/Npc0-Blond-OtherClothes/Walk-Npc0-Blond-OtherClothes.png'),
    ['npc0-blond-otherclothes-punch'] = love.graphics.newImage('graphics/Npc0-Blond-OtherClothes/Punch-Npc0-Blond-OtherClothes.png')
}


FRAMES = {
    ['character-walk'] = generateQuads(TEXTURES['character-walk'], 24, 73),
    ['character-slap'] = generateQuads(TEXTURES['character-slap'], 32, 73),
    ['character-knee-hit'] = generateQuads(TEXTURES['character-knee-hit'], 32, 73),

    ['enemy-walk'] = generateQuads(TEXTURES['enemy-walk'], 25, 75),
    ['Npc0-punch'] = generateQuads(TEXTURES['Npc0-punch'], 35, 75),

    --Adding the NPC0 Versions
    ['npc0-blackskin-blond-walk'] = generateQuads(TEXTURES['npc0-blackskin-blond-walk'], 25, 75),
    ['npc0-blackskin-blond-punch'] = generateQuads(TEXTURES['npc0-blackskin-blond-punch'], 35, 75),
    ['npc0-blackskin-blond-noglasses-walk'] = generateQuads(TEXTURES['npc0-blackskin-blond-noglasses-walk'], 25, 75),
    ['npc0-blackskin-blond-noglasses-punch'] = generateQuads(TEXTURES['npc0-blackskin-blond-noglasses-punch'], 35, 75),
    ['npc0-blackskin-whiteclothes-walk'] = generateQuads(TEXTURES['npc0-blackskin-whiteclothes-walk'], 25, 75),
    ['npc0-blackskin-whiteclothes-punch'] = generateQuads(TEXTURES['npc0-blackskin-whiteclothes-punch'], 35, 75),
    ['npc0-blond-walk'] = generateQuads(TEXTURES['npc0-blond-walk'], 25, 75),
    ['npc0-blond-punch'] = generateQuads(TEXTURES['npc0-blond-punch'], 35, 75),
    ['npc0-blond-chinese-walk'] = generateQuads(TEXTURES['npc0-blond-chinese-walk'], 25, 75),
    ['npc0-blond-chinese-punch'] = generateQuads(TEXTURES['npc0-blond-chinese-punch'], 35, 75),
    ['npc0-blond-noglasses-walk'] = generateQuads(TEXTURES['npc0-blond-noglasses-walk'], 25, 75),
    ['npc0-blond-noglasses-punch'] = generateQuads(TEXTURES['npc0-blond-noglasses-punch'], 35, 75),
    ['npc0-blond-otherclothes-walk'] = generateQuads(TEXTURES['npc0-blond-otherclothes-walk'], 25, 75),
    ['npc0-blond-otherclothes-punch'] = generateQuads(TEXTURES['npc0-blond-otherclothes-punch'], 35, 75)
}


FONTS = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}

SOUNDS = {
    ['start-music'] = love.audio.newSource('sounds/blood_of_villain.mp3', 'static'),
    ['dungeon-music'] = love.audio.newSource('sounds/scenary_music.mp3', 'static'),
    ['game-over-music'] = love.audio.newSource('sounds/game_over_music.mp3', 'static'),
    ['win-music'] = love.audio.newSource('sounds/win_music.mp3', 'static'),
    ['UOFF'] = love.audio.newSource('sounds/UOFF.mp3', 'static'),
    ['hero-damage'] = love.audio.newSource('sounds/hero_damage.wav', 'static'),
    ['dead'] = love.audio.newSource('sounds/dead.mp3', 'static'),
    ['miss'] = love.audio.newSource('sounds/miss.mp3', 'static'),
    ['slap'] = love.audio.newSource('sounds/slap.mp3', 'static')
}
