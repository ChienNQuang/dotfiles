-- WezTerm config — mirrors the old Ghostty look, fixes zellij's copy pain.
-- Stowed from ~/dotfiles/wezterm → ~/.config/wezterm/wezterm.lua
local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'
local config = wezterm.config_builder()

-- Launched from the Dock, WezTerm inherits Finder's bare PATH, so Homebrew
-- binaries are invisible to any program spawned with explicit args (which
-- skips the shell, and with it ~/.zshrc). Prepend the brew prefixes here.
config.set_environment_variables = {
  PATH = '/opt/homebrew/bin:/opt/homebrew/sbin:' .. (os.getenv 'PATH' or ''),
}

-- tabline.wez: lualine-style tab/status bar. Fetched + cached on first launch
-- (needs network once); updates via `wezterm.plugin.update_all()`.
local tabline = wezterm.plugin.require 'https://github.com/michaelbrusegard/tabline.wez'

-- ── Theme ─────────────────────────────────────────────────────────────
-- Matches Ghostty's "Gruvbox Dark Hard". Both names below are valid
-- builtin schemes; install step verifies which one resolves.
config.color_scheme = 'GruvboxDarkHard'

-- ── Font ──────────────────────────────────────────────────────────────
config.font = wezterm.font_with_fallback {
  'CaskaydiaMono Nerd Font Mono',
  'CaskaydiaCove Nerd Font Mono',
}
config.font_size = 14.0

-- ── Appearance (parity with Ghostty) ──────────────────────────────────
config.window_background_opacity = 0.75
config.macos_window_background_blur = 20
config.window_padding = { left = 12, right = 12, top = 12, bottom = 12 }
-- Frameless floating-glass look: the "it's a window" signal comes from
-- transparency + blur, not from chrome or a border.
config.window_decorations = 'RESIZE'
-- Tabs: styled by the tabline.wez plugin (lualine-style statusline,
-- GruvboxDark theme). apply_to_config() at the bottom enables the retro
-- tab bar; we leave it always-visible so the statusline modules show.
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.adjust_window_size_when_changing_font_size = false

-- Dim inactive split panes so the active one pops.
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.6 }

-- ── Behavior ──────────────────────────────────────────────────────────
config.window_close_confirmation = 'NeverPrompt' -- Ghostty: confirm-close-surface=false
-- Make ⌥ a real Alt/Meta (Ghostty: macos-option-as-alt=true) so Alt-keybinds work
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- ── Copy/paste (the whole reason we're here) ──────────────────────────
-- Native panes = no borders to accidentally select. Drag-select copies
-- straight to the macOS clipboard on mouse-up — no copy-mode dance.
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  -- ⌘-click opens hovered links without stealing normal selection
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SUPER',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

-- ── Panes / tabs / navigation ─────────────────────────────────────────
-- Cmd-driven, native (no escape-sequence hack). NOTE: binding ⌘h here
-- overrides macOS "Hide WezTerm" while WezTerm is focused — intentional,
-- it's the cost of vim-style ⌘hjkl pane nav. Say the word to remap.
local act = wezterm.action
config.keys = {
  -- Splits: ⌘d = side-by-side (right), ⌘⇧d = stacked (down). Inherit cwd.
  { key = 'd', mods = 'SUPER',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'SUPER|SHIFT', action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },

  -- Navigate panes: ⌘hjkl
  { key = 'h', mods = 'SUPER', action = act.ActivatePaneDirection 'Left'  },
  { key = 'j', mods = 'SUPER', action = act.ActivatePaneDirection 'Down'  },
  { key = 'k', mods = 'SUPER', action = act.ActivatePaneDirection 'Up'    },
  { key = 'l', mods = 'SUPER', action = act.ActivatePaneDirection 'Right' },

  -- Resize panes: ⌘⌃hjkl
  { key = 'h', mods = 'SUPER|CTRL', action = act.AdjustPaneSize { 'Left',  3 } },
  { key = 'j', mods = 'SUPER|CTRL', action = act.AdjustPaneSize { 'Down',  3 } },
  { key = 'k', mods = 'SUPER|CTRL', action = act.AdjustPaneSize { 'Up',    3 } },
  { key = 'l', mods = 'SUPER|CTRL', action = act.AdjustPaneSize { 'Right', 3 } },

  -- Zoom the active pane (tmux-style toggle): ⌘f
  { key = 'f', mods = 'SUPER', action = act.TogglePaneZoomState },

  -- Close the active pane (closes the window if it's the last one)
  { key = 'w', mods = 'SUPER', action = act.CloseCurrentPane { confirm = false } },

  -- Tabs: ⌘t new tab, ⌘n new window, ⌘⇧w close tab.
  { key = 't', mods = 'SUPER',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'n', mods = 'SUPER',       action = act.SpawnWindow },
  { key = 'w', mods = 'SUPER|SHIFT', action = act.CloseCurrentTab { confirm = false } },

  -- Switch tabs: ⌘1–9 jump by index, ⌘⇧[ / ⌘⇧] cycle prev/next.
  { key = '1', mods = 'SUPER', action = act.ActivateTab(0) },
  { key = '2', mods = 'SUPER', action = act.ActivateTab(1) },
  { key = '3', mods = 'SUPER', action = act.ActivateTab(2) },
  { key = '4', mods = 'SUPER', action = act.ActivateTab(3) },
  { key = '5', mods = 'SUPER', action = act.ActivateTab(4) },
  { key = '6', mods = 'SUPER', action = act.ActivateTab(5) },
  { key = '7', mods = 'SUPER', action = act.ActivateTab(6) },
  { key = '8', mods = 'SUPER', action = act.ActivateTab(7) },
  { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) }, -- last tab
  { key = '[', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(1) },

  -- ⌘e: open the current selection (or whole scrollback) in $EDITOR
  { key = 'e', mods = 'SUPER', action = act.EmitEvent 'edit-pane-in-editor' },
}

-- ⌘e handler: dump the selection (or full scrollback) to a temp file and
-- open it in $EDITOR in a new window. (WezTerm has no builtin for this — it's
-- the documented get_lines_as_text + EmitEvent recipe.)
wezterm.on('edit-pane-in-editor', function(window, pane)
  local sel = window:get_selection_text_for_pane(pane)
  local text = (sel and #sel > 0) and sel
    or pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)
  local name = os.tmpname()
  local f = assert(io.open(name, 'w+'))
  f:write(text)
  f:flush()
  f:close()
  window:perform_action(
    act.SplitPane {
      direction = 'Right',
      -- $EDITOR is unset in the GUI environment, so the fallback has to be an
      -- absolute path — a bare 'nvim' fails to resolve.
      command = { args = { os.getenv 'EDITOR' or '/opt/homebrew/bin/nvim', name } },
    },
    pane
  )
  wezterm.sleep_ms(1000) -- give the editor time to read before we delete
  os.remove(name)
end)

-- Put the session title (xpipe sets this to the connection name) in the
-- native title bar, so each window labels which host it's on.
wezterm.on('format-window-title', function(tab, _pane, _tabs, _panes, _config)
  return ' ' .. (tab.active_pane.title or '') .. ' '
end)

-- ── Tabline (status/tab bar) ──────────────────────────────────────────
-- GruvboxDark theme to match the GruvboxDarkHard color scheme above.
-- apply_to_config() must come after color_scheme is set.
tabline.setup {
  options = {
    icons_enabled = true,
    -- Match the GruvboxDarkHard color_scheme above (darker #1b1b1b bg).
    theme = 'GruvboxDarkHard',
    -- tabline defaults its accent to the scheme's ansi blue (#458588).
    -- Override it to Gruvbox's signature bright orange so the bar reads as
    -- Gruvbox, not blue. Covers the mode block, active tab, and the end caps
    -- on both sides (left mode / right domain share normal_mode colors).
    theme_overrides = {
      normal_mode = {
        a = { bg = '#fe8019' }, -- mode/end-cap block background
        b = { fg = '#fe8019' }, -- accent text on the surface segment
      },
      tab = {
        active = { fg = '#fe8019' }, -- active tab label
      },
    },
    section_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
    component_separators = {
      left = wezterm.nerdfonts.pl_left_soft_divider,
      right = wezterm.nerdfonts.pl_right_soft_divider,
    },
    tab_separators = {
      left = wezterm.nerdfonts.pl_left_hard_divider,
      right = wezterm.nerdfonts.pl_right_hard_divider,
    },
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'process', padding = { left = 0, right = 1 } },
    },
    tab_inactive = {
      'index',
      { 'process', padding = { left = 0, right = 1 } },
    },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = { 'datetime' },
    tabline_z = { 'domain' },
  },
}
tabline.apply_to_config(config)

return config
