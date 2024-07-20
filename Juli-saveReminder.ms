-- WARNING: This script must be saved in "C:\Program Files\Autodesk\3ds Max 2024\stdplugs\stdscripts\". Not in the 'usermacros' folder.

global SR_timer = dotNetObject "System.Windows.Forms.Timer"

SR_timer.interval = 1200000 --20 minutos
SR_timer.start()

fn SR_fn = (

	SR_timer.stop()
	rollout SR_roll "Autosave" width:250 (
		spinner lbl_interval "Remind me in " type:#integer range:[0,120,(SR_timer.interval/60000)] fieldwidth:30 pos:[5,9]
		label lbl "minutes." pos:[120,9]
		button lbl_btn "Save Dialog" pos:[170,5]

		on SR_roll close do (
			if lbl_interval.value != 0 then (
				SR_timer.interval = lbl_interval.value * 60000 --20 minutos
				SR_timer.start()
				format "Set interval in % minutes.\n" lbl_interval.value
			)
			else (
				SR_timer.stop()
				format "Stopped timer.\n"
			)
		)

 		on lbl_btn pressed do ( CheckForSave() )

	)

	try (DestroyDialog SR_roll) catch()
	createDialog SR_roll
)

dotnet.addEventHandler SR_timer "tick" SR_fn

macroscript MacroScript_SaveReminder

category:"Juli"
tooltip:"Save Reminder"
buttonText:"Save Reminder"

(
	SR_fn()
)