function love.load()
    anim8 = require "anim8/anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    player = {}
    player.x = 400
    player.y = 200
    player.speed = 1.5
    player.spriteSheet = love.graphics.newImage("images/Sprite-0004.png")
    player.grid = anim8.newGrid(16,16, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animations = {}
    player.animations.idle = anim8.newAnimation(player.grid("1-2", 1), 0.3)
    player.animations.down = anim8.newAnimation(player.grid("1-3", 4), 0.3)
    player.animations.left = anim8.newAnimation(player.grid("1-4", 2), 0.1)
    player.animations.right = anim8.newAnimation(player.grid("1-5", 2), 0.1)
    player.animations.up = anim8.newAnimation(player.grid("1-3", 3), 0.3)
    player.animations.fight = anim8.newAnimation(player.grid("1-4", 5), 0.2)
    
    player.anim = player.animations.left

    background = love.graphics.newImage("images/grass.png")
end

function love.update(dt)
    local isMoving = false

    if love.keyboard.isDown("d") then
        player.anim = player.animations.right
        player.x = player.x + player.speed
        isMoving = true
    elseif love.keyboard.isDown("a") then
        player.anim = player.animations.left
        player.x = player.x - player.speed
        isMoving = true
    elseif love.keyboard.isDown("w") then
        player.anim = player.animations.up
        player.y = player.y - player.speed
        isMoving = true
    elseif love.keyboard.isDown("s") then
        player.anim = player.animations.down
        player.y = player.y + player.speed
        isMoving = true
    elseif love.keyboard.isDown("e") then
        player.anim = player.animations.fight
        isMoving = true
    end

    if isMoving == false then
        player.anim = player.animations.idle
    end

    player.anim:update(dt)
end

function love.draw()
    love.graphics.draw(background, 0, 0, nil, 3.2)
    player.anim:draw(player.spriteSheet, player.x, player.y, nil, 10)
end