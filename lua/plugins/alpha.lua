local logo = [[
                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████
]]

return {
	"goolord/alpha-nvim",
    lazy = false,
	opts = function()
		local db = require("alpha.themes.dashboard")
		db.section.header.val = vim.split(logo, "\n")
		db.section.buttons.val = {
			db.button("o", " " .. " Open Explorer", ":NvimTreeToggle <CR>"),
			db.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
			db.button(
				"s",
				" " .. " Scratch Buffer",
				":Alpha | setl noswapfile buftype=nofile bufhidden=delete<CR>"
			),
			db.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
		}
		db.section.header.opts.hl = "AlphaHeader"
		db.opts.layout[1].val = 6
		return db
	end,
	config = function(_, db)
		require("alpha").setup(db.opts)
		vim.api.nvim_create_autocmd("User", {
			callback = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime * 100) / 100
				db.section.footer.val = "󱐌 Lazy-loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
