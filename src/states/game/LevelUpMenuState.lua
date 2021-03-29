
LevelUpMenuState = Class{__includes = BaseState}

function LevelUpMenuState:init(battleState)
    self.battleState = battleState
    self.playerPokemon = self.battleState.player.party.pokemon[1]

    self.initialHP = self.playerPokemon.HP
    self.initialAttack = self.playerPokemon.attack
    self.initialDefense = self.playerPokemon.defense
    self.initialSpeed = self.playerPokemon.speed

    local HPIncrease, attackIncrease, defenseIncrease, speedIncrease = self.playerPokemon:levelUp()

	self.finalHP = self.playerPokemon.HP
    self.finalAttack = self.playerPokemon.attack
    self.finalDefense = self.playerPokemon.defense
    self.finalSpeed = self.playerPokemon.speed    

    self.levelUpMenu = Menu {
        x = VIRTUAL_WIDTH - 160,
        y = VIRTUAL_HEIGHT - 128,
        width = 160,
        height = 128,
        viewableCursor = false,
        items = {
            {
                text = 'HP ' .. tostring(self.initialHP) .. " + " .. tostring(HPIncrease) .. " = " .. tostring(self.finalHP),
                onSelect = function()
                    gStateStack:pop()
                    gStateStack:push(FadeInState({
				        r = 255, g = 255, b = 255
				    }, 1, 
				    function()

				        -- resume field music
				        gSounds['victory-music']:stop()
				        gSounds['field-music']:play()
				        
				        -- pop off the battle state
				        gStateStack:pop()
				        gStateStack:push(FadeOutState({
				            r = 255, g = 255, b = 255
				        }, 1, function() end))
				    end))
                end
            },
            {
                text = 'Att ' .. tostring(self.initialAttack) .. " + " .. tostring(attackIncrease) .. " = " .. tostring(self.finalAttack)
            },
            {
                text = 'Def ' .. tostring(self.initialDefense) .. " + " .. tostring(defenseIncrease) .. " = " .. tostring(self.finalDefense)
            },
            {
                text = 'Spd ' .. tostring(self.initialSpeed) .. " + " .. tostring(speedIncrease) .. " = " .. tostring(self.finalSpeed)
            }
        }
    }
end

function LevelUpMenuState:update(dt)
    self.levelUpMenu:update(dt)
end

function LevelUpMenuState:render()
    self.levelUpMenu:render()
end