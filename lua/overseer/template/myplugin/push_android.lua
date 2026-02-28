return {
  condition = {
    dir = "/home/xietao/hub/minieye/ics/dms_workflow_wuling",
  },
  -- 必需字段
  name = "push android",
  builder = function(params)
    -- 返回任务定义
    return {
      cmd = "cd expect_script&&./push_android.sh",
      name = "push android",
      components = {
        "default",
        { "on_output_quickfix", open = true }
      },
    }
  end,
  -- 可选字段
  desc = "push android",
}
