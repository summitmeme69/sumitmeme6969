Config = {
	DiscordToken = "ODAyNTkzOTQ1ODI1NDQzODYw.YAxf3A.2bY6KzISij3qXyr5IHqNprzFNuI",
	GuildId = "801687059005308968",

	-- Format: ["Role Nickname"] = "Role ID" You can get role id by doing \@RoleName
	Roles = {
		["TestRole"] = "Some Role ID" -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
	}
}
