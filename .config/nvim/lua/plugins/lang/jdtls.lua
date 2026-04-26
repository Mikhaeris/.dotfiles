return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    local function jdtls_attach()
      local jdtls = require("jdtls")

      -- 1. Project root
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }
      local root_dir = require("jdtls.setup").find_root(root_markers)
      if root_dir == "" or root_dir == nil then
        root_dir = vim.fn.getcwd()
      end

      -- 2. Workspace per project
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

      -- 3. Mason paths
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local jdtls_path = mason_path .. "/packages/jdtls"

      local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
      if launcher == "" then
        vim.notify("jdtls launcher jar не найден. Запусти :MasonInstall jdtls", vim.log.levels.ERROR)
        return
      end

      -- 4. Bundles: java-debug-adapter + java-test
      local bundles = {}
      local debug_jar =
        vim.fn.glob(mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
      if debug_jar ~= "" then
        table.insert(bundles, debug_jar)
      end

      local excluded_test_jars = {
        ["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
        ["jacocoagent.jar"] = true,
      }
      local test_jars = vim.split(
        vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true),
        "\n",
        { trimempty = true }
      )
      for _, jar in ipairs(test_jars) do
        if not excluded_test_jars[vim.fn.fnamemodify(jar, ":t")] then
          table.insert(bundles, jar)
        end
      end

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          launcher,
          "-configuration",
          jdtls_path .. "/" .. "config_linux",
          "-data",
          workspace_dir,
        },
        root_dir = root_dir,
        settings = {
          java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            references = { includeDecompiledSources = true },
            signatureHelp = { enabled = true },
            format = { enabled = true },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.mockito.Answers.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
        init_options = {
          bundles = bundles,
        },
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        on_attach = function(_, bufnr)
          -- DAP
          require("jdtls").setup_dap({ hotcodereplace = "auto" })
          require("jdtls.dap").setup_dap_main_class_configs()

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
          end

          -- Refactor / code
          map("n", "<leader>cjo", jdtls.organize_imports, "Java: organize imports")
          map("n", "<leader>cjv", jdtls.extract_variable, "Java: extract variable")
          map("n", "<leader>cjC", jdtls.extract_constant, "Java: extract constant")
          map("x", "<leader>cjm", function()
            jdtls.extract_method(true)
          end, "Java: extract method")

          -- Tests via DAP
          map("n", "<leader>djT", function()
            require("jdtls").test_class()
          end, "Java: test class")
          map("n", "<leader>djN", function()
            require("jdtls").test_nearest_method()
          end, "Java: test nearest")
        end,
      }

      jdtls.start_or_attach(config)
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("jdtls_lsp", { clear = true }),
      pattern = "java",
      callback = jdtls_attach,
    })
  end,
}
