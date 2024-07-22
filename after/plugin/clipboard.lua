function OSC52_copy()
    if vim.v.event.operator == 'y' then
        if vim.v.event.regname == '+' then
            require('osc52').copy_register('+')
        elseif vim.v.event.regname == '*' then
            require('osc52').copy_register('*')
        end
    end
end

vim.api.nvim_create_autocmd('TextYankPost', { callback = OSC52_copy })
