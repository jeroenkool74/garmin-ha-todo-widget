# Home Assistant Todo Widget

Garmin Connect IQ widget to read and manage a Home Assistant todo/shopping list from your wrist.

## Configuration
All runtime settings live in `source/Config.mc`:
- `baseUrl`: Base URL of your Home Assistant instance (no trailing slash).
- `longLivedAccessToken`: Long-lived access token (do not commit a real token).
- `listTitle`: Title shown at the top of the list.
- `entityId`: Todo entity to control in Home Assistant.
- Translation strings for on-device text (`clickSelect`, `deselect`, `delete`, `loading`).

Add your watch model to `manifest.xml` as a build target.

To change the name that is visible in the widget list, change the app name in `resources/strings/strings.xml`

## Building
1) Install the Monkey C SDK.
2) Install VS Code and the Monkey C extension.
3) Open the repository in VS Code. 
4) Press `Ctrl+Shift+P` → `Monkey C: Verify Installation`.
5) Press `Ctrl+Shift+P` → `Monkey C: Generate a Developer Key`.
6) Press `Ctrl+Shift+P` → `Monkey C: Build for device`, select your watch, and choose a release build. The `.prg` file will be written to the path you choose.

## Installing on the watch
Connect the watch over USB, open the `GARMIN/APPS` folder, and copy the built `.prg` file into it. Eject safely before unplugging.

## Buy me a coffee

If this project helped you, consider supporting me:

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-support-yellow)](https://buymeacoffee.com/jeroenkool74)
