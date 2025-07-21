return {
  -- Go support
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimports = "gopls",
        gofmt = "gofumpt",
        max_line_len = 120,
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = true,
        dap_debug = true,
        dap_debug_keymap = true,
        dap_debug_gui = true,
        dap_debug_vt = true,
        build_tags = "tag1,tag2",
        textobjects = true,
        test_runner = "go",
        verbose_tests = true,
        run_in_floaterm = false,
        trouble = true,
        test_efm = false,
        luasnip = true,
      })
      
      -- Auto commands for Go
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimport()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    keys = {
      { "<leader>gsj", "<cmd>GoAddTag json<cr>", desc = "Add JSON tags" },
      { "<leader>gsy", "<cmd>GoAddTag yaml<cr>", desc = "Add YAML tags" },
      { "<leader>gst", "<cmd>GoAddTag toml<cr>", desc = "Add TOML tags" },
      { "<leader>gsJ", "<cmd>GoRmTag json<cr>", desc = "Remove JSON tags" },
      { "<leader>gsY", "<cmd>GoRmTag yaml<cr>", desc = "Remove YAML tags" },
      { "<leader>gsT", "<cmd>GoRmTag toml<cr>", desc = "Remove TOML tags" },
      { "<leader>gca", "<cmd>GoCodeAction<cr>", desc = "Code Action" },
      { "<leader>gce", "<cmd>GoIfErr<cr>", desc = "Add if err" },
      { "<leader>gch", "<cmd>GoCheat<cr>", desc = "Go Cheat Sheet" },
      { "<leader>gee", "<cmd>GoIfErr<cr>", desc = "Add if err" },
      { "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "Fill struct" },
      { "<leader>gfp", "<cmd>GoFixPlurals<cr>", desc = "Fix plurals" },
      { "<leader>gia", "<cmd>GoImpl<cr>", desc = "Go implement" },
      { "<leader>gic", "<cmd>GoCmt<cr>", desc = "Generate comment" },
      { "<leader>gid", "<cmd>GoDoc<cr>", desc = "Go doc" },
      { "<leader>gig", "<cmd>GoGenerate<cr>", desc = "Go generate" },
      { "<leader>gil", "<cmd>GoLint<cr>", desc = "Go lint" },
      { "<leader>gim", "<cmd>GoMake<cr>", desc = "Go make" },
      { "<leader>gin", "<cmd>GoNew<cr>", desc = "Go new" },
      { "<leader>gip", "<cmd>GoPkgOutline<cr>", desc = "Go package outline" },
      { "<leader>gir", "<cmd>GoRun<cr>", desc = "Go run" },
      { "<leader>gis", "<cmd>GoStop<cr>", desc = "Go stop" },
      { "<leader>git", "<cmd>GoTest<cr>", desc = "Go test" },
      { "<leader>giu", "<cmd>GoTestFunc<cr>", desc = "Go test function" },
      { "<leader>giv", "<cmd>GoVet<cr>", desc = "Go vet" },
      { "<leader>giw", "<cmd>GoWork<cr>", desc = "Go work" },
      { "<leader>gix", "<cmd>GoCoverage<cr>", desc = "Go coverage" },
      { "<leader>giy", "<cmd>GoAlt<cr>", desc = "Go alternate" },
      { "<leader>giz", "<cmd>GoAltS<cr>", desc = "Go alternate split" },
      { "<leader>gta", "<cmd>GoTestAdd<cr>", desc = "Add test" },
      { "<leader>gtA", "<cmd>GoTestsAll<cr>", desc = "Add all tests" },
      { "<leader>gtc", "<cmd>GoCoverage<cr>", desc = "Test coverage" },
      { "<leader>gte", "<cmd>GoTestsExp<cr>", desc = "Add exported tests" },
      { "<leader>gtf", "<cmd>GoTestFunc<cr>", desc = "Test function" },
      { "<leader>gtg", "<cmd>GoTestFile<cr>", desc = "Test file" },
      { "<leader>gts", "<cmd>GoTestSubCase<cr>", desc = "Test subcase" },
      { "<leader>gtt", "<cmd>GoTest<cr>", desc = "Go test" },
      { "<leader>gtv", "<cmd>GoTestPkg<cr>", desc = "Test package" },
      { "<leader>gtx", "<cmd>GoCoverage -t<cr>", desc = "Test coverage toggle" },
    },
  },

  -- Go debugging
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dap-go").setup({
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
          build_flags = "",
        },
      })
    end,
    keys = {
      { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go Test" },
      { "<leader>dgl", function() require("dap-go").debug_last_test() end, desc = "Debug Last Go Test" },
    },
  },
}