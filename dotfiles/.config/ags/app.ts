import app from "ags/gtk4/app"
import style from "./style.scss"
import TopRightModule from "./widget/TopRight"

app.start({
    // Load your compiled SCSS
    css: style,

    // Spawn the module on all screens
    main() {
        app.get_monitors().map(TopRightModule)
    },

    // Listen for terminal/Waybar commands
    requestHandler(request, res) {
        const args = request.split(" ")

        if (args[0] === "toggle") {
            const win = app.get_window("top-right-module")
            if (win) {
                win.visible = !win.visible
                return res(`Toggled window visibility to ${win.visible}`)
            } else {
                return res("Error: Window not found")
            }
        }
        return res("Unknown request.")
    }
})
