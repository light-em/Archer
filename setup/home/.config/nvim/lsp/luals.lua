-- Have to install lua manually in system at /usr/share/lua

return {
    cmd = {'lua-language-server'},
    filetypes = {'lua'},
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    settings = { Lua = {
        runtime = { 
            version = 'Lua 5.4',
            path = {
                '?.lua',
                '?/init.lua',
                '/usr/share/5.4/?.lua',
                '/usr/share/lua/5.4/?/init.lua'
            }
        },
        workspace = {
            library = { '/usr/share/lua/5.4' },
            checkThirdParty = false,
        }
    }}
}
