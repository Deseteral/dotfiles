local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- Basic
config.default_cwd = wezterm.home_dir .. '/Developer'
config.color_scheme = 'flexoki-dark'

-- Font
config.font = wezterm.font('Berkeley Mono')
config.font_size = 15.0

-- Window config
config.use_resize_increments = true
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

-- Tab bar config
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = true

config.colors = {
    tab_bar = {
        background = '#1C1B1A', -- Flexoki base-950

        active_tab = {
            bg_color = '#66800B', -- Flexoki green-600
            fg_color = '#FFFCF0', -- Flexoki paper
            italic = true,
        },

        inactive_tab = {
            bg_color = '#6F6E69', -- Flexoki base-600
            fg_color = '#100F0F', -- Flexoki black
        },

        inactive_tab_hover = {
            -- TODO
            bg_color = '#878580', -- Flexoki base-500
            fg_color = '#100F0F', -- Flexoki black
        },
    },
}

wezterm.on(
    'format-tab-title',
    function(tab)
        local title = tab.active_pane.title
        local tab_title = tab.tab_title
        if tab_title and #tab_title > 0 then
            title = tab_title
        end
        return {
            { Text = ' ' .. title .. ' ' },
        }
    end
)

return config
