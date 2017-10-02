-- modinfo read by stlrel from http://github.com/stellaris-mods/scripts
return {
	path = "powah",
	name = "Ship Power Stations",
	tags = { "Graphics", "Fixes", "Technologies" },
	picture = "thumb.png",
	supported_version = "1.8.*",
	remote_file_id = 776095610,
	readme = "readme.md",
	steambb = "steam.bbcode",
	-- stlrel uses git-archive, which means that any files in
	-- .gitignore are not included. If you want to include any,
	-- you need to add relative paths here.
	zip = {
		-- include all files from .gitignore
		gitignore = true,
		files = {} -- can contain relative file paths
	},
	exclude = { "readme.md", "steam.bbcode", ".git", ".gitignore" }
}
