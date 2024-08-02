import Widget from 'resource:///com/github/Aylur/ags/widget.js';

import PopupWindow from "../.widgethacks/popupwindow"

export const passwordWindow = () => PopupWindow({
    monitor,
    name: `passwordWindow${monitor}`,
    className: 'menu',
    keymode: 'exclusive',
    layer: 'overlay',
    child: Widget.Box ({
        children: [
            clickCloseRegion({ name: 'passwordWindow' }),
            Widget.Entry({
                className: 'entry-input',
                hpack: 'center',
                visibility: false,
                on_accept: ({ pass }) => {
                    Utils.execAsync(`echo '${pass}'' | sudo -S tailscale up`).catch(print).then(() => {
                        App.closeWindow('passwordWindow')
                    })
                },
            }),
            clickCloseRegion({ name: 'passwordWindow' }),
        ],
    }),
}) 

export default passwordWindow;