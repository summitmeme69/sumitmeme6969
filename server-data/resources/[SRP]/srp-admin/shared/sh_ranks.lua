SRP.Admin:AddRank("owner", {
    inherits = "dev",
    issuperadmin = true,
    allowafk = true,
    grant = 101
})

SRP.Admin:AddRank("dev", {
    inherits = "spec",
    issuperadmin = true,
    allowafk = true,
    grant = 100
})

SRP.Admin:AddRank("spec", {
    inherits = "admin",
    issuperadmin = true,
    allowafk = true,
    grant = 99
})

SRP.Admin:AddRank("admin", {
    inherits = "moderator",
    allowafk = true,
    isadmin = true,
    grant = 98
})

SRP.Admin:AddRank("moderator", {
    inherits = "trusted",
    isadmin = true,
    grant = 97
})

SRP.Admin:AddRank("trusted", {
    inherits = "user",
    isadmin = true,
    grant = 96
})

SRP.Admin:AddRank("user", {
    inherits = "",
    grant = 1
})