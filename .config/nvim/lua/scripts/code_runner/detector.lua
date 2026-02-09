local M = {}

-- simple detect system
-- easy to modified
function M.get_build_command()
	if vim.fn.filereadable("build.sh") == 1 then
		return "bash build.sh"
	elseif vim.fn.filereadable("Makefile") == 1 then
		return "make"
	elseif vim.fn.filereadable("CMakeLists.txt") == 1 then
		return "cmake"
	end
	return nil
end

return M
