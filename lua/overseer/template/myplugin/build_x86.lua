return {
  -- 必需字段
  name = "build x86",
  builder = function(params)
    -- 构建命令，拼接版本号和编译选项参数
    local cmd = string.format(
      "if [ -d recipes/x86_64_u2004 ]; then cd recipes/x86_64_u2004; else cd recipes/x86_64_Linux_gcc; fi && ./build.sh -c=%s",
      params.compile_option
    )
    -- 返回任务定义
    return {
      cmd = cmd,
      name = "build_bundle android",
      components = {
        "default",
        { "on_output_quickfix", open = true }
      },
    }
  end,
  -- 可选字段
  desc = "构建X86平台的build", -- 更准确的描述
  params = {
    compile_option = {
      name = "compile_option ",
      type = "enum", -- 枚举类型，限制可选值
      desc = "选择编译模式（Debug/Release）",
      default = "Debug", -- 默认使用Release模式
      order = 2, -- 其次显示编译选项
      choices = { "Debug", "Release" }, -- 仅保留两种选项
      validate = function(value)
        -- 验证值是否为允许的选项（双重保障）
        if value ~= "Debug" and value ~= "Release" then
          return false, "仅支持 Debug 和 Release 模式！"
        end
        return true
      end,
    }
  },
  -- 标签：用于快速筛选任务模板
  tags = { "build" }
}
