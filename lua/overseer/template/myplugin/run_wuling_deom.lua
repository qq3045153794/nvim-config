
return {
  condition = {
    dir = "/home/xietao/hub/minieye/ics/dms_workflow_wuling",
  },
  -- Required fields
  name = "run_wuling_demo",
  builder = function(params)
    -- This must return an overseer.TaskDefinition
    return {
      -- cmd is the only required field
      cmd = "cd build/bundle/x86_64_Linux_gcc/dms.d && ./demo -d . -i ./test_image.png",
      name = "run_wuling_demo",
      strategy = "toggleterm",
      components = {
        "default",
        "on_output_summarize",  -- 汇总输出
        "on_exit_set_status",   -- 设置任务状态
        "on_complete_notify",   -- 完成时通知
        "on_output_quickfix",   -- 将输出发送到 quickfix
        },
    }
  end,
  -- Optional fields
  desc = "build_bundle x86_64 of task",
  -- Tags can be used in overseer.run_template()
}

