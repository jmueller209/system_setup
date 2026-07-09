import { Astal } from "ags/gtk4"
import app from "ags/gtk4/app"
import Gtk from "gi://Gtk?version=4.0"

export default function TopRightModule(monitor: any) {
    const { TOP, RIGHT } = Astal.WindowAnchor

    return (
        <window
            name="top-right-module"
            gdkmonitor={monitor}
            anchor={TOP | RIGHT}
            exclusivity={Astal.Exclusivity.NORMAL}
            layer={Astal.Layer.TOP}
            visible={false} 
            application={app}
        >
            <box cssClasses={["module-container"]} orientation={Gtk.Orientation.VERTICAL}>
                <label cssClasses={["header"]} label="Control Center" />
                
                <box cssClasses={["content"]} orientation={Gtk.Orientation.VERTICAL}>
                    <label label="Your widgets will go here." />
                    
                    <button 
                        cssClasses={["close-btn"]}
                        onClicked={() => {
                            const win = app.get_window("top-right-module")
                            if (win) win.visible = false
                        }}
                    >
                        <label label="Close" />
                    </button>
                </box>
            </box>
        </window>
    )
}
EOF
