-- Welcome Message
print("\n")
MsgC(Color(255, 0, 0), " <=========> ")
print("\n")
MsgC(Color(255, 0, 0), " > ") MsgC(Color(0,255,0), "Shitty HUD Loaded!\n")
MsgC(Color(255, 0, 0), " > ") MsgC(Color(0,255,0), "Version: ") MsgC(Color(255,0,0), "1.3.1")
print("\n")
MsgC(Color(255, 0, 0), " > ") MsgC(Color(0,255,0), "This is a shitty HUD don't use it unless you fixed it.")
print("\n")
MsgC(Color(255, 0, 0), " <=========> ") MsgC(Color(0,255,0))
print("\n")

if SERVER then
	resource.AddFile("resource/fonts/BebasNeue.otf")
end