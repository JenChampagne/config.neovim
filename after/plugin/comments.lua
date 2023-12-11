require('better-comment').Setup({
    tags = {
        -- Ticket IDs like PRJ-123
        {
            name = "^[^%w]+%u+%-%d+",
            fg = "black",
            bg = "yellow",
            bold = true,
            virtual_text = "",
        },
    }
})
