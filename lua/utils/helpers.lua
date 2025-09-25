local M = {}

function M.merge_plugins(...)
  local result = {}
  for _, plugins_list in ipairs({ ... }) do
    for _, plugin_element in ipairs(plugins_list) do
      table.insert(result, plugin_element)
    end
  end
  return result
end

return M
