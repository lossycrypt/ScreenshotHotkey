--TODO: make invisible cursor box (copy "make_cursor_box" function to make util sprites).

local CONST = require 'control/constants'


local asset = function(path) return (CONST.MOD_ROOT..'assets/'..path):gsub('/+','/') end


local ICONS_96 = {{
  icon     = asset 'camera.png',
  icon_size = 96,
  }}
  
local SPRITE_96 = {
  filename = asset 'camera.png',
  size = 96,
  }

-- -------------------------------------------------------------------------- --
-- Hotkey                                                                     --
-- -------------------------------------------------------------------------- --

data:extend{{ type = 'custom-input',
  name = CONST.ITEM_NAME,
  key_sequence = 'PRINTSCREEN',
  -- key_sequence = 'F12',
  order = 'a',
  localised_name = {'shortcut-name.er:screenshot-camera'},
  }}

-- -------------------------------------------------------------------------- --
-- Shortcut                                                                   --
-- -------------------------------------------------------------------------- --

data:extend{{
  type = 'shortcut',
  name = CONST.ITEM_NAME,
  -- action = 'create-blueprint-item',
  action = 'lua',
  -- item_to_create = CONST.ITEM_NAME,
  associated_control_input = CONST.ITEM_NAME,
  icon = SPRITE_96,
  toggleable = true,
  }}

-- -------------------------------------------------------------------------- --
-- Sound                                                                      --
-- -------------------------------------------------------------------------- --

data:extend{{
  type = "sound",
  name = 'er:camera-click',
  variations = {
    {filename = asset '/camera-click.ogg'},
    },
  volume = 1
	}}

data:extend{{
  type = "sound",
  name = 'er:gui-switch-click',
  variations = {{
    filename = "__core__/sound/gui-switch.ogg",
    -- volume = 1,
    -- preload = false,
    }},
  -- filename = "__core__/sound/gui-switch.ogg",
  -- volume = 1
  audible_distance_modifier = 1,
	}}
  
  
  
-- -------------------------------------------------------------------------- --
-- Item                                                                       --
-- -------------------------------------------------------------------------- --

  
-- for _,control in pairs{
--   -- 'rotate',
--   -- 'build','mine',
--   -- 'open-gui',
--   -- 'move-down','move-left','move-right','move-up',
--   'clean-cursor',
--   } do
--   local name = 'er:controls:'..control
--   if not (data.raw['custom-input'] and data.raw['custom-input'][name]) then
--     data:extend{{
--       type                = 'custom-input' ,
--       name                = name           ,
--       key_sequence        = ''             , --nil is invalid
--       linked_game_control = control        }}
--     end
--   end


--[[
data:extend{{
  -- This allows loading the selection-tool type item when mods are removed
  type = 'selection-tool',
  name = CONST.ITEM_NAME .. '-2',
  -- localised_name = {'item-name.blueprint'},
  icon = asset '/camera.png',
  icon_size = 96,
  -- flags = {'goes-to-quickbar', 'hidden'}, --0.16
  flags = {'hidden','only-in-cursor'}, --0.17
  -- subgroup = 'tool',
  -- order = 'c[automated-construction]-a[blueprint]',
  stack_size = 1,
  stackable = false,
  selection_color = { r = 0, g = 0, b = 0 },
  alt_selection_color = { r = 1, g = 1, b = 1 , a = 0}, --alt mode invisible == disabled
  -- Valid values are: blueprint, deconstruct, cancel-deconstruct, items, trees, buildable-type, tiles, items-to-place, any-entity, any-tile, matches-force
  -- selection_mode = {'blueprint'},
  -- alt_selection_mode = {'blueprint'},
  selection_mode = {'any-entity'},
  alt_selection_mode = {'any-entity'},
  selection_cursor_box_type = 'copy',
  alt_selection_cursor_box_type = 'copy',
  show_in_library = false
  }}
--]]



data:extend{{
  type = 'capsule',
  name = CONST.ITEM_NAME,
  -- flags = {"hidden", "only-in-cursor", "spawnable"},
  flags = {"hidden", "only-in-cursor","not-stackable"}, --not stackable flag removes stack size number! :D
  -- draw_label_for_cursor_render = false,
  mouse_cursor = "selection-tool-cursor",
  icons = ICONS_96,
  radius_color = {a=0}, -- don't show the radius
  stack_size = 1, -- abuse stacksize to show selection size?
  stackable = false,
  capsule_action = {
    type = 'throw',
    uses_stack = false,
    attack_parameters = {
      type = 'projectile',
      range = 1e7,
      cooldown = 2, -- 33 milliseconds
      ammo_type = {
        category = 'melee',
        }
      },
    }
  }}

  
--[[
-- Artillery shows artillery-turrents-in-range count and errors if that's 0
  
data:extend{{
  type = 'capsule',
  name = CONST.ITEM_NAME,
  -- flags = {"hidden", "only-in-cursor", "spawnable"},
  flags = {"hidden", "only-in-cursor","not-stackable"}, --not stackable flag removes stack size number! :D
  -- draw_label_for_cursor_render = false,
  mouse_cursor = "selection-tool-cursor",
  icons = ICONS_96,
  radius_color = {a=0}, -- don't show the radius
  stack_size = 1, -- abuse stacksize to show selection size?
  stackable = false,
  capsule_action = {
    type = "artillery-remote", -- artillery type can be used from map
    flare = "artillery-flare-2"
    },
  }}

data:extend{{
    type = "artillery-flare",
    name = "artillery-flare-2",
    icon = "__base__/graphics/icons/artillery-targeting-remote.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-off-grid", "not-on-map"},
    map_color = {r=1, g=0.5, b=0},
    -- life_time = 60 * 60,
    life_time = 0,
    initial_height = 0,
    initial_vertical_speed = 0,
    initial_frame_speed = 1,
    -- shots_per_flare = 1,
    shots_per_flare = 0,
    -- early_death_ticks = 3 * 60,
    early_death_ticks = 0,
    pictures =
    {
      {
        filename = "__core__/graphics/shoot-cursor-red.png",
        priority = "low",
        width = 258,
        height = 183,
        frame_count = 1,
        scale = 1,
        flags = {"icon"}
      },
      --{
      --  filename = "__base__/graphics/entity/sparks/sparks-02.png",
      --  width = 36,
      --  height = 32,
      --  frame_count = 19,
      --  line_length = 19,
      --  shift = {0.03125, 0.125},
      --  tint = { r = 1.0, g = 0.9, b = 0.0, a = 1.0 },
      --  animation_speed = 0.3,
      --}
    }
  }}
--]]


data:extend{{
  type = "font",
  name = "er:selection-rectangle-label-font",
  from = "default-semibold",
  size = 32,
  }}
  
  
data:extend{{
  key_sequence                 = ''                                ,
  action                       = nil                               ,
  alternative_key_sequence     = nil                               ,
  consuming                    = nil                               ,
  enabled                      = true                              ,
  enabled_while_in_cutscene    = false                             ,
  enabled_while_spectating     = false                             ,
  item_to_create               = nil                               ,
  linked_game_control          = 'mine'                            ,
  name                         = CONST.EVENT.RIGHT_CLICK           ,
  type                         = 'custom-input'                    ,
  localised_description        = nil                               ,
  localised_name               = nil ,
  order                        = 'a'                               ,
  }}

data:extend{{
  key_sequence                 = ''                       ,
  enabled                      = true                     ,
  linked_game_control          = 'rotate'                 ,
  name                         = CONST.EVENT.ROTATE_RIGHT ,
  type                         = 'custom-input'           ,
  order                        = 'z1'                     ,
  }}
data:extend{{
  key_sequence                 = ''                       ,
  enabled                      = true                     ,
  linked_game_control          = 'reverse-rotate'         ,
  name                         = CONST.EVENT.ROTATE_LEFT  ,
  type                         = 'custom-input'           ,
  order                        = 'z1'                     ,
  }}
  

local styles = data.raw['gui-style'].default
  
styles['er:screenshot-gui-status-table'] = {
  type = 'table_style',
  parent = nil,
  column_widths = {
    {column = 1, width = (256 - 24) / 2}, -- 116
    {column = 2, width = (256 - 24) / 2},
    },
  column_alignments = {
    {column = 1, alignment = 'middle-left'  },
    {column = 2, alignment = 'middle-center'},
    }
  }

styles['er:screenshot-gui-advanced-option-table'] = {
  type = 'table_style',
  parent = nil,
  column_widths = {
    -- {column = 1, width = (256 - 24) / 2}, -- 116
    -- {column = 2, width = (256 - 24) / 2},
    {column = 1, width = (256 - 24) - 140}, -- 116
    {column = 2, width = 140},
    },
  column_alignments = {
    -- {column = 1, alignment = 'middle-center'},
    {column = 1, alignment = 'middle-left'},
    {column = 2, alignment = 'middle-center'},
    }
  }
  
-- -------------------------------------------------------------------------- --
-- Aligned Switch Style                                                       --
-- -------------------------------------------------------------------------- --
  
styles['er:screenshot-gui-aligned-switch-table'] = {
  type = 'table_style',
  parent = nil,
  -- width = (256 - 24) / 2,
  -- width = 
  column_widths = {
    {column = 1, width = 54}, -- 116
    -- {column = 2, width = 40}, --default switch size
    {column = 3, width = 54},
    },
  column_alignments = {
    {column = 1, alignment = 'middle-right' },
    {column = 2, alignment = 'middle-center'},
    {column = 3, alignment = 'middle-left'  },
    }
  }
-- Create stand-alone names for vanilla switch labels.
styles['er:screenshot-gui-aligned-switch-inactive-label'] = 
  util.table.deepcopy(styles['switch'].inactive_label)
styles['er:screenshot-gui-aligned-switch-active-label'] = 
  util.table.deepcopy(styles['switch'].active_label)

-- styles['er:screenshot-gui-aligned-switch-inactive-label']
  -- .left_click_sound = {{ filename = "__core__/sound/gui-switch.ogg", volume = 0.7 }}
-- styles['er:screenshot-gui-aligned-switch-active-label']
  -- .left_click_sound = {{ filename = "__core__/sound/gui-switch.ogg", volume = 0.7 }}
  
  
  

styles['er:screenshot-gui-bold-green-label'] = {
  type = "label_style",
  parent = "bold_label",
  font_color = {0, 1, 0}
  }

styles['er:screenshot-gui-bold-yellow-label'] = {
  type = "label_style",
  parent = "bold_label",
  font_color = {1, 1, 0}
  }

styles['er:screenshot-gui-bold-red-label'] = {
  type = "label_style",
  parent = "bold_label",
  font_color = {1, 0, 0}
  }
  

  
  
-- local switch_label_width = 38
local switch_label_width = 64

styles['er:screenshot-gui-advanced-option-switch'] = {
  type = 'switch_style',
  parent = 'switch',
  -- width = 116,
  horizontally_stretchable = 'off',
  horizontally_squashable = 'off',
  
  maximum_horizontal_squash_size = 116,
  
  active_label =
  {
    type = "label_style",
    font_color = {241, 190, 100},
    font = "default-bold",
    
    width = switch_label_width,
    horizontally_stretchable = 'off',
    horizontally_squashable = 'off',
    -- size = {switch_label_width,24},
    minimal_width = switch_label_width,
    maximal_width = switch_label_width,
    natural_width = switch_label_width,
    maximum_horizontal_squash_size = 116,  
    
  },
  inactive_label =
  {
    type = "label_style",
    font_color = default_font_color,
    hovered_font_color = {255, 230, 192},
    font = "default",

    width = switch_label_width,
    horizontally_stretchable = 'off',
    horizontally_squashable = 'off',
    -- size = {switch_label_width,24},
    minimal_width = switch_label_width,
    maximal_width = switch_label_width,
    natural_width = switch_label_width,
      
    maximum_horizontal_squash_size = 116,
  },
  
  flow = {},
  }