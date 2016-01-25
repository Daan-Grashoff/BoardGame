require 'lib.functions'
require 'lib.save-tables'
settings = {}

function settings:load()
	settings.config = {}
	config = table.load("settings.conf")
	for k,setting in pairs(config) do
		settings.config[k] = setting
	end
end

function settings:getConfig()
	return settings.config
end

function settings:getConfigByKey(key)
	return settings.config[key]
end

function settings:setConfig(key, value)
	settings.config[key] = value
	settings:save()
end

function settings:save()
	table.save(settings.config, "settings.conf")
end

return settings