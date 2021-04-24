SRP.Commands = SRP.Commands or {}
SRP.Commands.Registered = SRP.Commands.Registered or {}

AddEventHandler("srp-base:exportsReady", function()
    addModule("Commands", SRP.Commands)
end)
