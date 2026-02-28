return {
  -- 必需字段
  name = "build_bundle android",
  builder = function(params)
    -- 构建命令，拼接版本号和编译选项参数
    local cmd = string.format(
      "cd recipes/armv8_Android_ndk25_api30 && ./build_bundle.py -en=false -ec=false -ecfg=false -u=wuling -c=%s -v=%s",
      params.compile_option,
      params.version
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
  desc = "构建Android平台的bundle（armv8架构，ndk25，api30）", -- 更准确的描述
  params = {
    version = {
      name = "version", -- 更直观的显示名称
      type = "string",
      desc = "请输入版本号（例如：1.0.0）",
      default = "",
      order = 1, -- 优先显示版本号输入
      validate = function(value)
        if value == "" then
          return false, "版本号不能为空！"
        end
        return true
      end,
    },
    compile_option = {
      name = "compile_option ",
      type = "enum", -- 枚举类型，限制可选值
      desc = "选择编译模式（Debug/Release）",
      default = "Release", -- 默认使用Release模式
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
  tags = { "android", "build", "armv8" }
}
