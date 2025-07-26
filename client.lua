lib.onReady(function()
    for appName, data in pairs(Config.Applications) do
        exports.ox_target:addBoxZone({
            coords = data.location,
            size = vec3(1, 1, 1),
            rotation = 0,
            debug = false,
            options = {
                {
                    label = 'Apply for: ' .. data.label,
                    icon = 'fa-solid fa-clipboard',
                    onSelect = function()
                        local inputs = {}

                        for i, question in ipairs(data.questions) do
                            table.insert(inputs, {
                                type = 'input',
                                label = question,
                                name = 'q' .. i
                            })
                        end

                        local result = lib.inputDialog(data.label, inputs)
                        if not result then return end

                        TriggerServerEvent('application:submit', appName, result)
                        lib.notify({ title = 'Application', description = 'Submitted successfully!', type = 'success' })
                    end
                }
            }
        })
    end
end)
