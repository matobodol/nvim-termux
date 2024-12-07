function BuffRunner()
    -- Mengambil informasi tentang file yang sedang dibuka
    local get = {
        src = vim.fn.expand('%'),      -- Path absolut dari file saat ini
        dest = vim.fn.expand('%:r'),   -- Path tanpa ekstensi
        type = vim.fn.expand('%:e'),   -- Ekstensi file (contoh: py, rs, html)
        name = vim.fn.expand('%:t:r'), -- Nama file tanpa ekstensi
        dir = vim.fn.expand('%:p:h')   -- Direktori absolut tempat file berada
    }

    -- Konfigurasi untuk menjalankan berbagai jenis file berdasarkan ekstensi
    local Buffer = {
        -- HTML: Menjalankan server HTTP menggunakan Python
        html = { run = "cd " .. get.dir .. " && python -m http.server 8000" },

        -- Python: Menjalankan file Python
        py = { run = "python3 " .. get.src },

        -- Shell script: Menjalankan file Bash
        sh = { run = "bash " .. get.src },

        -- Fish script: Menjalankan file Fish
        fish = { run = "fish " .. get.src },

        -- Rust: Menjalankan proyek menggunakan Cargo
        rs = { run = "cd " .. get.dir .. " && RUSTFLAGS='-Awarnings' cargo run -q" },

        -- C++: Kompilasi, menjalankan, dan menghapus file biner sementara
        cpp = {
            compile = string.format("g++ %s -o %s ", get.src, get.dest),
            run = string.format("&& %s ", get.dest),
            delTemp = string.format("&& rm -rf %s", get.dest)
        },

        -- Java: Kompilasi, menjalankan, dan menghapus file sementara
        java = {
            compile = string.format("javac %s -d %s ", get.src, get.dest),
            run = string.format("&& cd %s && java %s ", get.dest, get.name),
            delTemp = string.format("&& cd $HOME && rm -rf %s", get.dest)
        },

        -- Kotlin: Kompilasi, menjalankan, dan menghapus file sementara
        kt = {
            compile = string.format("kotlinc %s -include-runtime -d %s.jar ", get.src, get.dest),
            run = string.format("&& java -jar %s.jar ", get.dest),
            delTemp = string.format("&& rm -rf %s.jar", get.dest)
        }
    }

    -- Menyiapkan perintah untuk file berdasarkan ekstensi
    local cmd = ""
    if Buffer[get.type] then
        -- Menggabungkan perintah (compile, run, delete temp) jika tersedia
        for _, action in ipairs({ "compile", "run", "delTemp" }) do
            if Buffer[get.type][action] then
                cmd = cmd .. Buffer[get.type][action]
            end
        end
    else
        -- Pesan error jika jenis file tidak didukung
        print("\n[Err!] File type not setup!\n\nSupported types:\n{sh, fish, cpp, java, kt, py, rs, html}")
        return
    end

    -- Menjalankan perintah jika tersedia
    if cmd ~= "" then
        vim.api.nvim_command(":w")                   -- Menyimpan file sebelum menjalankan
        vim.api.nvim_command("split term://" .. cmd) -- Menjalankan perintah di terminal split
    end

    -- Penanganan khusus untuk HTML
    if get.type == "html" then
        -- Menunggu beberapa saat untuk memastikan server berjalan
        vim.defer_fn(function()
            -- Membuka halaman web di browser default
            vim.fn.system("xdg-open http://localhost:8000/" .. get.name .. "." .. get.type)
        end, 1000) -- Menunggu 1 detik
    end
end

-- Mendaftarkan fungsi BuffRunner sebagai command di Neovim
vim.api.nvim_create_user_command(
    "BuffRun", -- Nama command yang bisa dipanggil di command mode
    function() -- Fungsi yang akan dijalankan
        BuffRunner()
    end,
    { desc = "Run the current buffer based on file type" } -- Deskripsi command
)

vim.keymap.set('n', '<leader>x', ':BuffRun<CR>')

