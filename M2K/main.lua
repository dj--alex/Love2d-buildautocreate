function love.load()

  lg = love.graphics
  la = love.audio
  lr = love.math.random

  lg.setBackgroundColor(255,255,255)

  img = lg.newImage("Textures/0magic.png")
  snd = la.newSource("Sounds/ucf_-_real7ime_converterintro.xm","stream")
  snd2 = la.newSource("Sounds/zwuk1.mp3","stream")
  snd:setLooping(true)
  snd:play()

  w = lg.getWidth()
  h = lg.getHeight()
  iw = img:getWidth()
  ih = img:getHeight()

  x = w/2 - iw/2
  y = h/2 - ih/2

  dx = (lr(0,1)-.5)*2
  dy = (lr(0,1)-.5)*2

  speed = 200

  lg.setNewFont(h/25)

end

function love.update(dt)
  wouldx = x + dx*dt*speed
  wouldy = y + dy*dt*speed

  if wouldx + iw > w or wouldx < 0 then
    dx = dx * -1
  else
    x = wouldx
  end
  if wouldy + ih > h or wouldy < 0 then
    dy = dy * -1
  else
    y = wouldy
  end
end

function love.draw()
  lg.setColor(255,255,255)
  lg.draw(img,x,y)
  lg.setColor(0,0,0,150)
  lg.rectangle("fill",w/4,3*(h/8),w/2,h/4)
  lg.setColor(255,255,255)
  lg.printf("Start Gamedev thinks you forgot to replace the game.love file (m2ktest.lib)",w/4+w*.05,3.5*(h/8),w/2-w*.1,"center")
end

function love.mousepressed()
  snd2:stop()
  snd2:play()
end
