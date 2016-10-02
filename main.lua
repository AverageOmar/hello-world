
function love.load()
  --set variables
  jump = 2.5
  alive = true
  rotate = 0
  score = 0
  
  --draw images and set to variables
  background= love.graphics.newImage("sprites/bg.png")
  backgroundQuad = love.graphics.newQuad(1,1,720/2,1280/2,720/2,1280/2)
  
  flappy = love.graphics.newImage("sprites/flappy.png")
  flappyPosY = 200
  
  flappyDead = love.graphics.newImage("sprites/flappydead.png")
  
  pipe = love.graphics.newImage("sprites/pipe.png")
  pipePosX = 300
  
  pipe2 = love.graphics.newImage("sprites/pipe2.png")
  pipe2PosX = pipePosX
  
  gameOver = love.graphics.newImage("sprites/game over.png")
end

function love.draw() -- draw screen
  love.graphics.draw(background, backgroundQuad, 0, 0)
  game_screen()
end

function reset() -- reset game
  flappyPosY = 200
  alive = true
  jump = 2.5
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
  love.graphics.draw(pipe, pipePosX, 500)
  
  if alive == true then
    love.graphics.draw(flappy, 125, flappyPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
  end
  if alive == false then
    love.graphics.draw(flappyDead, 125, flappyPosY)
  end
  
  love.graphics.draw(pipe2, pipe2PosX, 0)
  
  if alive == false then
    love.graphics.draw(gameOver, 90, 250)
  end
  
  love.graphics.print( "score is: "..score, 0, 0)
  
  --set pipe placement and movement
  if alive == true then
    pipePosX = pipePosX - 1.5
    pipe2PosX = pipe2PosX - 1.5
  end
  
  --jump and movement
  flappyPosY = flappyPosY + jump
  
  if flappyPosY < 600 then
    if jump < 15 then
      jump = jump + 0.2
    end
  end
  
  --rotation
  if rotate < 80 then
    rotate = rotate + 2
  end
  
  --collision and bounding boxes
  hitTest = CheckCollision(pipePosX, 500, 60, 150, 125, flappyPosY, 45, 45)
  if(hitTest) then
    alive = false
  end
  
  hitTest = CheckCollision(pipe2PosX, 0, 60, 150, 125, flappyPosY, 45, 45)
  if(hitTest) then
    alive = false
  end
  
  if flappyPosY > 600 or flappyPosY < 0 then
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
