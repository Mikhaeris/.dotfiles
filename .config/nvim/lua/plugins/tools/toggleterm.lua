local HTERM_MAX = 20
local FLOAT_ID = 50
local PRESET_BASE = 70

local function TT()
  return require("toggleterm.terminal")
end

local function all_hterms()
  local list = {}
  for _, t in pairs(TT().get_all()) do
    if t.direction == "horizontal" then
      list[#list + 1] = t
    end
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)
  return list
end

local function close_hterms()
  for _, t in ipairs(all_hterms()) do
    if t:is_open() then
      t:close()
    end
  end
end

local function open_hterm(id, size)
  close_hterms()
  local t = TT().get(id) or TT().Terminal:new({ id = id, direction = "horizontal" })
  t:open(size)
end

local function cycle_hterm(delta)
  local list = all_hterms()
  if #list == 0 then
    return open_hterm(1)
  end

  local idx = 1
  for i, t in ipairs(list) do
    if t.id == vim.b.toggle_number then
      idx = i
      break
    end
  end

  open_hterm(list[((idx - 1 + delta) % #list) + 1].id)
end

local function next_free_id()
  for i = 1, HTERM_MAX do
    if not TT().get(i) then
      return i
    end
  end
  vim.notify("Horizontal terminal limit reached", vim.log.levels.WARN)
end

local function open_float()
  local t = TT().get(FLOAT_ID) or TT().Terminal:new({ id = FLOAT_ID, direction = "float" })
  t:toggle()
end

local presets = {
  { key = "g", label = "lazygit", cmd = "lazygit", direction = "float" },
  { key = "b", label = "btop", cmd = "btop", direction = "float" },
  { key = "p", label = "python", cmd = "python3", direction = "horizontal", size = 14 },
  { key = "n", label = "node", cmd = "node", direction = "horizontal", size = 14 },
}

local function open_preset(i)
  local p = presets[i]
  local id = PRESET_BASE + i
  local t = TT().get(id)
    or TT().Terminal:new({
      id = id,
      cmd = p.cmd,
      direction = p.direction,
      display_name = p.label,
    })

  if p.direction == "horizontal" then
    close_hterms()
    t:open(p.size)
  else
    t:toggle()
  end
end

local function pick_terminal()
  local list = {}
  for _, t in pairs(TT().get_all()) do
    list[#list + 1] = t
  end
  table.sort(list, function(a, b)
    return a.id < b.id
  end)

  if #list == 0 then
    return open_hterm(1)
  end

  vim.ui.select(list, {
    prompt = "Terminals",
    format_item = function(t)
      return string.format("[%d] %-10s (%s)", t.id, t.display_name or "term", t.direction)
    end,
  }, function(t)
    if not t then
      return
    end
    if t.direction == "horizontal" then
      open_hterm(t.id)
    else
      t:toggle()
    end
  end)
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = function()
    local keys = {
      { "<leader>tf", open_float, desc = "Float terminal" },
      {
        "<leader>tn",
        function()
          local id = next_free_id()
          if id then
            open_hterm(id)
          end
        end,
        desc = "New terminal",
      },
      {
        "<leader>th",
        function()
          cycle_hterm(-1)
        end,
        desc = "Prev terminal",
      },
      {
        "<leader>tl",
        function()
          cycle_hterm(1)
        end,
        desc = "Next terminal",
      },
      { "<leader>tt", pick_terminal, desc = "Terminal picker" },
    }

    for i = 1, 5 do
      keys[#keys + 1] = {
        "<leader>t" .. i,
        function()
          open_hterm(i)
        end,
        desc = "Terminal #" .. i,
      }
    end

    for i, p in ipairs(presets) do
      keys[#keys + 1] = {
        "<leader>tp" .. p.key,
        function()
          open_preset(i)
        end,
        desc = "Preset: " .. p.label,
      }
    end

    return keys
  end,
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return math.floor(vim.o.lines * 0.30)
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.40)
      end
    end,

    open_mapping = false,
    shade_terminals = false,
    persist_size = true,
    persist_mode = true,
    close_on_exit = true,
    auto_scroll = true,
    start_in_insert = true,
    direction = "horizontal",

    float_opts = {
      border = "curved",
      width = math.floor(vim.o.columns * 0.85),
      height = math.floor(vim.o.lines * 0.80),
    },

    on_create = function(term)
      local opts = { buffer = term.bufnr, noremap = true, silent = true }
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
      vim.keymap.set("n", "q", "<cmd>close<CR>", vim.tbl_extend("force", opts, { desc = "Hide terminal" }))
    end,
  },
}
