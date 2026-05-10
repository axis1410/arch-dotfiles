---@type Base46Table
local M = {}

-- Base46 theme configuration
M.base46 = {
  -- theme: Colorscheme name (see :Telescope themes for available themes)
  theme = "tomorrow_night",
  -- theme_toggle: Pair of themes for toggling light/dark mode
  --   First value should match the theme above
  theme_toggle = { "tomorrow_night", "one_light" },
  -- transparency: Enable transparent background for some components
  transparency = true,
  -- integrations: Enable highlight support for these plugins
  --   Available: blink, cmp, conform, diffview, flash, git, gitsigns,
  --              indentline, lazy, mason, navic, noice, notify, nvimtree,
  --              outline, snacks, spectacle, telescope, trouble, whichkey
  integrations = {
    "blink",
    "diffview",
    "flash",
    "git",
    "notify",
    "trouble",
  },
  excluded = {
    "cmp",
  },

  changed_themes = {
    -- vesper = {
    --   base_30 = {
    --     darker_black = "#1e1e1e",
    --     black = "#262626",
    --     black2 = "#2e2e2e",
    --     one_bg = "#353535",
    --     one_bg2 = "#3a3a3a",
    --     one_bg3 = "#464646",
    --     statusline_bg = "#2e2e2e",
    --     lightbg = "#3a3a3a",
    --     line = "#3a3a3a",
    --   },
    --   base_16 = {
    --     base00 = "#262626",
    --     base01 = "#2e2e2e",
    --     base02 = "#353535",
    --   },
    -- },
  },

  hl_override = {
    CursorLine   = { bg = "#2E2E2E" },
    CursorLineNr = { bold = true },
    Visual       = { bg = "#3A3A3A" },
    PmenuSel     = { bold = true },
    Search       = { bold = true, underline = true },
    IncSearch    = { reverse = true, bold = true },
  },
}

M.ui = {
  cmp = {
    -- icons_left: Place LSP kind icons on left side of completion text
    --   (only applies to non-atom styles)
    icons_left = false,
    -- style: Completion popup appearance
    --   - default:      Standard bordered popup
    --   - flat_light:   Flat design with light background
    --   - flat_dark:    Flat design with dark background (recommended for dark themes)
    --   - atom:         Atom/VS Code style single-line
    --   - atom_colored: Atom style with colored icons
    style = "atom_colored",
    -- format_colors: How to display colors in completion menu
    --   - lsp:   Show colors from tailwind/css/astro LSP servers
    --   - icon:  Icon prefix for color swatches (default: 󱓻)
    format_colors = { lsp = true, icon = "󱓻" },
  },
  -- telescope: Telescope picker appearance
  --   - style:
  --       - borderless: No borders, cleaner look
  --       - bordered:   Classic bordered look
  telescope = { style = "bordered" },
  -- statusline: Bottom status bar

  statusline = {
    -- enabled: Enable NvChad statusline
    enabled = true,
    -- theme: Statusline layout
    --   - default: Standard NvChad layout
    --   - vscode: VS Code-like layout
    --   - vscode_colored: VS Code-like layout with more color accents
    --   - minimal: Smaller layout, less visual noise
    theme = "minimal",
    -- separator_style: Section separators
    --   - default: Standard separators
    --   - round: Rounded separators
    --   - block: Block separators
    --   - arrow: Arrow separators
    --   - { left = "...", right = "..." }: Custom separators
    --   Note: default/round/block/arrow work only with `default` theme.
    --   `minimal` supports only `round` and `block`.
    separator_style = "round",
    modules = {
      filepath = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then
          return ""
        end

        path = vim.fn.fnamemodify(path, ":~:.")

        return "%#" .. (vim.bo.modified and "StFilePathModified" or "StFilePath") .. "# " .. path .. " "
      end,
    },

    order = {
      "mode",
      "file",
      "filepath",
      "git",
      "%=",
      "lsp",
      "diagnostics",
      "cwd",
      "cursor",
    },
  },

  -- tabufline: Tab/buffer line (tabs + buffer manager)
  tabufline = {
    -- enabled: Enable the tabufline plugin
    enabled = true,
    -- lazyload: Delay loading until 2+ buffers open (faster startup)
    lazyload = false,
    -- bufwidth: Width of buffer name tabs (in characters)
    bufwidth = 26,
  },
}

-- Dashboard (Nvdash) configuration
M.nvdash = {
  -- load_on_startup: Open dashboard on Neovim launch
  load_on_startup = true,
  -- header: ASCII art header (each string = one line)
  header = {
    "                            ",
    "    ▄▄   ▄▄      ▄▄   ▄▄    ",
    "    ███▄███     ███▄ ███    ",
    "    ██▀█▀██     ██ █▄███    ",
    "    ██   ██     ██  ▀███    ",
    "    ▀▀   ▀▀     ▀▀   ▀▀▀    ",
    "                            ",
    "      󰕮  Vim btw            ",
    "                            ",
  },
  -- buttons: Dashboard action buttons
  --   - txt:   Button text (supports icons via 󰕮 etc.)
  --   - keys:  Keymap to trigger (space-separated, e.g. 'Spc f f')
  --   - cmd:   Command to execute
  --   - hl:    Highlight group for the button text
  --   - no_gap: Remove empty line before this button
  --   - rep:   Repeat the text to fill available space (for separators like '─')
  --   - content: 'fit' = auto-size to available width (for dynamic content)
  buttons = {
    { txt = "  Find File", keys = "Spc f f", cmd = "FzfLua files" },
    { txt = "󰈞  Live Grep", keys = "Spc f g", cmd = "FzfLua live_grep_native" },
    { txt = "  Recent Files", keys = "Spc f o", cmd = "FzfLua oldfiles" },
    { txt = "󰱼  Buffers", keys = "Spc Spc", cmd = "FzfLua buffers" },
    { txt = "  File Explorer", keys = "-", cmd = "Oil" },
    { txt = "󰏘  Themes", keys = "Spc t h", cmd = 'lua require("nvchad.themes").open({ style = "bordered" })' },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
      content = "fit",
    },
    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

-- Cheatsheet configuration (NvCheatsheet)
M.cheatsheet = {
  -- theme: Cheatsheet display layout
  --   - grid:    Grid layout with categories
  --   - simple:  Simple collapsed list
  theme = "grid",
}

-- LSP configuration
M.lsp = {
  -- signature: Show function signature help as you type
  signature = false,
}

-- Color picker/highlighter (colorify plugin)
M.colorify = {
  -- enabled: Enable live color preview for hex codes
  enabled = true,
  -- mode: How to display colors
  --   - virtual: Overlay colored text (non-destructive)
  --   - fg:      Change text foreground color
  --   - bg:      Change text background color
  mode = "virtual",
  -- virt_text: Prefix for color swatches in virtual mode
  virt_text = "󱓻 ",
  -- highlight: What to highlight
  --   - hex:      Highlight hex color codes (#fff, #ffffff)
  --   - lspvars:  Highlight LSP variable references
  highlight = { hex = true, lspvars = true },
}

return M