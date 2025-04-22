return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ensure_installed = {
            "python-debugpy", -- Python
            "js-debug-adapter", -- JavaScript/TypeScript
            "codelldb", -- C, C++, Rust
          },
        },
      },
      -- DAP UI 插件
      { "rcarriga/nvim-dap-ui", name = "dapui", config = true },
      -- 可选：虚拟文本显示调试信息
      -- { "theHamsta/nvim-dap-virtual-text", config = true },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "添加/删除断点" },
      { "<leader>dus", function() require("dapui").setup() end, desc = "设置 DAP UI" },
      { "<leader>duc", function() require("dapui").close() end, desc = "关闭 DAP UI" },
      { "<leader>dut", function() require("dapui").toggle() end, desc = "切换 DAP UI" },
      { "<leader>dc", function() require("dap").continue() end, desc = "继续" },
      { "<leader>dj", function() require("dap").step_over() end, desc = "步过" },
      { "<leader>dk", function() require("dap").step_into() end, desc = "步入" },
      { "<leader>do", function() require("dap").step_out() end, desc = "步出" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "打开 REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "运行上次配置" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "终止" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 设置 dap-ui 监听器以自动打开/关闭 UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- 适配器配置示例 (根据需要添加更多)
      -- 确保适配器已通过 Mason 或手动安装

      -- Python (使用 debugpy - 通过 Mason 安装: "python-debugpy")
      dap.adapters.python = {
        type = 'executable',
        -- 使用 Mason 安装的路径
        command = vim.fn.stdpath("data") .. '/mason/bin/debugpy-adapter',
        -- 或者直接指定 python 解释器路径来运行 adapter
        -- command = '/path/to/virtualenv/bin/python',
        -- args = { '-m', 'debugpy.adapter' }
      }
      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = '启动文件',
          program = '${file}', -- 启动当前文件
          pythonPath = function()
            -- debugpy 支持使用与启动 debugpy 不同的解释器来启动应用程序。
            -- return '/path/to/python' -- 指定 python 解释器路径
            return vim.fn.exepath('python3') or vim.fn.exepath('python') -- 优先使用 python3，否则使用 PATH 中的 python
          end,
        },
      }

      -- Javascript/TypeScript (使用 js-debug-adapter - 通过 Mason 安装: "js-debug-adapter")
      -- 参考: https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
      dap.adapters.node2 = {
        type = 'executable',
        -- 使用 Mason 安装的路径
        command = vim.fn.stdpath("data") .. '/mason/bin/js-debug-adapter',
        -- 或者直接指定 node 路径
        -- command = 'node',
        -- args = { vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js' },
        -- args = { os.getenv("HOME") .. "/dev/microsoft/vscode-js-debug/out/src/dapDebugServer.js" }, -- vscode-js-debug 安装路径
      }
      local js_ts_config = {
        {
          name = '启动文件',
          type = 'node2',
          request = 'launch',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal', -- 控制台类型
        },
        {
          name = '附加到进程',
          type = 'node2',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = 'inspector',
          console = 'integratedTerminal',
        },
      }
      dap.configurations.javascript = js_ts_config
      dap.configurations.typescript = js_ts_config -- TypeScript 复用 Javascript 配置

      -- C/C++/Rust (使用 codelldb - 通过 Mason 安装: "codelldb")
      dap.adapters.codelldb = {
        type = 'executable',
        -- 使用 Mason 安装的路径
        command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
        -- 或者直接指定 codelldb 路径
        -- command = '/path/to/codelldb',
        name = 'codelldb',
      }
      local cpp_c_rust_config = {
        {
          name = "启动文件",
          type = "codelldb",
          request = "launch",
          program = function()
            -- 要求用户输入可执行文件路径
            return vim.fn.input('要调试的可执行文件路径: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {}, -- 如果需要传递命令行参数
          -- 如果需要设置环境变量
          -- env = {
          --   { name = "DEBUG", value = "1" }
          -- },
        },
      }
      dap.configurations.cpp = cpp_c_rust_config
      dap.configurations.c = cpp_c_rust_config
      dap.configurations.rust = cpp_c_rust_config


    end,
  },
}
