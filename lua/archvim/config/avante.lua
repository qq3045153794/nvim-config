require("avante").setup({

  provider = "deepseek",
  -- auto_suggestions_provider = "deepseek",
  providers = {
    claude = {
      endpoint = "https://api.openai-proxy.org/anthropic",
      model = "claude-sonnet-4-20250514",
      timeout = 30000, -- Timeout in milliseconds
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      }
    },
    openai = {
      endpoint = "https://api.openai-proxy.org/v1",
      model = "gpt-4o-mini",
      timeout = 30000, -- Timeout in milliseconds
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 20480,
      }
    }
  },
  vendors = {
    deepseek = {
      __inherited_from = "openai",
      api_key_name = "DEEPSEEK_API_KEY",
      endpoint = "https://api.deepseek.com",
      model = "deepseek-coder",
      max_tokens = 8192,
    },
  },
  -- 其他avante.nvim的设置
  -- completion = {
  --   -- 在补全中自动插入Tab字符
  --   auto_insert_tab = true,
  --   -- 启用类似Cursor风格的Tab自动补全流
  --   cursor_flow = true,
  -- },

  -- UI设置
  -- ui = {
  --   -- 在侧边栏显示的最大行数
  --   max_lines = 30,
  --   -- 启用聊天模式
  --   chat = true,
  --   -- 输入框高度
  --   input_height = 10,
  -- },

  -- 自定义快捷键（可选）
  keymap = {
    -- 在当前光标位置生成代码
    code = "<leader>ac",
    -- 打开侧边栏聊天界面
    toggle = "<leader>at",
    -- 编辑选中的代码块
    edit = "<leader>ae",
  },
  behaviour = {
    auto_suggestions = false, -- 启用自动建议
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
    minimize_diff = true,                        -- 是否在应用代码块时删除未更改的行
    enable_token_counting = true,                -- 是否启用令牌计数。默认为 true。
    auto_add_current_file = true,                -- 打开新聊天时是否自动添加当前文件。默认为 true。
    enable_cursor_planning_mode = false,         -- 是否启用 Cursor 规划模式。默认为 false。
    enable_claude_text_editor_tool_mode = false, -- 是否启用 Claude 文本编辑器工具模式。
    ---@type "popup" | "inline_buttons"
    confirmation_ui_style = "inline_buttons",
  },
  mappings = {
    --- @class AvanteConflictMappings
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    cancel = {
      normal = { "<C-c>", "<Esc>", "q" },
      insert = { "<C-c>" },
    },
    sidebar = {
      apply_all = "A",
      apply_cursor = "a",
      retry_user_request = "r",
      edit_user_request = "e",
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
      remove_file = "d",
      add_file = "@",
      close = { "<Esc>", "q" },
      close_from_input = nil, -- 例如，{ normal = "<Esc>", insert = "<C-d>" }
    },
  },
  selection = {
    enabled = true,
    hint_display = "delayed",
  },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right", -- 侧边栏的位置
    wrap = true,        -- 类似于 vim.o.wrap
    width = 30,         -- 默认基于可用宽度的百分比
    sidebar_header = {
      enabled = true,   -- true, false 启用/禁用标题
      align = "center", -- left, center, right 用于标题
      rounded = true,
    },
    spinner = {
      editing = { "⡀", "⠄", "⠂", "⠁", "⠈", "⠐", "⠠", "⢀", "⣀", "⢄", "⢂", "⢁", "⢈", "⢐", "⢠", "⣠", "⢤", "⢢", "⢡", "⢨", "⢰", "⣰", "⢴", "⢲", "⢱", "⢸", "⣸", "⢼", "⢺", "⢹", "⣹", "⢽", "⢻", "⣻", "⢿", "⣿" },
      generating = { "·", "✢", "✳", "∗", "✻", "✽" }, -- '生成中' 状态的旋转字符
      thinking = { "🤯", "🙄" }, -- '思考中' 状态的旋转字符
    },
    input = {
      prefix = "> ",
      height = 8, -- 垂直布局中输入窗口的高度
    },
    edit = {
      border = "rounded",
      start_insert = true, -- 打开编辑窗口时开始插入模式
    },
    ask = {
      floating = false,    -- 在浮动窗口中打开 'AvanteAsk' 提示
      start_insert = true, -- 打开询问窗口时开始插入模式
      border = "rounded",
      ---@type "ours" | "theirs"
      focus_on_apply = "ours", -- 应用后聚焦的差异
    },
  },
  highlights = {
    ---@type AvanteConflictHighlights
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },
  --- @class AvanteConflictUserConfig
  diff = {
    autojump = true,
    ---@type string | fun(): any
    list_opener = "copen",
    --- 覆盖悬停在差异上时的 'timeoutlen' 设置（请参阅 :help timeoutlen）。
    --- 有助于避免进入以 `c` 开头的差异映射的操作员挂起模式。
    --- 通过设置为 -1 禁用。
    override_timeoutlen = 500,
  },
  suggestion = {
    debounce = 600,
    throttle = 600,
  },

})
