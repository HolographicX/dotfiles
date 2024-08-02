import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import PopupWindow from '../.widgethacks/popupwindow';
import clickCloseRegion from '../.commonwidgets/clickcloseregion';
import App from 'resource:///com/github/Aylur/ags/app.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

export default () => PopupWindow({
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
