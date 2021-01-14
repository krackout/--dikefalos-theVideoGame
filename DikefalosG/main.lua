-- Olos o kwdikas edw!

function love.load()
	love.window.setMode(1200, 650, {resizable=true, vsync=true, minwidth=320, minheight=200})
	love.window.setFullscreen(false, 'desktop')
	platos, ypsos = love.graphics.getDimensions( )
	love.window.setTitle('δικέφαλος')
	grammatoseira = love.graphics.newFont('pros8eta/GFSNicefore.otf', 30)
	love.graphics.setFont(grammatoseira)
	love.graphics.setBackgroundColor(0,0,0)
	canShoot = true
	canShootTimerMax = 0.2 
	canShootTimer = canShootTimerMax
	createEx8rosTimerMax = 0.4
	createEx8rosTimer = createEx8rosTimerMax
	sfaires = {}
	ex8roi = {}
	EinaiZwntanos = true
	score = 0
	TaxythtaEx8rou = 200
	DiakoptisTaxythtas = 1
	Hxos = true
	MeEfe = true
	gamestate = 'titlos'

--	Dikefalos = {x = platos/2, y = ypsos*0.8, speed = 250, img = love.graphics.newImage('pros8eta/Dikefalos.png')}
	Dikefalos = {img = love.graphics.newImage('pros8eta/Dikefalos.png'), speed = 250}
	Dikefalos.x = platos/2 - Dikefalos.img:getWidth()/2
	Dikefalos.y = ypsos*0.8 - Dikefalos.img:getHeight()/2
	p = love.graphics.newParticleSystem(Dikefalos.img, 64)
	p:setEmissionRate (20)
	p:setParticleLifetime(2,5)
	p:setPosition(155,165)
	p:setDirection(0)
	p:setSpread(20)
	p:setSpeed(10,30)
	p:setLinearAcceleration(-20, -20, 20, 20)
	p:setRadialAcceleration(10)
	p:setTangentialAcceleration(0)
	p:setSizes(1,1.05) -- καρδιοχτύπι
	p:setSizeVariation(0.5)
	p:setRotation(0)
	p:setSpin(0)
	p:setSpinVariation(0)
	p:setColors(255,255,0,240,255,255,0,10)
	p:stop()

	sfairaImg = love.graphics.newImage('pros8eta/AEK.png')
	--ex8rosImg = love.graphics.newImage('eikona.png') -- statiko shma
end


function love.draw(dt)
	if ypsos < 768 then
		love.graphics.scale(0.8)
	end   
	if gamestate == 'titlos' then
		love.graphics.setColor(255, 255, 0)
		love.graphics.print('πατηστε enter/return για να αρχισει το παιχνιδι',20,20)
		love.graphics.print('αν δεν θελετε ηχο πατηστε (s)',20,80)
		if Hxos then
			love.graphics.print('με ηχο',20,110)
		else
			love.graphics.print('χωρις ηχο',20,110)
		end
		love.graphics.print('αν δεν θελετε εφε στον δικεφαλο πατηστε (e)',20,170)
		if MeEfe then
			love.graphics.print('με εφε',20,200)
		else
			love.graphics.print('χωρις εφε',20,200)
		end
		love.graphics.print('κατα τη διαρκεια του παιχνιδιου',20,260)
		love.graphics.print('κρατωντας πατημενο το (Β)',20,290)
		love.graphics.print('πηγαινουν πιο αργα οι αντιπαλοι',20,320)
		love.graphics.print('ισχυει απαξ ανα παιχνιδι',20,350)

	elseif gamestate == 'play' then
		love.graphics.setBackgroundColor(0,60,0)
		ShmataEx8rwn = {'pros8eta/apollon.png','pros8eta/pas.png','pros8eta/xanthi.png','pros8eta/atromitos.png','pros8eta/gavros.png','pros8eta/vazelos.png','pros8eta/paok.png','pros8eta/panionios.png','pros8eta/ael.png','pros8eta/aris.png'}
		ex8rosImg = love.graphics.newImage(ShmataEx8rwn[math.random(#ShmataEx8rwn)])

		if EinaiZwntanos then
			if MeEfe then
				love.graphics.draw(p, Dikefalos.x, Dikefalos.y)
			else
				love.graphics.draw(Dikefalos.img, Dikefalos.x, Dikefalos.y)
			end
		else
			gamestate = 'terma'
		end

		for i, sfaira in ipairs(sfaires) do
			love.graphics.draw(sfaira.img, sfaira.x, sfaira.y)
		end

		for i, ex8ros in ipairs(ex8roi) do
			love.graphics.draw(ex8ros.img, ex8ros.x, ex8ros.y)
		end
		love.graphics.setColor(255, 255, 0)
		love.graphics.print('ηττημενοι: ' .. score, platos*0.01, ypsos*0.01)

		love.graphics.setColor(255, 255, 255)

	elseif gamestate == 'terma' then
		love.graphics.setBackgroundColor(0,0,0)
		love.graphics.setColor(255, 255, 0)
		love.graphics.print('ηττημενοι αντιπαλοι: '.. score, 20, 20)
		love.graphics.print('πατηστε (r) για το αρχικο μενου, (esc) για εξοδο',20,80)
	end
end


function love.update(dt)
	if gamestate == 'titlos' then
		-- tipota na kanei, pame parakatw

	elseif gamestate == 'play' then
		if MeEfe then
			p:start()
			p:update(dt)
		end

		if love.keyboard.isDown('left') then
			if Dikefalos.x > -Dikefalos.img:getWidth()/2 then -- binds to map
				Dikefalos.x = Dikefalos.x - (Dikefalos.speed*dt)
			end
		elseif love.keyboard.isDown('right') then
			if Dikefalos.x < (love.graphics.getWidth() + Dikefalos.img:getWidth()) then
				Dikefalos.x = Dikefalos.x + (Dikefalos.speed*dt)
			end
		end

		if love.keyboard.isDown('up') then
			if Dikefalos.y > 0 then
				Dikefalos.y = Dikefalos.y - (Dikefalos.speed*dt)
			end
		elseif love.keyboard.isDown('down') then
			if Dikefalos.y < (love.graphics.getHeight() + Dikefalos.img:getHeight()/2) then
				Dikefalos.y = Dikefalos.y + (Dikefalos.speed*dt)
			end
		end

		-- Time out how far apart our shots can be.
		canShootTimer = canShootTimer - (1 * dt)
		if canShootTimer < 0 then
			canShoot = true
		end

		if love.keyboard.isDown('space') and canShoot then
			NeaSfaira = {x = Dikefalos.x + (Dikefalos.img:getWidth()/2), y = Dikefalos.y, img = sfairaImg}

			if Hxos then
				sfairaBoom = love.audio.newSource('pros8eta/boom.ogg')
				sfairaBoom:play() --ίδιο με: love.audio.play(sfairaBoom)
			end

			table.insert(sfaires, NeaSfaira)
			canShoot = false
			canShootTimer = canShootTimerMax
		end

		-- enwmerwsh ths 8eshs twn sfairwn
		for i, sfaira in ipairs(sfaires) do
			sfaira.y = sfaira.y - (250 * dt)

			if sfaira.y < 0 then -- diagrafi sfairwn otan perasoun thn o8onh
				table.remove(sfaires, i)
			end
		end

		-- Time out sth dhmiourgia ex8rou
		createEx8rosTimer = createEx8rosTimer - (1 * dt)
		if createEx8rosTimer < 0 then
			createEx8rosTimer = createEx8rosTimerMax
			-- dhmiourgia ex8rou
			randomNumber = math.random(10, love.graphics.getWidth() - 10)
			newex8ros = {x = randomNumber, y = -10, img = ex8rosImg}
			table.insert(ex8roi, newex8ros)
		end

		-- enhmerwsh ths 8eshs twn ex8rwn
		for i, ex8ros in ipairs(ex8roi) do
			ex8ros.y = ex8ros.y + (TaxythtaEx8rou * dt)

			if ex8ros.y > 850 then -- apomakrynsh ex8rwn otan perasoun thn o8onh
				table.remove(ex8roi, i)
			end
		end

		if not EinaiZwntanos then
			gamestate = 'titlos'
		end

		-- collision detection
		-- Afou ex8roi < sfaires prwta autoi loop
		-- elegxos an oi ex8roi akoumphsan ton paikth
		for i, ex8ros in ipairs(ex8roi) do
			for j, sfaira in ipairs(sfaires) do
				if CheckCollision(ex8ros.x, ex8ros.y, ex8ros.img:getWidth(), ex8ros.img:getHeight(), sfaira.x, sfaira.y, sfaira.img:getWidth(), sfaira.img:getHeight()) then
					table.remove(sfaires, j)
					table.remove(ex8roi, i)
					score = score + 1
				end
			end

			if CheckCollision(ex8ros.x, ex8ros.y, ex8ros.img:getWidth(), ex8ros.img:getHeight(), Dikefalos.x, Dikefalos.y, Dikefalos.img:getWidth(), Dikefalos.img:getHeight())
			and EinaiZwntanos then
				table.remove(ex8roi, i)
				EinaiZwntanos = false
			end
		end
	elseif gamestate == 'terma' then
	end
end

function love.keypressed(k)
	if gamestate == 'titlos' then
		if k == 's' then
			Hxos = not Hxos
		end
		if k == 'e' then
			MeEfe = not MeEfe
		end
		if k == 'return' or k == 'enter' then
			gamestate = 'play'
		elseif k == 'escape' then
			love.event.quit()
		end
	elseif gamestate == 'play' then
		if k == 'b' and DiakoptisTaxythtas == 1 then
			TaxythtaEx8rou = 100
		end
		if k == 'escape' then
			love.event.quit()
		end
		
		-- quick kai poly dirty pause (sleep gia thn akriveia)
		if k == 'p' then
			love.timer.sleep( 20 )
		end
		
	elseif gamestate == 'terma' then
		if k == 'r' then
			--	love.event.quit('restart')
			love.load()
		elseif k == 'escape' or k == 'z' then
			love.event.quit()
		end
	end
end

function love.keyreleased(k)
	if k == 'b' then
		TaxythtaEx8rou = 200
		DiakoptisTaxythtas = 0
	end
end

function CheckCollision(x1,y1,w1,h1,x2,y2,w2,h2)
	return x1 < x2 + w2 and
	x2 < x1 + w1 and
	y1 < y2 + h2 and
	y2 < y1 + h1
end

--[[
Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
Returns true if two boxes overlap, false if they don't
x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
x2,y2,w2 & h2 are the same, but for the second box
--]]
