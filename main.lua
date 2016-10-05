
function love.load()
  --set variables
  jump = 2.5
  alive = true
  rotate = 0
  score = 0
  colour = love.math.random(0, 2)
  
  --draw images and set to variables
  background= love.graphics.newImage("sprites/bg.png")
  background2= love.graphics.newImage("sprites/bg.png")
  backgroundQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)
  background1X = 0
  background2X = 360
  
  flappy = love.graphics.newImage("sprites/flappy.png")
  flappyPosY = 200
  flappyDead = love.graphics.newImage("sprites/flappydead.png")
  
  flappyBlue = love.graphics.newImage("sprites/flappyBlue.png")
  flappyDeadBlue = love.graphics.newImage("sprites/flappydeadBlue.png")
  
  flappyYellow = love.graphics.newImage("sprites/flappyYellow.png")
  flappyDeadYellow = love.graphics.newImage("sprites/flappydeadYellow.png")
  
  ground = love.graphics.newImage("sprites/ground.png")
  ground2 = love.graphics.newImage("sprites/ground.png")
  groundQuad = love.graphics.newQuad(1, 1, 360, 640, 360, 281)
  groundX = 0
  ground2X = 360
  
  pipe = love.graphics.newImage("sprites/pipe.png")
  pipePosX = 300
  
  pipe2 = love.graphics.newImage("sprites/pipe2.png")
  pipe2PosX = pipePosX
  
  gameOver = love.graphics.newImage("sprites/game over.png")
end

function love.draw() -- draw screen
  love.window.setIcon(flappy)
  love.graphics.draw(background, backgroundQuad, background1X, 0)
  love.graphics.draw(background2, backgroundQuad, background2X, 0)
  game_screen()
end

function reset() -- reset game
  flappyPosY = 200
  alive = true
  jump = 2.5
  rotate = 0
  score = 0
  colour = love.math.random(0, 2)
  pipePosX = 300
  pipe2PosX = pipePosX
end

function flappyJump() --set the jump speed
  jump = -6.5
  rotate = -80
end

function love.keypressed(key) --keyboard input
  --set jump or reset
  if key == "space" and alive == true then
    flappyJump()
  end
  if key == "space" and alive == false then
    reset()
  end
  
end

function game_screen()
  --create character image variables
  love.graphics.draw(pipe, pipePosX, 350)
  love.graphics.draw(pipe2, pipe2PosX, 0)
  
  --draw the floor
  love.graphics.draw(ground, groundQuad, groundX, 500)
  love.graphics.draw(ground2, groundQuad, ground2X, 500)
  
  if colour == 0 then
    if alive == true then
      love.graphics.draw(flappy, 125, flappyPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
    end
    if alive == false then
      love.graphics.draw(flappyDead, 125, flappyPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
    end
  end
  
  if colour == 1 then
    if alive == true then
      love.graphics.draw(flappyBlue, 125, flappyPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
    end
    if alive == false then
      love.graphics.draw(flappyDeadBlue, 125, flappyPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
    end
  end
  
  if colour == 2 then
    if alive == true then
      love.graphics.draw(flappyYellow, 125, flappyPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
    end
    if alive == false then
      love.graphics.draw(flappyDeadYellow, 125, flappyPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
    end
  end
  
  if alive == false then
    love.graphics.draw(gameOver, 90, 250)
    love.graphics.print( "You scored "..score.." points", 120, 320)
  end
  
  if alive == true then
    --moving floor
    groundX = groundX - 1.5
    ground2X = ground2X - 1.5
  
    if groundX < -359 then
      groundX = 360
    end
    if ground2X < -359 then
      ground2X = 360
    end
  
    --moving background
    background1X = background1X - 1.5
    background2X = background2X - 1.5
  
    if background1X < -359 then
      background1X = 360
    end
    if background2X < -359 then
      background2X = 360
    end
  end
  
  --set pipe placement and movement
  if alive == true then
    --write text
    love.graphics.print( "score is: "..score, 0, 0)
    
    pipePosX = pipePosX - 1.5
    pipe2PosX = pipe2PosX - 1.5
  end
  
  --jump and movement
  flappyPosY = flappyPosY + jump
  
  if flappyPosY < 700 then
    if jump < 15 then
      jump = jump + 0.2
    end
  end
  
  --rotation
  if rotate < 80 then
    rotate = rotate + 2
  end
  
  --collision and bounding boxes
  hitTest = CheckCollision(125, flappyPosY, 45, 45, groundX, 550, 360, 281)
  if(hitTest) then
    alive = false
    jump = 0
  end
  
  hitTest = CheckCollision(125, flappyPosY, 45, 45, ground2X, 550, 360, 281)
  if(hitTest) then
    alive = false
    jump = 0
  end
  
  hitTest = CheckCollision(pipePosX, 350, 60, 150, 125, flappyPosY, 22.5, 22.5)
  if(hitTest) then
    alive = false
  end
  
  hitTest = CheckCollision(pipe2PosX, 0, 60, 150, 125, flappyPosY, 22.5, 22.5)
  if(hitTest) then
    alive = false
  end
  
  if flappyPosY < -22 then
    alive = false
  end
  
  if flappyPosY > 600 then
    alive = false
    jump = 0
  end
  
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
