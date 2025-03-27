return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- provider = "openai",
    provider = "claude",
    -- provider = "gemma3",
    cursor_applying_provider = "fastapply",
    behaviour = {
      enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },
    vendors = {
      gemma3 = {
        __inherited_from = "ollama",
        endpoint = "http://127.0.0.1:11434",
        -- model = "gemma3:27b",
        model = "PetrosStav/gemma3-tools:27b",
        disable_tools = false,
      },
      fastapply = {
        __inherited_from = "ollama",
        endpoint = "http://127.0.0.1:11434",
        model = "hf.co/Kortix/FastApply-7B-v1.0_GGUF:Q8_0",
        temperature = 0,
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    -- "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
