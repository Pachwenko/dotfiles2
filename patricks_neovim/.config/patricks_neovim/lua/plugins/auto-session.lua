-- https://github.com/rmagatti/auto-session
-- :SessionSave " saves a session based on the `cwd` in `root_dir`
-- :SessionSave my_session " saves a session called `my_session` in `root_dir`
--
-- :SessionRestore " restores a session based on the `cwd` from `root_dir`
-- :SessionRestore my_session " restores `my_session` from `root_dir`
--
-- :SessionDelete " deletes a session based on the `cwd` from `root_dir`
-- :SessionDelete my_session " deletes `my_sesion` from `root_dir`
--
-- :SessionDisableAutoSave " disables autosave
-- :SessionDisableAutoSave! " enables autosave (still does all checks in the config)
-- :SessionToggleAutoSave " toggles autosave
--
-- :SessionPurgeOrphaned " removes all orphaned sessions with no working directory left.
--
-- :SessionSearch " open a session picker, uses Telescope if installed, vim.ui.select otherwise
--
-- :Autosession search " open a vim.ui.select picker to choose a session to load.
-- :Autosession delete " open a vim.ui.select picker to choose a session to delete.
return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Downloads", "/" },
		auto_session_enabled = false,
		auto_session_use_git_branch = false,
		auto_restore_enabled = false,
		auto_save = false,
		-- log_level = 'debug',
	},
}
