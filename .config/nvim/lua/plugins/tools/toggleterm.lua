local HTERM_START = 1
local HTERM_END = 20

local FTERM_START = 50
local FTERM_END = 69

local PRESET_START = 70

local function TT()
  return require("toggleterm.terminal")
end

local function get_term(id)
  return TT().get(id)
end

local function new_terminal(opts)
  return TT().Terminal:new(opts)
end

local function active_terms_in(a, b)
  local ids = {}
  for id = a, b do
    if get_term(id) then
      ids[#ids + 1] = id
    end
  end
  return ids
end

local function close_all_hterms()
  for id = HTERM_START, HTERM_END do
    local t = get_term(id)
    if t and t:is_open() then
      t:close()
    end
  end
end

local function open_hterm(id, size)
  close_all_hterms()

  local t = get_term(id)
  if not t then
    t = new_terminal({
      id = id,
      direction = "horizontal",
      size = size,
    })
  end

  t:open()
end

local function open_float(id)
  local t = get_term(id)
  if not t then
    t = new_terminal({
      id = id,
      direction = "float",
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * 0.85),
        height = math.floor(vim.o.lines * 0.80),
        winblend = 0,
      },
    })
  end
  t:toggle()
end

local function next_free_hterm()
  for id = HTERM_START, HTERM_END do
    if not get_term(id) then
      return id
    end
  end
  vim.notify("The limit for horizontal terminals has been reached", vim.log.levels.WARN)
end

local function cycle_hterm(delta)
  local ids = active_terms_in(HTERM_START, HTERM_END)
  if #ids == 0 then
    open_hterm(HTERM_START)
    return
  end

  local current = vim.b.toggle_number
  local cur_pos = 1

  for i, id in ipairs(ids) do
    if id == current then
      cur_pos = i
      break
    end
  end

  local next_pos = ((cur_pos - 1 + delta) % #ids) + 1
  local next_id = ids[next_pos]

  open_hterm(next_id)
end

local presets = {
  { id = PRESET_START, label = "lazygit", cmd = "lazygit", direction = "float", key = "g" },
  { id = PRESET_START + 1, label = "btop", cmd = "btop", direction = "float", key = "b" },
  { id = PRESET_START + 2, label = "python", cmd = "python3", direction = "horizontal", key = "p", size = 14 },
  { id = PRESET_START + 3, label = "node", cmd = "node", direction = "horizontal", key = "n", size = 14 },
}

return {
  "akinsho/toggleterm.nvim",
  version = "*",

  keys = function()
    local keys = {}

    for i = 1, 5 do
      keys[#keys + 1] = {
        "<leader>t" .. i,
        function()
          open_hterm(i)
        end,
        mode = { "n", "t" },
        desc = "Terminal #" .. i,
      }
    end

    keys[#keys + 1] = {
      "<leader>tf",
      function()
        open_float(FTERM_START)
      end,
      mode = { "n", "t" },
      desc = "Float terminal",
    }

    keys[#keys + 1] = {
      "<leader>tn",
      function()
        local id = next_free_hterm()
        if id then
          open_hterm(id)
        end
      end,
      mode = { "n", "t" },
      desc = "New terminal",
    }

    keys[#keys + 1] = {
      "<leader>th",
      function()
        cycle_hterm(-1)
      end,
      mode = { "n", "t" },
      desc = "Prev terminal",
    }

    keys[#keys + 1] = {
      "<leader>tl",
      function()
        cycle_hterm(1)
      end,
      mode = { "n", "t" },
      desc = "Next terminal",
    }

    keys[#keys + 1] = {
      "<leader>tt",
      function()
        local all_ids = active_terms_in(HTERM_START, HTERM_END)

        for _, p in ipairs(presets) do
          if get_term(p.id) then
            all_ids[#all_ids + 1] = p.id
          end
        end

        if #all_ids == 0 then
          open_hterm(HTERM_START)
          return
        end

        local items = {}
        for _, id in ipairs(all_ids) do
          local t = get_term(id)
          local name = t and t.display_name or ("#" .. id)
          local dir = t and t.direction or "?"
          items[#items + 1] = {
            id = id,
            label = string.format("[%d] %-10s (%s)", id, name, dir),
          }
        end

        vim.ui.select(items, {
          prompt = "Terminals",
          format_item = function(item)
            return item.label
          end,
        }, function(choice)
          if not choice then
            return
          end

          local t = get_term(choice.id)
          if t then
            if t.direction == "horizontal" then
              open_hterm(choice.id)
            else
              t:toggle()
            end
          end
        end)
      end,
      desc = "Terminal picker",
    }

    for _, p in ipairs(presets) do
      keys[#keys + 1] = {
        "<leader>tp" .. p.key,
        function()
          local t = get_term(p.id)
          if not t then
            t = new_terminal({
              id = p.id,
              cmd = p.cmd,
              direction = p.direction,
              display_name = p.label,
              size = p.size,
              float_opts = p.direction == "float" and {
                border = "curved",
                width = math.floor(vim.o.columns * 0.88),
                height = math.floor(vim.o.lines * 0.82),
              } or nil,
              on_exit = function()
                vim.notify(p.label .. " completed", vim.log.levels.INFO)
              end,
            })
          end

          if p.direction == "horizontal" then
            open_hterm(p.id, p.size)
          else
            t:toggle()
          end
        end,
        mode = { "n", "t" },
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
    direction = "horizontal",
    start_in_insert = true,

    float_opts = {
      border = "curved",
      width = math.floor(vim.o.columns * 0.85),
      height = math.floor(vim.o.lines * 0.80),
      winblend = 0,
    },

    on_create = function(term)
      local opts = { buffer = term.bufnr, noremap = true, silent = true }
      vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
      vim.keymap.set("t", "<leader>tq", "<C-\\><C-n><cmd>close<CR>", opts)
    end,
  },
}
