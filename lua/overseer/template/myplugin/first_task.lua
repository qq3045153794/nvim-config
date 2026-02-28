return {
  -- Required fields
  name = "build_bundle x86",
  builder = function(params)
    -- This must return an overseer.TaskDefinition
    return {
      -- cmd is the only required field
      cmd = string.format(
        "cd recipes/x86_64_Linux_gcc && ./build_bundle.py -en=false -ec=false -ecfg=false -u=%s -c=Debug -v=%s",
        params.projection, params.version),
      -- additional arguments for the cmd
      -- args = {"-en=false", "-ec=false", "-ecfg=false"},
      -- args = {},
      -- the name of the task (defaults to the cmd of the task)
      name = "build_bundle x86",
      -- set the working directory for the task
      -- additional environment variables
      -- the list of components or component aliases to add to the task
      components = {
        "default",
        { "on_output_quickfix", open = true }
      },
    }
  end,
  -- Optional fields
  desc = "build_bundle x86_64 of task",
  params = {
    version = {
      name = "version", -- 参数名称（显示在UI中）
      type = "string", -- 使用文档中定义的合法类型
      desc = "输入版本号（例如：1.0.0）", -- 详细描述
      default = "", -- 默认值
      order = 1, -- 显示顺序（可选）
      -- 可选：添加验证函数（确保版本号不为空）
      validate = function(value)
        if value == "" then
          return false, "版本号不能为空，请输入有效版本" -- 验证失败时返回错误信息
        end
        return true -- 验证通过
      end,
    },
    projection = {
      name = "projection", -- 参数名称（显示在UI中）
      type = "string", -- 使用文档中定义的合法类型
      desc = "输入项目（例如：wuling）", -- 详细描述
      default = "wuling", -- 默认值
      order = 1, -- 显示顺序（可选）
      -- 可选：添加验证函数（确保版本号不为空）
      validate = function(value)
        if value == "" then
          return false, "项目不能为空，请输入有效版本" -- 验证失败时返回错误信息
        end
        return true -- 验证通过
      end,
    }
  },
  -- Tags can be used in overseer.run_template()
}
