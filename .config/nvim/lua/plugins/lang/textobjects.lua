return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = false,
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local sel = require("nvim-treesitter-textobjects.select").select_textobject
    local mov = require("nvim-treesitter-textobjects.move")

    -- selection
    vim.keymap.set({ "x", "o" }, "af", function()
      sel("@function.outer", "textobjects")
    end, { desc = "Around function" })

    vim.keymap.set({ "x", "o" }, "if", function()
      sel("@function.inner", "textobjects")
    end, { desc = "Inside function" })

    vim.keymap.set({ "x", "o" }, "ac", function()
      sel("@class.outer", "textobjects")
    end, { desc = "Around class" })

    vim.keymap.set({ "x", "o" }, "ic", function()
      sel("@class.inner", "textobjects")
    end, { desc = "Inside class" })

    vim.keymap.set({ "x", "o" }, "ai", function()
      sel("@conditional.outer", "textobjects")
    end, { desc = "Around conditional" })

    vim.keymap.set({ "x", "o" }, "ii", function()
      sel("@conditional.inner", "textobjects")
    end, { desc = "Inside conditional" })

    vim.keymap.set({ "x", "o" }, "al", function()
      sel("@loop.outer", "textobjects")
    end, { desc = "Around loop" })

    vim.keymap.set({ "x", "o" }, "il", function()
      sel("@loop.inner", "textobjects")
    end, { desc = "Inside loop" })

    -- jump between objects (start)
    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      mov.goto_next_start("@function.outer", "textobjects")
    end, { desc = "Next function start" })

    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      mov.goto_previous_start("@function.outer", "textobjects")
    end, { desc = "Prev function start" })

    vim.keymap.set({ "n", "x", "o" }, "]c", function()
      mov.goto_next_start("@class.outer", "textobjects")
    end, { desc = "Next class start" })

    vim.keymap.set({ "n", "x", "o" }, "[c", function()
      mov.goto_previous_start("@class.outer", "textobjects")
    end, { desc = "Prev class start" })

    vim.keymap.set({ "n", "x", "o" }, "]i", function()
      mov.goto_next_start("@conditional.outer", "textobjects")
    end, { desc = "Next conditional start" })

    vim.keymap.set({ "n", "x", "o" }, "[i", function()
      mov.goto_previous_start("@conditional.outer", "textobjects")
    end, { desc = "Prev conditional start" })

    vim.keymap.set({ "n", "x", "o" }, "]l", function()
      mov.goto_next_start("@loop.outer", "textobjects")
    end, { desc = "Next loop start" })

    vim.keymap.set({ "n", "x", "o" }, "[l", function()
      mov.goto_previous_start("@loop.outer", "textobjects")
    end, { desc = "Prev loop start" })

    -- jump between objects (end)
    vim.keymap.set({ "n", "x", "o" }, "]F", function()
      mov.goto_next_end("@function.outer", "textobjects")
    end, { desc = "Next function end" })

    vim.keymap.set({ "n", "x", "o" }, "[F", function()
      mov.goto_previous_end("@function.outer", "textobjects")
    end, { desc = "Prev function end" })

    vim.keymap.set({ "n", "x", "o" }, "]C", function()
      mov.goto_next_end("@class.outer", "textobjects")
    end, { desc = "Next class end" })

    vim.keymap.set({ "n", "x", "o" }, "[C", function()
      mov.goto_previous_end("@class.outer", "textobjects")
    end, { desc = "Prev class end" })

    vim.keymap.set({ "n", "x", "o" }, "]I", function()
      mov.goto_next_end("@conditional.outer", "textobjects")
    end, { desc = "Next conditional end" })

    vim.keymap.set({ "n", "x", "o" }, "[I", function()
      mov.goto_previous_end("@conditional.outer", "textobjects")
    end, { desc = "Prev conditional end" })

    vim.keymap.set({ "n", "x", "o" }, "]L", function()
      mov.goto_next_end("@loop.outer", "textobjects")
    end, { desc = "Next loop end" })

    vim.keymap.set({ "n", "x", "o" }, "[L", function()
      mov.goto_previous_end("@loop.outer", "textobjects")
    end, { desc = "Prev loop end" })
  end,
}
